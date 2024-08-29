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
		    
		    $("#btn_signup").on("click", function() {
				//공백 체크
				var emptCheck = /\s/g;
				
				//영문 대소문자, 숫자로만 이루어진 4~12자리 정규식
				var idpwCheck = /^[a-zA-Z0-9]{4,12}$/;
				
				//이메일 형식
				var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
				
				if ($.trim($("#userId").val()).length <= 0) {
					alert("아이디를 입력하세요");
					$("#userId").val("");
					$("#userId").focus();
				}
				
				if (emptCheck.test($("#userId").val())) {
					alert("아이디는 공백을 포함할 수 없습니다");
					$("#userId").val("");
					$("#userId").focus();
					return;
				}
				
				if (!idpwCheck.test($("#userId").val())) {
					alert("아이디는 4~12자 영문 대소문자, 숫자로만 입력 가능합니다");
					$("#userId").focus();
					return;
				}
				
				if ($.trim($("#userPwd").val()).length <= 0) {
					alert("비밀번호를 입력하세요");
					$("#userPwd").val("");
					$("#userPwd").focus();
					return;
				}
				
				if (!idpwCheck.test($("#userPwd").val())) {
					alert("비밀번호는 4~12자 영문 대소문자, 숫자로만 입력 가능합니다");
					$("#userPwd").focus();
					return;
				}
				
				if ($.trim($("#userName").val()).length <= 0) {
					alert("이름을 입력하세요");
					$("#userName").val("");
					$("#userName").focus();
					return;
				}
				
				if ($.trim($("#userEmail").val()).length <= 0) {
					alert("이메일을 입력하세요");
					$("#userEmail").val("");
					$("#userEmail").focus();
					return;
				}
				
				if (!emailReg.test($("#userEmail").val())) {
					alert("이메일 형식이 올바르지 않습니다");
					$("#userEmail").focus();
					return;
				}
				
				idCheck();
		    });
		    
		    function idCheck() {
				$.ajax({
					type:"POST",
					url:"/user/idCheck",
					data:{
						userId:$("#userId").val()
					},
					dataType:"JSON",
					beforeSend:function(xhr) {
						xhr.setRequestHeader("AJAX", "true");
					},
					success:function(response) {
						if (response.code == 0) {
							//$("#id_check").html("사용 가능한 아이디 입니다");
							//$("#id_check").css("margin", "5px");
							//$("#id_check").css("color", "#008000");
							alert("사용 가능한 아이디 입니다");
							signUp();
						}
						
						else if (response.code == 100) {
							//$("#id_check").html("이미 사용중인 아이디 입니다");
							//$("#id_check").css("margin", "5px");
							//$("#id_check").css("color", "#FF0000");
							alert("이미 사용중인 아이디 입니다");
							$("#userId").focus();
						}
						
						else if (response.code == 400) {
							alert("값이 올바르지 않습니다");
							$("#userId").focus();
						}
						
						else {
							alert("오류가 발생했습니다");
							$("#userId").focus();
						}
					},
					error:function(xhr, status, error) {
						icia.common.error(error);
					}
				});
		    }
		    
		    function signUp() {
		    	$.ajax({
		    		type:"POST",
		    		url:"/user/signUpProc",
		    		data:{
		    			userId:$("#userId").val(),
		    			userPwd:$("#userPwd").val(),
		    			userName:$("#userName").val(),
		    			userEmail:$("#userEmail").val()
		    		},
		    		dataType:"JSON",
		    		beforeSend:function(xhr) {
		    			xhr.setRequestHeader("AJAX", "true");
		    		},
		    		success:function(res) {
		    			if (res.code == 0) {
		    				location.href = "/user/emailAuth";
		    			}
		    			
		    			else if (res.code == 100) {
		    				alert("이미 사용중인 아이디 입니다");
		    				$("#userId").focus();
		    			}
		    			
		    			else if (res.code == 400) {
		    				alert("값이 올바르지 않습니다");
		    				$("#userId").focus();
		    			}
		    			
		    			else if (res.code == 500) {
		    				alert("회원 가입 중 오류가 발생하였습니다");
		    				$("#userId").focus();
		    			}
		    			
		    			else {
		    				alert("회원 가입 도중 알수없는 오류가 발생하였습니다");
		    			}
		    		},
		    		error:function(xhr, status, error) {
		    			icia.common.error(error);
		    		}
		    	});
		    }
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
                <form name="signUp_form" method="POST">
                    <div class="content_text">
                        <span style="font-weight: bold;">친구들의 사진과 동영상을 보려면 가입하세요</span>
                    </div>
                    <div class="input_value">
                        <input type="text" id="userId" name="userId"  placeholder="아이디">
                    </div>
                    <div class="input_check" id="id_check" style="font-size: 14px; color: #FF0000"></div>
                    <div class="input_value">
                        <input type="password" id="userPwd" name="userPwd" placeholder="비밀번호를 입력하세요">
                        <img class="showPw" id="showPw" name="showPw" src="/resources/images/visibility.png" style="visibility: hidden;">
                    </div>
                    <div class="input_check" id="pw_check" style="font-size: 14px; color: #FF0000"></div>
                    <div class="input_value">
                        <input type="text" id="userName" name="userName"  placeholder="이름">
                    </div>
                    <div class="input_check" id="name_check" style="font-size: 14px; color: #FF0000"></div>
                    <div class="input_value">
                        <input type="text" id="userEmail" name="userEmail"  placeholder="이메일">
                    </div>
                    <div class="input_check" id="email_check" style="font-size: 14px; color: #FF0000"></div>
                    <div class="btn_submit">
                        <button type="button" id="btn_signup">가입</button>
                    </div>
                </form>
            </div>
        </div>
        <div class="container">
            <span><p style="margin: 15px;">계정이 있으신가요? <a href="/"><span style="color: #4cb5f9;">로그인</span></a></p></span>
        </div>
    </div>
 </body>
</html>