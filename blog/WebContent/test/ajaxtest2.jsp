<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<button onClick="promise()">요청하기</button>

	<div id="demo"></div>
	<script>
		function start(){
			console.log("start");
			var xhr = new XMLHttpRequest();
			return new Promise(function(resolve, reject) {
				xhr.onreadystatechange = function() {
					if (xhr.readyState == 4) {
						if(xhr.status >= 300) {
							reject("Error, status code = " + xhr.status)
						} else {
							resolve(xhr.responseText);
						}
					}
				}
				xhr.open("POST", "http://localhost:8000/blog/test2", true);
				xhr.send();
			});
		}
	
		function promise() {
			console.log("promise");
			start();
			
			start().then(function(result) {
				console.log("start 3초 지남");
				var xhttp = new XMLHttpRequest();
				xhttp.onreadystatechange = function() {
					if (this.readyState == 4 && this.status == 200) {
						sum = Number(result) + Number(this.responseText);
						console.log("sum : " + sum)
					}
				};
				
				xhttp.open("POST", "http://localhost:8000/blog/test3", true);
				xhttp.setRequestHeader("Content-type", "text/plain");
				xhttp.send();
			}, function(error) {
				console.log(error)
			})
		}
	
		/* 
		let postNum2 = 0;
		let postNum3 = 0;
		let sum = 0;
	
		function sendPost2() {
			var xhttp = new XMLHttpRequest();

			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					postNum2 = this.responseText;
					console.log("postNum2 : "+postNum2);
				}
			};

			xhttp.open("POST", "http://localhost:8000/blog/test2", true);
			xhttp.setRequestHeader("Content-type", "text/plain");
			xhttp.send();
		}
		
		function sendPost3() {
			
			var url = 'http://localhost:8000/blog/test2';
			var data = {postNum2: 'postNum2'};

			fetch(url, {
			  method: 'POST', // or 'PUT'
			  body: JSON.stringify(data), // data can be `string` or {object}!
			  headers:{
			    'Content-Type': 'text/plain; charset=UTF-8'
			  }
			}).then(res => res.json())
			.then(response => console.log('Success:', JSON.stringify(response)))
			.catch(error => console.error('Error:', error));
			
			var xhttp = new XMLHttpRequest();

			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					postNum3 = this.responseText;
					console.log("postNum3 : "+postNum3);
					sum = Number(postNum2) + Number(postNum3);
					console.log("sum : "+sum)
				}
			};

			xhttp.open("POST", "http://localhost:8000/blog/test3", true);
			xhttp.setRequestHeader("Content-type", "text/plain");
			xhttp.send();
		} */
	</script>
</body>
</html>