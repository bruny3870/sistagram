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
		    $("#userId").focus();
		
		    $('#userPwd').on('input', function() {
		        if ($('#userPwd').val() == '') {
		            $('#showPw').css('visibility', 'hidden');
		        }
		
		        else {
		            $('#showPw').css('visibility', 'visible');
		        }
		    });
		
		    $('#showPw').on('click',function() {
		        var pw = $("#userPwd");
		        var pwType = pw.attr('type');
		
		        if (pwType == 'password') {
		            pw.attr('type', 'text');
		            $('#showPw').attr('src', '/resources/images/visibility_off.png');
		        }
		
		        else {
		            pw.attr('type', 'password');
		            $('#showPw').attr('src', '/resources/images/visibility.png');
		        }
		    });
		    
			$("#userId").keyup(function(e) {
				if (e.code == "Enter") {
					loginCheck();
				}
			});
			
			$("#userPwd").keyup(function(e) {
				if (e.code == "Enter") {
					loginCheck();
				}
			});
		    
		    $("#btn_login").on("click", function() {
		    	loginCheck();
		    });
		});
		
		function loginCheck() {
			if ($.trim($("#userId").val()).length <= 0) {
				//alert("아이디를 입력하세요");
				$(".error_msg").html("아이디를 입력하세요");
				$("#userId").val("");
				$("#userId").focus();
				return;
			}
			
			if ($.trim($("#userPwd").val()).length <= 0) {
				//alert("비밀번호를 입력하세요");
				$(".error_msg").html("비밀번호를 입력하세요");
				$("#userPwd").val("");
				$("#userPwd").focus();
				return;
			}
			
			$.ajax({
				type:"POST",
				url:"/user/login",
				data:{
					userId:$("#userId").val(),
					userPwd:$("#userPwd").val()
				},
				datatype:"JSON",
				beforeSend:function(xhr) {
					xhr.setRequestHeader("AJAX", "true");
				},
				success:function(response) {
					if (!icia.common.isEmpty(response)) {
						icia.common.log(response);
						
						var code = icia.common.objectValue(response, "code", -500);
						
						if (code == 0) {
							alert("로그인 성공");
							location.href = "/main";
						}
						
						else {
							if (code == -1) {
								//alert("잘못된 비밀번호입니다");
								$(".error_msg").html("잘못된 비밀번호입니다");
							}
							
							else if (code == 404) {
								//alert("존재하지 않는 아이디입니다");
								$(".error_msg").html("존재하지 않는 아이디입니다");
							}
							
							else if (code == 400) {
								//alert("아이디 또는 비밀번호가 올바르지 않습니다");
								$(".error_msg").html("아이디 또는 비밀번호가 <br> 올바르지 않습니다");
							}
							
							else {
								//alert("로그인 중 오류가 발생하였습니다");
								$(".error_msg").html("로그인 중 오류가 발생하였습니다");
							}
						}
					}
					
					else {
						//alert("로그인 도중 알수없는 오류가 발생하였습니다");
						$(".error_msg").html("로그인 도중 알수없는 오류가 발생하였습니다");
					}
				},
				error:function(xhr, status, error) {
					icia.common.error(error);
				}
			});
		}
	</script>
</head>
<body>
    <div class="main">
        <div class="container">
            <div class="logo">
                <a href="/"><img src="/resources/images/Sistagram.png" alt="Instagram" class="brand_logo"></a>
            </div>
            <div class="centent">
                <form name="login_form" action="" method="POST">
                    <div class="input_value">
                        <input type="text" id="userId" name="userId" placeholder="아이디">
                    </div>
                    <div class="input_value">
                        <input type="password" id="userPwd" name="userPwd" placeholder="비밀번호를 입력하세요" maxlength="20">
                        <img class="showPw" id="showPw" name="showPw" src="/resources/images/visibility.png" style="visibility: hidden;">
                    </div>
                    <div class="btn_submit">
                        <button type="button" id="btn_login">로그인</button>
                    </div>
                </form>
                <div class="or_line">
                    <div class="line"></div>
                    <div class="text">또는</div>
                    <div class="line"></div>
                </div>
                <ul class="find_pw">
                	<li class="error_msg" style="margin: 10px 40px; font-size: 15px; color: #FF0000"></li>
                    <li><a href="/user/findPw">비밀번호를 잊으셨나요?</a></li>
                </ul>
            </div>
        </div>
        <div class="container">
            <span><p style="margin: 15px;">계정이 없으신가요? <a href="/user/signUp"><span style="color: #4cb5f9;">가입하기</span></a></p></span>
        </div>
    </div>
 </body>
</html>