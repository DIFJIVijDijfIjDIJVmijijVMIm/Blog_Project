package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.cos.models.Board;
import com.cos.util.DBClose;

public class BoardDao {

	private Connection conn; // MySQL과 연결하기 위해 필요
	private PreparedStatement pstmt; // Query 문을 작성 - 실행 하기 위해 필요
	private ResultSet rs; // 결과를 보관할 커서
	
	//===============================================DELETE
		public int update(Board board) {
			
			final String SQL = "UPDATE board SET title = ?, content = ? WHERE id = ?";
			
			conn = DBConn.getConnection();
			
			try {
				
				pstmt = conn.prepareStatement(SQL);
				
				pstmt.setString(1, board.getTitle());
				pstmt.setString(2, board.getContent());
				pstmt.setInt(3, board.getId());
				
				int result = pstmt.executeUpdate();
				
				return result;
				
			} catch (Exception e) {
				
				e.printStackTrace();
				
			} finally {
				
				DBClose.close(conn, pstmt);
				
			}
			return -1;
		}
		//===============================================DELETE
		
	
	//===============================================DELETE
	public int delete(int id) {
		
		final String SQL = "DELETE FROM board WHERE id = ?";
		
		conn = DBConn.getConnection();
		
		try {
			
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setInt(1, id);
			
			int result = pstmt.executeUpdate();
			
			return result;
			
		} catch (Exception e) {
			
			e.printStackTrace();
			
		} finally {
			
			DBClose.close(conn, pstmt);
			
		}
		return -1;
	}
	//===============================================DELETE
	
	
	//===============================================FindOrderByReadCountDesc
	//인기리스트 3건 가져오기
	public List<Board> findOrderByReadCountDesc(){
		
		final String SQL = "SELECT * FROM board ORDER BY readCount DESC limit 3";
		
		conn = DBConn.getConnection();
		
		List<Board> boards = new ArrayList<>();
		
		try {
						
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Board board = new Board();
				board.setId(rs.getInt("id"));
				board.setUserId(rs.getInt("userId"));
				board.setTitle(rs.getString("title"));
				board.setContent(rs.getString("content"));
				board.setReadCount(rs.getInt("readCount"));
				board.setCreateDate(rs.getTimestamp("createDate"));
				
				boards.add(board);
								
			}
			
			return boards;
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, pstmt, rs);
		}
		
		return null;
		
	}
	//===============================================FindOrderByReadCountDesc
	
	
	//===============================================IncereaseReadCount
	public int increaseReadCount(int id) {

		final String SQL = "UPDATE board SET readCount = readCount + 1 WHERE id = ?";

		conn = DBConn.getConnection();

		try {
			pstmt = conn.prepareStatement(SQL);

			pstmt.setInt(1, id);
			

			int result = pstmt.executeUpdate(); // 변경된 튜플의 개수를 리턴

			return result;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// conn.close() 이런거 다 해줘야 되는데 일일이 넣기 귀찮으니까 util 만들어서 가져오자.
			DBClose.close(conn, pstmt);
		}
		return -1;
	}
	//===============================================IncereaseReadCount
	
	
	// ===============================SAVE============================
	public int save(Board board) {
		
		final String SQL = "INSERT INTO board(userId, title, content, createDate) VALUES(?, ?, ?, now())";

		conn = DBConn.getConnection();

		try {
			pstmt = conn.prepareStatement(SQL);

			pstmt.setInt(1, board.getUserId());
			pstmt.setString(2, board.getTitle());
			pstmt.setString(3, board.getContent());

			int result = pstmt.executeUpdate(); // 변경된 튜플의 개수를 리턴

			return result;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// conn.close() 이런거 다 해줘야 되는데 일일이 넣기 귀찮으니까 util 만들어서 가져오자.
			DBClose.close(conn, pstmt);
		}
		return -1;
	}
	// ===============================SAVE============================
	
	
	// ===============================FindAll===========================
	//리스트보기	SELECT * FROM board ORDER BY id DESC
	public List<Board> findAll() {
		
		final String SQL = "SELECT * FROM board ORDER BY id DESC";
		List<Board> boards = new ArrayList<>();
		conn = DBConn.getConnection();
		
		try {
			
			
			
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Board board = new Board();
				board.setId(rs.getInt("id"));
				board.setUserId(rs.getInt("userId"));
				board.setTitle(rs.getString("title"));
				board.setContent(rs.getString("content")+"");
				board.setReadCount(rs.getInt("readCount"));
				board.setCreateDate(rs.getTimestamp("createDate"));
				
				boards.add(board);
				System.out.println("findAll :  " + boards.size());
				
			}
			return boards;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, pstmt, rs);
		}
		
		return null;
	}
	// ===============================FindAll===========================
	
	
	// ===============================FindAll(int page)=====================
		//리스트보기	SELECT * FROM board ORDER BY id DESC
		public List<Board> findAll(int page) {
			
			final String SQL = "SELECT * FROM board b, user u WHERE b.userId = u.id ORDER BY b.id DESC limit ?, 3;";
			List<Board> boards = new ArrayList<>();
			conn = DBConn.getConnection();
			
			try {
				
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, ((page-1)*3));
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					Board board = new Board();
					board.setId(rs.getInt("b.id"));
					board.setUserId(rs.getInt("b.userId"));
					board.setTitle(rs.getString("b.title"));
					board.setContent(rs.getString("b.content"));
					board.setReadCount(rs.getInt("b.readCount"));
					board.setCreateDate(rs.getTimestamp("b.createDate"));
					board.getUser().setUsername(rs.getString("u.username"));
					board.getUser().setUserProfile(rs.getString("u.userProfile"));
					
					boards.add(board);
					System.out.println("findAll :  " + boards.size());
					
				}
				return boards;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				DBClose.close(conn, pstmt, rs);
			}
			
			return null;
		}
	// ===============================FindAll(int page)=====================
	
	
	// ===============================FindById==========================
		//상세 보기 SELECT * FROM board WHERE id = ?
		public Board findById(int id) {
			
			final String SQL = "select * from board b, user u where b.userId = u.id and b.id = ?";
			
			List<Board> boards = new ArrayList<>();
			
			conn = DBConn.getConnection();
			
			try {
				
				pstmt = conn.prepareStatement(SQL);
				
				pstmt.setInt(1, id);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					Board board = new Board();
					board.setId(rs.getInt("b.id"));
					board.setUserId(rs.getInt("b.userId"));
					board.setTitle(rs.getString("b.title"));
					board.setContent(rs.getString("b.content"));
					board.setReadCount(rs.getInt("b.readCount"));
					board.setCreateDate(rs.getTimestamp("b.createDate"));
					board.getUser().setUsername(rs.getString("u.username"));
					board.getUser().setUserProfile(rs.getString("u.userProfile"));
					
					return board;
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				DBClose.close(conn, pstmt, rs);
			}
			
			return null;
		}		
		// ===============================FindById==========================
	
		
}
