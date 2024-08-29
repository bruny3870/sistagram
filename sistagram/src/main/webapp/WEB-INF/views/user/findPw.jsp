<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" type="text/css" href="/resources/css/reset.css">
<link rel="stylesheet" type="text/css" href="/resources/css/index.css">
	<script>
		$(document).ready(function() {
			var code = "";  /*인증번호 저장할 곳*/
			
			$("#btn_reset").click(function() {
				var email = $("#userEmail").val();  /*입력한 이메일*/
				console.log('완성된 이메일 : ' + email); /* 이메일 오는지 확인*/

				$.ajax({
					type:"GET",
					url:'findPw?email=' + email, /*url을 통해 데이터를 보낼 수 있도록 GET방식, url명을 "mailCheck"로 지정 */
					success: function(data) {
						console.log("data : " + data);
						checkInput.attr("disabled", false); /*데이터가 성공적으로 들어오면 인증번호 입력란이 활성화되도록*/
						code = data;
						alert('새로운 비밀번호가 전송되었습니다.')
					}
				});
			});
		});
	</script>
</head>
<body>
	<div class="main">
        <div class="container">
            <div class="logo">
            	<a href="/"><img src="/resources/images/Sistagram.png" alt="Instagram" class="brand_logo"></a>
            </div>
            <div class="centent">
                 <div class="content_text">
                     <span style="font-weight: bold;">로그인에 문제가 있나요?</span>
                 </div>
                 <div class="content_text">
                     <span style="font-size: 13px;">이메일 주소를 입력하시면 임시 비밀번호를 보내드립니다</span>
                 </div>
                 <div class="input_value">
                     <input type="text" id="userEmail" name="userEmail" placeholder="이메일">
                 </div>
                 <div class="btn_submit">
                     <button id="btn_reset">비밀번호 재설정</button>
                 </div>
                <div class="or_line">
                    <div class="line"></div>
                    <div class="text">또는</div>
                    <div class="line"></div>
                </div>
                <ul class="find_pw">
                    <li><a href="/user/signUp">새 개정 만들기</a></li>
                </ul>
            </div>
        </div>
        <div class="container">
            <span><a href="/">로그인으로 돌아가기</a></span>
        </div>
    </div>
</body>
</html>