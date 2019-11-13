package com.cos.action.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cos.action.Action;

public class UserLogoutAction implements Action{
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//세션 만료
		HttpSession session = request.getSession();	//세션 불러오고
		session.invalidate();//세션 무효화	//얘는 세션 전부 날리는 건데 로그 아웃하는 마당에 세션 남겨서 뭐해 다 날려
		
//		session.removeAttribute("username");		//얘는 세션 하나만 정해서 날리는 거고
		
		response.sendRedirect("/blog/index.jsp");
		
	}
}
