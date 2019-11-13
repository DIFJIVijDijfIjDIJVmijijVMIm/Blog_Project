package com.cos.test;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cos.models.Comment;
import com.google.gson.Gson;

@WebServlet("/test/reply")
public class ReplyTest extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	
    public ReplyTest() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/plain; charset=UTF-8");	//MIME 타입
		
		//(1) Json 데이터를 받기, getReader()
		BufferedReader in = request.getReader();
		String replyJS = in.readLine();
		
		//(2) Json 데이터 sysout으로 출력해보기
		System.out.println(replyJS);
		
		//(3) Json 데이터를 java 오브젝트로 변환(Gson 라이브러리, fromJson())
		Gson gson = new Gson();
		Comment reply = gson.fromJson(replyJS, Comment.class);
		
		//(4) java 오브젝트를 sysout으로 출력해보기
		System.out.println("id : " + reply.getId());	//숫자 null은 0으로 떨어짐.
		System.out.println("boardId : " + reply.getBoardId());
		System.out.println("userId : " + reply.getUserId());
		System.out.println("content" + reply.getContent());
		System.out.println("createDate : " + reply.getCreateDate());	//문자열은 null
		
		PrintWriter out = response.getWriter();
		out.print("ok");
		out.flush();
		
	}

}
