package com.cos.action.board;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cos.action.Action;
import com.cos.models.Board;
import com.cos.util.Script;

import dao.BoardDao;

public class BoardUpdateAction implements Action{
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int id = Integer.parseInt(request.getParameter("id"));
		
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		System.out.println("BoardUpdateAction : content :"+content);
		BoardDao dao = new BoardDao();
		
		Board board = new Board();
		board.setId(id);
		board.setTitle(title);
		board.setContent(content);
		
		int result = dao.update(board);
		
		if(result == 1) {
			
			//board를 request에 담고 dispatchar로 이동
			request.setAttribute("board", board);
			
			RequestDispatcher dis = request.getRequestDispatcher("board/detail.jsp");
			dis.forward(request, response);		
			
		}else {
			Script.back(response);
		}
		
	}
}
