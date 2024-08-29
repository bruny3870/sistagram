<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" type="text/css" href="/resources/css/reset.css">
<link rel="stylesheet" type="text/css" href="/resources/css/main.css">
<script type="text/javascript" src="/resources/js/main.js"></script>
	<script>
		$(document).ready(function() {
			//비밀번호 버튼 보이기
		    $('#userPwd').on('input', function() {
		        if ($('#userPwd').val() == '') {
		            $('#showPw').css('visibility', 'hidden');
		        }
		
		        else {
		            $('#showPw').css('visibility', 'visible');
		        }
		    });
			
		  	//비밀번호 보이기
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
		    
		    //업데이트
		    $("#btn_Update").on("click", function() {
				//공백 체크
				var emptCheck = /\s/g;
				
				//영문 대소문자, 숫자로만 이루어진 4~12자리 정규식
				var idpwCheck = /^[a-zA-Z0-9]{4,12}$/;
				
				//이메일 형식
				var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
				
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
				
				var form = $("#updateForm")[0];
				var formData = new FormData(form);
				
				
				$.ajax({
					type:"POST",
					enctype:"multipart/form-data",
					url:"/user/updateProc",
					data:formData,
					processData:false,		//formData를 String으로 변환하지 않음
					contentType:false,		//content-type헤더가 multipart/form-data로 전송
					cache:false,
					timeout:600000,
					beforeSend:function(xhr) {
						xhr.setRequestHeader("AJAX", "true");
					},
					success:function(response) {
						if (response.code == 0) {
							alert("회원 정보가 수정되었습니다");
							location.href = "/user/update";
						}
						
						else if (response.code == 400) {
							alert("값이 올바르지 않습니다");
							$("#userPwd").focus();
						}
						
						else if (response.code == 404) {
							alert("회원정보가 존재하지 않습니다");
							location.href = "/";
						}
						
						else if (response.code == 410) {
							alert("로그인을 먼저 해주세요");
							location.href = "/";
						}
						
						else if (response.code == 430) {
							alert("아이디 정보가 다릅니다");
							location.href = "/";
						}
						
						else if (response.code == 500) {
							alert("회원정보 수정 중 오류가 발생하였습니다");
							$("#userPwd").focus();
						}
						
						else {
							alert("회원정보 수정 도중 알수없는 오류가 발생하였습니다");
							$("#userPwd").focus();
						}
					},
					error:function(xhr, status, error) {
						icia.common.error(error);
					}
				});
		    });
		});
	</script>
	<style>
		.showPw {
		    position: absolute;
		    top: 27%;
		    right: 22%;
		    width: auto;
		    height: auto;
		    cursor: pointer;
		    border: none;
		}
	</style>
</head>
<body>
    <div class="main">
        <div class="aaa">
            <!-- 메뉴 -->
        	<%@ include file="/WEB-INF/views/include/menu.jsp" %>
	        <!-- 수정 -->
	        <div style="width: 85%; margin-left: auto;">
	            <div style="height: 100vh; display: flex; flex-direction: column;">
	                <div style="display: flex; flex-direction: column; flex-grow: 1;">
	                    <div style="display: flex; flex-direction: row; justify-content: center;">
	                        <div style="padding: 40px 0; display: flex; flex-direction: column; width: 50%;">
	                            <div style="margin-top: 30px; margin-left: 40px;">
	                                <div style="margin-bottom: 30px;">
	                                    <span style="font-size: 24px; font-weight: bold;">프로필 편집</span>
	                                </div>
	                            </div>
	                            
	                            <form name="updateForm" id="updateForm" method="POST" enctype="multipart/form-data" style="display: flex; flex-direction: column; margin: 15px 0;">
	                            	<!-- 프로필 -->
		                            <div style="display: flex; flex-direction: row; margin-top: 30px; margin-bottom: 15px;">
		                                <div style="margin: 0 30px 0 120px;">
		                                    <div>
	                                    		<c:choose>
	                                            	<c:when test="${!empty user.fileName}">
	                                            		<img src="/resources/upload/${user.fileName}" alt="img" style="width: 40px; height: 40px; border-radius: 50%;">
	                                            	</c:when>
	                                            	<c:otherwise>
	                                            		<img src="/resources/images/account.jpg" style="width: 40px; height: 40px; border-radius: 50%;">
	                                            	</c:otherwise>
	                                            </c:choose>   
		                                    </div>
		                                </div>
		                                <div style="display: flex; flex-direction: column;">
		                                    <div style="margin: 5px 0;">
		                                        <span style="font-size: 16px; font-weight: bold;">${user.userId}</span>
		                                    </div>
		                                    <div style="margin: 5px 0;">
												<input type="file" id="userFile" name="userFile"> <!--  onchange="readURL(this);">   -->
		                                    </div>
		                                </div>
		                            </div>

	                            	<!-- 수정 -->
	                                <div style="display: flex; flex-direction: row; margin-bottom: 15px;">
	                                    <div style="flex: 0 0 190px; text-align: right; padding: 0 30px; margin-top: 6px;">
	                                        <span style="font-size: 16px; font-weight: bold;">비밀번호</span>
	                                    </div>
	                                    <div style="width: 100%;">
	                                        <input type="password" id="userPwd" name="userPwd" value="${user.userPwd}" style="width: 100%; height: 32px; padding: 0 10px; border: 1px solid #dbdbdb; border-radius: 5px; font-size: 16px;">
	                                        <img class="showPw" id="showPw" name="showPw" src="/resources/images/visibility.png">
	                                    </div>
	                                </div>
	                                <div style="display: flex; flex-direction: row; margin-bottom: 15px;">
	                                    <div style="flex: 0 0 190px; text-align: right; padding: 0 30px; margin-top: 6px;">
	                                        <span style="font-size: 16px; font-weight: bold;">이름</span>
	                                    </div>
	                                    <div style="width: 100%;">
	                                        <input type="text" id="userName" name="userName" value="${user.userName}" style="width: 100%; height: 32px; padding: 0 10px; border: 1px solid #dbdbdb; border-radius: 5px; font-size: 16px;">
	                                    </div>
	                                </div>
	                                <div style="display: flex; flex-direction: row; margin-bottom: 15px;">
	                                    <div style="flex: 0 0 190px; text-align: right; padding: 0 30px; margin-top: 6px;">
	                                        <span style="font-size: 16px; font-weight: bold;">이메일</span>
	                                    </div>
	                                    <div style="width: 100%;">
	                                        <input type="text" id="userEmail" name="userEmail" value="${user.userEmail}" style="width: 100%; height: 32px; padding: 0 10px; border: 1px solid #dbdbdb; border-radius: 5px; font-size: 16px;">
	                                    </div>
	                                </div>
	                                <div style="display: flex; flex-direction: row; margin-bottom: 15px;">
	                                    <div style="flex: 0 0 190px; text-align: right; padding: 0 30px; margin-top: 6px;">
	                                        <span style="font-size: 16px; font-weight: bold;">소개</span>
	                                    </div>
	                                    <div style="width: 100%;">
	                                        <textarea id="userIntro" name="userIntro" style="width: 100%; height: 60px; padding: 5px 10px; border: 1px solid #dbdbdb; border-radius: 5px; font-size: 16px;">${user.userIntro}</textarea>
	                                    </div> 
	                                </div>
	                                <div style="display: flex; flex-direction: row; margin-bottom: 15px;">
	                                    <div style="flex: 0 0 190px; text-align: right; padding: 0 30px; margin-top: 6px;">
	                                        <span></span>
	                                    </div>
	                                    <div style="width: 100%;">
	                                        <button type="button" id="btn_Update" style="width: 60px; height: 30px; border: none; border-radius: 5px; background-color: #4cb5f9; font-size: 16px; font-weight: bold; color: #fff;">수정</button>
	                                    </div> 
	                                </div>
	                                <input type="hidden" id="userId" name="userId" value="${user.userId}">
	                            </form>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
	<form name="bbsForm" id="bbsForm" method="POST">
    	<input type="hidden" name="boardNum" value="">
    	<input type="hidden" name="userId" value="${user.userId}">
	</form>
</body>
</html>