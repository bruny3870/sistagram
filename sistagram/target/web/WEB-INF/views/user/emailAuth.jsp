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
			
			$("#sendmail").click(function() {
				var email = $("#userEmail").val();  /*입력한 이메일*/
				console.log("이메일 : " + email); /* 이메일 오는지 확인*/
				var checkInput = $("#authcode") /* 인증번호 입력 */

				$.ajax({
					type:"GET",
					url:'mailCheck?email=' + email, /*url을 통해 데이터를 보낼 수 있도록 GET방식, url명을 "mailCheck"로 지정 */
					success: function(data) {
						console.log("data : " + data);
						checkInput.attr("disabled", false); /*데이터가 성공적으로 들어오면 인증번호 입력란이 활성화되도록*/
						code = data;
						alert("인증번호가 전송되었습니다");
					}
				});
			});
			
			$("#authcode").on('input',function() {
				var inputCode = $("#authcode").val();   /*사용자가 입력한 전송 번호*/
				
				if (inputCode == code) {                 // 일치할 경우
					$("#authcode").css("border","1.5px solid #3781E3");		/*일치할 경우 테두리 색 변경*/
					$("#authcode").css("color","#3781E3");		/*일치할 경우 글자 색 변경*/
				} 
				
				else {                                            
					$("#authcode").css("border","1.5px solid red");
					$("#authcode").css("color","red");
				}
			});
			
			$("#btn_submit").click(function() {
				var inputCode = $("#authcode").val();   /*사용자가 입력한 전송 번호*/
				
				if (inputCode == code) {                 // 일치할 경우
					alert("회원가입이 완료 되었습니다");
					location.href = "/main";
				}
				
				else {
					alert("인증번호를 다시 확인해주세요");
				}
			});
		});
	</script>
</head>
<body>
    <div class="main">
        <div class="container">
            <div class="emailcheck" style="padding: 15px;">
                <img src="/resources/images/emailcheck.png" alt="emailCheck" style="width: 100px;">
            </div>
            <div class="centent">
                <div class="content_text">
                    <span style="font-weight: bold;">인증코드 입력</span>
                </div>
                <div class="content_text">
                    <span style="font-size: 13px;">${user.userEmail} 주소로 전송된 인증코드를 입력하세요</span>
                    <input type="hidden" id="userEmail" name="userEmail" value="${user.userEmail}">
                    <a id="sendmail" style="cursor: pointer;"><span style="font-size: 13px; color: #4cb5f9;">인증코드 보내기</span></a>
                </div>
                <div class="input_value">
                    <input type="text" id="authcode" name="authcode" placeholder="인증코드" disabled="disabled">
                </div>
                <div class="btn_submit">
                    <button type="button" id="btn_submit">완료</button>
                </div>
            </div>
        </div>
        <div class="container">
            <span><p style="margin: 15px;">계정이 있으신가요? <a href="/"><span style="color: #4cb5f9;">로그인</span></a></p></span>
        </div>
    </div>
</body>
</html>