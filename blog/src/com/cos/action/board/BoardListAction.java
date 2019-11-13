package com.cos.action.board;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cos.action.Action;
import com.cos.models.Board;
import com.cos.util.Utils;

import dao.BoardDao;

public class BoardListAction implements Action{
	
	private final static String TAG = "BoardListAction : ";
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(request.getParameter("page") == null) return;
		
		int page = Integer.parseInt(request.getParameter("page"));
		
		//page <= 0 혹은 page > maxNum 버튼 비활성화
		
		if(page < 0) {
			page = 1;
		}
		
		BoardDao bDao = new BoardDao();
		List<Board> boards = bDao.findAll(page);
		List<Board> hotBoards = bDao.findOrderByReadCountDesc();
		
		Utils.setPreviewImg(boards);		//이미지를 previewImg에 저장
		Utils.setPreviewContent(boards);// 이미지 태그 제거
		Utils.setPreviewImg(hotBoards);	//이미지를 previewImg에 저장(추가)
		
		request.setAttribute("boards", boards);
		request.setAttribute("hotBoards", hotBoards);
		
		//request, response 객체를 한번 생성된 이후에 없어지지않게 살리는 방법
		RequestDispatcher dis = request.getRequestDispatcher("board/list.jsp");
		dis.forward(request, response);
		
	}
}
