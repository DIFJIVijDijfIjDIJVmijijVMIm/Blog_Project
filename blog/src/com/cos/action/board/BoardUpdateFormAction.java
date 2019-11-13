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

public class BoardUpdateFormAction implements Action{
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int id = Integer.parseInt(request.getParameter("id"));
		
		BoardDao dao = new BoardDao();
		
		Board board = dao.findById(id);
		
		if(board != null) {
			
			//board를 request에 담고 dispatchar로 이동
			request.setAttribute("board", board);
			
			System.out.println("UpdateForm : content : " + board.getContent());
			
			RequestDispatcher dis = request.getRequestDispatcher("board/update.jsp");
			dis.forward(request, response);		
			
		}else {
			
			Script.back(response);
			
		}
		
	}
}
