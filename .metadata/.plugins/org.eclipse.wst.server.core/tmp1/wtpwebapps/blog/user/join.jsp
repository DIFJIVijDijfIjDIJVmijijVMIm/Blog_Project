<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/nav.jsp"%>

<!--================Contact Area =================-->
<section class="contact_area">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<form class="row contact_form" action="/blog/user?cmd=join" method="post" onsubmit="return validateCheck()">
					
					<div id="img__wrap"></div>
					
					userProfile : <input id="img__imput" type="file" name="userProfile"/> <br/>
					
					<div class="col-md-10">
						<div class="form-group">
							<input type="text" class="form-control" name="username" placeholder="아이디를 입력하세요" required="required" maxlength="20">
						</div>
						<span id="username_input" style="font-size:10px; color:red"></span>
					</div>
					
					<div class="col-md-2">
						<div class="form-group float-right">
							<a style="cursor: pointer;" class="blog_btn" onClick="usernameCheck()">중복확인</a>
						</div>					
					</div>					
					
					<div class="col-md-12">
						<div class="form-group">
							<input type="password" class="form-control" id="password" name="password" placeholder="비밀번호를 입력하세요" required="required" maxlength="20">
						</div>
					</div>
					<div class="col-md-12">
						<div class="form-group">
							<input type="password" class="form-control" id="passwordCheck" name="passwordCheck" placeholder="동일한 비밀번호를 입력하세요" required="required" maxlength="20">
						</div>
					</div>
					<div class="col-md-12">
						<div class="form-group">
							<input type="text" class="form-control" name="email" placeholder="이메일을 입력하세요" required="required" maxlength="40">
						</div>
					</div>
					<!-- 도로명 주소 시작 -->
					<div class="col-md-10">
						<div class="form-group">
							<input id="roadFullAddr" type="text" class="form-control" name="address" required="required" placeholder="도로명 주소가 자동 입력됩니다." readonly>
						</div>
					</div>
					<div class="col-md-2">
						<div class="form-group float-right">
							<a style="cursor: pointer;" class="blog_btn" onClick="goPopup()">주소찾기</a>
						</div>
					</div>
					
					<!-- 도로명 주소 끝 -->

					<div class="col-md-12 text-right">
						<button type="submit" value="submit" class="btn submit_btn">회원 가입</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</section>
<!--================Contact Area =================-->
<br />
<br />

<script>
	var usernameDuplicateCheck = false;
	//아이디 중복 확인ㄹ
	function usernameCheck() {
		var username = document.querySelector("#username").value;

		fetch("/blog/api/user?username=" + username).then(function(r) {
			return r.text();
		}).then(function(r) {
			var status = r; //ok 중복되지 않음.
			var et = document.querySelector("#username_input");

			if (status === "ok") {
				et.innerHTML = "사용할 수 있는 아이디 입니다.";
				usernameDuplicateCheck = true;
			} else {
				et.innerHTML = "사용할 수 없는 아이디 입니다.";
				usernameDuplicateCheck = false;
			}
		});
	}

	function goPopup() {
		// 주소검색을 수행할 팝업 페이지를 호출합니다.
		// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
		var pop = window.open("/blog/juso/jusoPopup.jsp", "pop",
				"width=570,height=420, scrollbars=yes, resizable=yes");

		// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
		//var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
	}

	//주소 입력 버튼을 누르면 콜백 된다.
	function jusoCallBack(roadFullAddr) {
		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
		var juso = document.querySelector('#roadFullAddr');
		juso.value = roadFullAddr;

	}

	function validateCheck() {
		var password = document.querySelector('#password').value;
		var passwordCheck = document.querySelector('#passwordCheck').value;

		if (password === passwordCheck) {
			console.log('비밀번호가 동일합니다.');
			return true;
		} else {
			console.log('비밀번호가 틀렸습니다.');
			alert('비밀번호가 동일하지 않습니다. 다시 입력해 주세요.');
			return false;
		}
	}
	
	$("#img__input").on("change", handleImgFile);
	
	function handleImgFile(e) {
		console.log(e);
		console.log(e.target);
		console.log(e.target.files);
		console.log(e.target.files[0]);
		
		var f = e.target.files[0];
		
		if(!f.type.match("image.*")){
			console.log("이미지 타입입니다.");
			return;	
		}
		
		var reader = new FileReader();
		
		reader.onload = function(e){
			console.log("==========");
			console.log(e.target);
			console.log(e.target.result);	//파일 로딩이 성공한 결과
			$("#img__wrap").attr("src", e.target.result);
		}
		
		reader.readAsDataURL(f);
	}
	
</script>
<%@ include file="/include/footer.jsp"%>