<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	
</script>

<script src="/blog/js/jquery-3.2.1.min.js"></script>
</head>
<body>
	
	<div id="img__wrap"></div>

	<form action="uploadAction.jsp" method="POST" enctype="multipart/form-data">	<!-- MIME 타입 -->
		<input type="hidden" name="username" value="${sessionScope.user.username}">
		userProfile : <input id="img__imput" type="file" name="userProfile"/> <br/>
		<input type="submit" value="전송"/>
	</form>
<script src="/blog/js/jquery-3.2.1.min.js"></script>
<script>
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
</body>
</html>