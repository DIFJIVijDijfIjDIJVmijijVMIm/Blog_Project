<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/nav.jsp"%>

<!--================Contact Area =================-->
<section class="contact_area">
	<div class="container">
		<div class="row">

			<div class="col-lg-12">
				<form class="row contact_form" action="/blog/user?cmd=update" method="post" onsubmit="return validateCheck()">
					<input type="hidden" name="id" value="${sessionScope.user.id}"/>
					<div class="col-md-12">
						<div class="form-group">
							<input type="text" class="form-control" value="${sessionScope.user.username}" name="username" placeholder="아이디를 입력하세요" readonly maxlength="20">
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
							<input type="text" class="form-control" value="${sessionScope.user.email}" name="email" placeholder="이메일을 입력하세요" readonly maxlength="40">
						</div>
					</div>
					<!-- 도로명 주소 시작 -->
					<div class="col-md-12">
						<div class="form-group float-right">
							<a style="cursor:pointer;" class="blog_btn" onClick="goPopup()">주소찾기</a>
						</div>
					</div>
					<div class="col-md-12">
						<div class="form-group">
							<input id="roadFullAddr" type="text" class="form-control" value="${sessionScope.user.address}" name="address" required="required" placeholder="도로명 주소가 자동 입력됩니다." readonly>
						</div>
					</div>
					<!-- 도로명 주소 끝 -->

					<div class="col-md-12 text-right">
						<button type="submit" value="submit" class="btn submit_btn">Update</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</section>
<!--================Contact Area =================-->
<br />
<br />

<script language="javascript">
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
</script>
<%@ include file="/include/footer.jsp"%>