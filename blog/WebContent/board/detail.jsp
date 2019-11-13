<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/nav.jsp"%>

<c:if test="${empty sessionScope.user.username}">
	<script>
		alert('인증이 안된 유저입니다.');
		location.href = "/blog/user/login.jsp";
	</script>
</c:if>

<!--================Blog Area =================-->
<section class="blog_area single-post-area">
	<div class="container">
		<div class="row">
			<div class="col-lg-2"></div>
			<div class="col-lg-8">
				<div class="main_blog_details">
					<a href="#"><h4>${board.title}</h4></a>
					<div class="user_details">
						<div class="float-left">
							<a href="/blog/board?cmd=updateForm&id=${board.id}">Update</a> <a href="/blog/board?cmd=delete&id=${board.id}">Delete</a>
						</div>
						<div class="float-right">
							<div class="media">
								<div class="media-body">
									<h5>${board.user.username}</h5>
									<p>${board.createDate}</p>
								</div>
								<div class="d-flex">
									<img src="${board.user.userProfile}" alt="" style="width: 60px; height: 60px">
								</div>
							</div>
						</div>
					</div>
					<!-- 본문 시작 -->
					<p>${board.content}</p>
					<!-- 본문 끝 -->
					<hr />
				</div>

				<!-- before -->
				<!-- 댓글 시작 -->
				<div class="comments-area" id="comments-area">
					<!-- prepend -->
					<!-- 댓글 아이템 시작 -->
					<c:forEach var="comment" items="${comments}">
						<div class="comment-list" id="comment-id-${comment.id}">
							<div class="single-comment justify-content-between d-flex">
								<div class="user justify-content-between d-flex">
									<div class="thumb">
										<img src="${comment.user.userProfile}" alt="" style="width: 60px; height: 60px">
									</div>
									<div class="desc">
										<h5>
											<a href="#">${comment.user.username}</a>
										</h5>
										<p class="date">${comment.createDate}</p>
										<p class="comment">${comment.content}</p>
									</div>
								</div>
								<div class="reply-btn">
									<button onClick="commentDelete(${comment.id})" class="btn-reply text-uppercase">
										<i class="fa fa-trash" style="font-size: 20px;"></i>
									</button>
									<button onClick="replyListShow(${comment.id})" class="btn-reply text-uppercase">
										<i class="fa fa-file" style="font-size: 18px;"></i>
									</button>
									<button onClick="replyForm(${comment.id}, ${sessionScope.user.id})" class="btn-reply text-uppercase">
										<i class="fa fa-edit" style="font-size: 15px;"></i>
									</button>
								</div>
							</div>
						</div>

					</c:forEach>
					<!-- ap0pend -->
					<!-- 댓글 아이템 끝 -->

				</div>
				<!-- after -->
				<!-- 댓글 끝 -->


				<!-- 댓글 쓰기 시작 -->
				<div class="comment-form" style="margin-top: 0px;">
					<h4 style="margin-bottom: 20px">Leave a Reply</h4>
					<form id="comment-submit">
						<input type="hidden" name="userId" value="${sessionScope.user.id }" /> <input type="hidden" name="boardId" value="${board.id }" />
						<div class="form-group">
							<textarea id="content" style="height: 60px" class="form-control mb-10" rows="2" name="content" placeholder="Messege" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Messege'"
								required=""></textarea>
						</div>
						<button type="button" onClick="commentWrite()" class="primary-btn submit_btn">Post Comment</button>
					</form>
				</div>
				<!-- 댓글 쓰기 끝 -->
				<div class="col-lg-2"></div>
			</div>
		</div>
</section>
<!--================Blog Area =================-->

<%@ include file="/include/footer.jsp"%>

<!-- ==============Comment Script=============== -->
<script>

function commentItemForm(id, username, content, createDate, userProfile){
    var commentItem = "<div class='comment-list' id='comment-id-"+id+"'> ";
    commentItem += "<div class='single-comment justify-content-between d-flex'> ";
    commentItem += "<div class='user justify-content-between d-flex'> ";
    commentItem += "<div class='thumb'> <img src='"+userProfile+"' alt='' style='width:60px; height:60px'> </div> ";
    commentItem += "<div class='desc'><h5><a href='#'>"+username+"</a></h5> ";
    commentItem += "<p class='date'>"+createDate+"</p><p class='comment'>"+content+"</p></div></div> ";
    commentItem += "<div class='reply-btn'>";
    commentItem += "<button onClick='commentDelete("+id+")' class='btn-reply text-uppercase' style='display:inline-block; float:left; margin-right:10px;'>삭제</button>";
    commentItem += "<button onClick='replyListShow("+id+")' class='btn-reply text-uppercase'  style='display:inline-block; float:left; margin-right:10px;'>보기</button>";
    commentItem += "<button onClick='replyForm("+id+")' class='btn-reply text-uppercase'>쓰기</button></div></div></div>";
    console.log(commentItem);
    return commentItem;
}

	function commentWriteForm(id, username, content, createDate, userProfile){
	    var comment_list = "<div class='comment-list' id='comment-id-"+id+"'> ";
	    comment_list += "<div class='single-comment justify-content-between d-flex'> ";
	    comment_list += "<div class='user justify-content-between d-flex'> ";
	    comment_list += "<div class='thumb'> <img src='"+userProfile+"' alt='' style='width:60px; height:60px'> </div> ";
	    comment_list += "<div class='desc'><h5><a href='#'>"+username+"</a></h5> ";
	    comment_list += "<p class='date'>"+createDate+"</p><p class='comment'>"+content+"</p></div></div> ";
	    comment_list += "<div class='reply-btn'>";
	    comment_list += "<button onClick='commentDelete("+id+")' class='btn-reply text-uppercase' style='display:inline-block; float:left; margin-right:10px;'>삭제</button>";
	    comment_list += "<button onClick='replyListShow("+id+")' class='btn-reply text-uppercase'  style='display:inline-block; float:left; margin-right:10px;'>보기</button>";
	    comment_list += "<button onClick='replyForm("+id+")' class='btn-reply text-uppercase'>쓰기</button></div></div></div>";
	    
	    return comment_list;
	}
	
	//comment 쓰기
	function commentWrite(){
		var comment_submit_string = $("#comment-submit").serialize();
		console.log("이건 나오나 : " + comment_submit_string);
		$.ajax({
			method: "POST",
			url: "/blog/api/comment?cmd=write",
			data: comment_submit_string,
			contentType: "application/x-www-form-urlencoded; charset=utf-8",
			dataType: "json",
			success: function(comment) {				
				
				//화면에 적용
				 var comment_et = commentItemForm(comment.id, comment.user.username, comment.content, comment.createDate, comment.user.userProfile);
				$("#comments-area").append(comment_et);
				$("#content").val("");
			},
			error: function(xhr){
				console.log(xhr.status);
	            console.log(xhr);

			}
		});
		
	}

	//comment 삭제
	function commentDelete(comment_id){	//자바스크립트는 하이픈 사용 불가
		$.ajax({
			method: "POST",
			url: "/blog/api/comment?cmd=delete",
			data: comment_id + "",
			contentType: "text/plain; charset=utf-8",
			success: function(r){
				console.log(r);
				if(r === "ok"){
					$("#comment-id-"+comment_id).remove();
				}
				//해당 엘레멘트(DOM)을 찾아서 remove() 해주면 됨.
			},
			error: function(xhr){
				alert();
			}
		});
	}
	
	function replyItemForm(id, username, content, createDate, userProfile){
	      var replyItem = "<div class='comment-list left-padding' id='reply-id-"+id+"'>";
	      replyItem+= "<div class='single-comment justify-content-between d-flex'>";
	      replyItem+= "<div class='user justify-content-between d-flex'>";
	      replyItem+= "<div class='thumb'><img src='"+userProfile+"' style='width:50px; height:50px'></div>";
	      replyItem+= "<div class='desc'><h5><a href='#'>"+username+"</a></h5>";
	      replyItem+= "<p class='date'>"+createDate+"</p>";
	      replyItem+= "<p class='comment'>"+content+"</p>";
	      replyItem+= "</div></div><div class='reply-btn'><button onClick='replyDelete("+id+")' class='btn-reply text-uppercase'>삭제</button>";
	      replyItem+= "</div></div></div>";
	      
	      return replyItem;
	   }
	
	var replyListShowSwitch;
	//reply 보기 - ajax
	function replyListShow(comment_id){
		$.ajax({
			method: "POST",
			url: "/blog/api/reply?cmd=list",
			data: comment_id+"",
			contentType: "text/plain; charset=utf-8",
			dataType: "json",
			success: function(replys){	//javascript object
				
				if(replyListShowSwitch == 0 || replyListShowSwitch == null){
					console.log("replyListShowSwitch : "+replyListShowSwitch);
					for(reply of replys){
						//잘 받았으면 화면에 표시하면 됨.
						console.log(reply);
						var reply_et = replyItemForm(reply.id, reply.user.username, reply.content, reply.createDate, reply.user.userProfile);
						console.log(reply_et);
						$("#comment-id-"+reply.commentId).after(reply_et);
					}
					replyListShowSwitch = 1;
					
				}else {
					for(reply of replys){
						console.log("replyListShowSwitch : "+replyListShowSwitch);
						//잘 받았으면 화면에 표시하면 됨.
						
						$("#reply-id-"+reply.id).remove();
					}
					
					replyListShowSwitch = 0;
				}
				
			},
			error: function(xhr){
				console.log(xhr);
			}
		});
	}
	
	//reply 삭제
	function replyDelete(reply_id){
		$.ajax({
			method: "POST",
			url: "/blog/api/reply?cmd=delete",
			data: reply_id+"",
			contentType: "text/plain; charset=utf-8",
			success: function(result){
				if(result == "ok"){
					//해당 엘레멘트 삭제
					$("#reply-id-"+reply_id).remove();
				}
			},
			error: function(xhr){
				console.log(xhr);
			}
		});
	}
	
	var replyFormSwitch;
	//reply 쓰기 - 화면에 로딩!!
	function replyForm(comment_id, user_id){
		/* <input type='hidden' name='userId' value='"+user_id+"'/> */
		if(replyFormSwitch == 0 || replyFormSwitch == null){
			console.log("comment_id :" + comment_id);
			var reply_form_inner = "<h4 style='margin-bottom:20px'>Leave a Reply</h4><form id='reply-submit'><input type='hidden' name='commentId' value='"+comment_id+"'/><input type='hidden' name='userId' value='"+user_id+"'/><div class='form-group'><textarea id='content' style='height:60px' class='form-control mb-10' rows='2' name='content' placeholder='Messege' ></textarea></div><button type='button' class='primary-btn submit_btn' onClick='replyWrite()'>Post Comment</button></form>";
			
			//<div class="comment-form" style="margin-top:0px;"></div>
			var reply_form = document.createElement("div");	//div 빈 박스 생성
			reply_form.className = "reply-form";	//div에 클래스 이름을 주고
			reply_form.style = "margin-top:0px";	//div에 style을 준다.
			
			reply_form.innerHTML = reply_form_inner;
			console.log(reply_form);
			
			var reply_list = document.querySelector("#comment-id-"+comment_id);
			reply_list.append(reply_form);	//after와 append, before와 prepand
			
			replyFormSwitch = 1;
		}else {
			
			var comment_list2 = document.querySelector(".reply-form");
			comment_list2.remove();
			
			replyFormSwitch = 0;
		}
	}
		
		//comment 쓰기
		function replyWrite(){
			var reply_submit_string = $("#reply-submit").serialize();
			
			$.ajax({
				method: "POST",
				url: "/blog/api/reply?cmd=write",
				data: reply_submit_string,
				contentType: "application/x-www-form-urlencoded; charset=utf-8",
				dataType: "json",
				success: function(reply) {		
					alert("성공");
					var comment_list2 = document.querySelector(".reply-form");
					comment_list2.remove();
					
				},
				error: function(xhr){
					alert("실패");
					console.log(xhr.status);
		            console.log(xhr);

				}
			});
			
		}
		
	
</script>


