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
			
		});
		
		function fn_pro(userId) {
			document.bbsForm.userId.value = userId;
			document.bbsForm.action = "/user/profile";
			document.bbsForm.submit();
		}
		
		function fn_view(boardNum) {
			document.bbsForm.boardNum.value = boardNum;
			document.bbsForm.action = "/board/view";
			document.bbsForm.submit();
		}
	</script>
</head>
<body>
    <div class="main">
        <div class="aaa">
        	<!-- 메뉴 -->
        	<%@ include file="/WEB-INF/views/include/menu.jsp" %>
        	<!-- 메인 -->
	        <div style="width: 85%; margin-left: auto;">
	            <div style="height: 100vh; display: flex; flex-direction: column;">
	                <div style="display: flex; flex-direction: column; flex-grow: 1;">
	                    <div style="display: flex; flex-direction: row; justify-content: center;">
	                        <div style="max-width: 600px; width: 100%;">
	                            <div style="margin-top: 20px;">
	                                <!-- top -->
	                                <div style="margin-bottom: 30px;">
	                                    <div style="padding: 0 10px;">
	                                        <div style="width: 100%; height: 100%; display: flex; flex-direction: row;">
	                                            <ul style="display: flex; flex-direction: row; flex-grow: 1;">
	                                                <li>
	                                                    <div style="padding: 0 5px;">
	                                                        <button style="background-color: transparent; border-style: none; cursor: pointer;">
	                                                            <div>
	                                                                <img src="/resources/images/cat.jpg" alt="img" style="width: 50px; height: 50px; border-radius: 50%;">
	                                                            </div>
	                                                            <div>
	                                                                <span>userId</span>
	                                                            </div>
	                                                        </button>
	                                                    </div>                                                                        
	                                                </li>
	                                            </ul>
	                                        </div>
	                                    </div>
	                                </div>
	                                <!-- list -->
	                                <c:choose>
	                                <c:when test="${!empty list}">
	                                <c:forEach var="board" items="${list}" varStatus="status">
	                                <div style="width: 100%;">
	                                    <div style="display: flex; flex-direction: column;">
	                                        <div>
	                                            <div style="width: 100%; height: 100%; display: flex; flex-direction: column; padding-bottom: 10px; margin-bottom: 20px; border-bottom-width: 1px; border-bottom-style: solid;">
	                                                <div style="padding-bottom: 10px;">
	                                                    <div style="width: 100%; display: flex; flex-direction: row;">
	                                                        <div style="margin-right: 10px;">
					                                            <div style="cursor: pointer;">
						                                            <a href="javascript:void(0)" onclick="fn_pro('${board.userId}')">
							                                            <c:choose>
							                                            	<c:when test="${!empty board.ufileName}">
							                                            		<img src="/resources/upload/${board.ufileName}" alt="img" style="width: 32px; height: 32px; border-radius: 50%;">
							                                            	</c:when>
							                                            	<c:otherwise>
							                                            		<img src="/resources/images/account.jpg" alt="img" style="width: 32px; height: 32px; border-radius: 50%;">
							                                            	</c:otherwise>
							                                            </c:choose>
						                                            </a>                                               
					                                            </div>
	                                                        </div>
	                                                        <div style="width: 100%; display: flex; align-items: center;">
	                                                            <div style="display: flex; flex-direction: row;">
	                                                                <div style="cursor: pointer;">
	                                                                	<a href="javascript:void(0)" onclick="fn_pro('${board.userId}')">
	                                                                		<span id="userId" style="font-weight: bold; color: #000">${board.userId}</span>
																		</a>
	                                                                </div>
	                                                                <div style="display: flex; flex-direction: row;">
	                                                                    <div>
	                                                                        <span style="margin: 0px 4px;">•</span>
	                                                                    </div>
	                                                                    <div>
	                                                                        <span>${board.regDate}</span>
	                                                                    </div>
	                                                                </div>
	                                                            </div>
	                                                        </div>
	                                                    </div>
	                                                </div>
	                                                <div>
	                                                    <a href="javascript:void(0)" onclick="fn_view(${board.boardNum})">
	                                                    	<img src="/resources/upload/${board.fileName}" alt="img" style="width: 100%;">
	                                                    </a>
	                                                </div>
	                                                <div>
	                                                    <div style="display: flex; flex-direction: column;">
	                                                        <div style="display: grid; margin: 0px 5px; align-items: center; grid-template-columns: 1fr 1fr;">
	                                                            <div style="display: flex; margin-left: -10px;">
	                                                                <div style="padding: 8px; cursor: pointer;">
	                                                                    <a><img src="/resources/images/heart.png" alt="img"></a>
	                                                                </div>
	                                                                <div style="padding: 8px; cursor: pointer;">
	                                                                    <a><img src="/resources/images/reply.png" alt="img"></a>
	                                                                </div>
	                                                            </div>
	                                                            <div style="margin-left: auto; cursor: pointer;">
	                                                                <a><img src="/resources/images/mark.png" alt="img"></a>
	                                                            </div>
	                                                        </div>
	                                                        <div style="margin-top: 10px; display: inline-block;">
	                                                            <div style="display: inline-block;">
	                                                                <div style="cursor: pointer;">
	                                                                	<a href="javascript:void(0)" onclick="fn_pro('${board.userId}')">
	                                                                		<span id="userId" style="font-weight: bold; color: #000">${board.userId}</span>
																		</a>
	                                                                </div>
	                                                            </div>
	                                                            <div style="display: inline;">
	                                                            	<pre style="display: inline;"><c:out value="${board.boardContent}" /></pre>
	                                                            </div>
	                                                        </div>
	                                                        <div style="margin-top: 10px;">
	                                                            <a>
	                                                                <span style="font-size: 13px;">댓글 ${cmdCnt} 보기</span>
	                                                            </a>
	                                                        </div>
	                                                    </div>
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                                </c:forEach>
	                                </c:when>
	                                <c:otherwise>
	                                	<div>
	                                		글이 없습니다
	                                	</div>
	                                </c:otherwise>
	                                </c:choose>
	                                <!-- list -->
	                            </div>
	                        </div>
	                        <!-- right -->
	                        <div style="width: 25%; height: 100vh; padding-left: 60px;">
	                            <div style="margin-top: 40px; display: flex; flex-direction: column;">
	                                <div style="padding: 0 10px;">
	                                    <div style="display: flex; flex-direction: row; justify-content: space-between;">
	                                        <div style="margin-right: 10px;">
	                                            <div style="width: 35px; height: 35px;">
		                                            <a href="javascript:void(0)" onclick="fn_pro('${user.userId}')">
			                                            <c:choose>
			                                            	<c:when test="${!empty user.fileName}">
			                                            		<img src="/resources/upload/${user.fileName}" alt="img" style="width: 100%; border-radius: 50%;">
			                                            	</c:when>
			                                            	<c:otherwise>
			                                            		<img src="/resources/images/account.jpg" alt="img" style="width: 100%; border-radius: 50%;">
			                                            	</c:otherwise>
			                                            </c:choose>
		                                            </a>                                               
	                                            </div>
	                                        </div>
	                                        <div style="width: 100%; display: flex;">
	                                            <div style="display: flex; flex-direction: column; justify-content: center; flex-grow: 1;">
                                                    <div style="cursor: pointer;">
                                                    	<a href="javascript:void(0)" onclick="fn_pro('${user.userId}')">
                                                    		<span id="userId" style="font-weight: bold; color: #000">${user.userId}</span>
														</a>
                                                    </div>
	                                                <div>
	                                                    <span>${user.userName}</span>
	                                                </div>
	                                            </div>
	                                        </div>
	                                        <div style="display: flex;">
	                                            <div style="display: flex; align-items: center; flex-shrink: 0;">
	                                                <a href="/user/logout"><span style="font-size: 12px; color: #4cb5f9;">전환</span></a>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                                <div style="margin-top: 25px; margin-bottom: 10px;">
	                                    <div style="display: flex; flex-direction: column;">
	                                        <div style="display: flex; flex-direction: row;">
	                                            <div style="display: flex; flex-grow: 1;">
	                                                <span style="font-size: 14px;">회원님을 위한 추천</span>
	                                            </div>
	                                            <div>
	                                                <span style="font-size: 14px; font-weight: bold;">모두보기</span>
	                                            </div>
	                                        </div>
	                                        <c:choose>
	                                        	<c:when test="${!empty list}">
	                                        		<c:forEach var="random" items="${list}" varStatus="status">
		                                        		<div style="width: 100%;">
			                                            	<div style="padding: 10px;">
			                                                	<div style="display: flex; flex-direction: row; justify-content: space-between;">
			                                                    	<div style="margin-right: 10px;">
			                                                        	<div style="cursor: pointer;">
			                                                            	<img src="/resources/images/cat.jpg" alt="img" style="width: 44px; height: 44px; border-radius: 50%;">
				                                                        </div>
				                                                    </div>
				                                                    <div style="width: 100%; display: flex;">
			    	                                                    <div style="display: flex; flex-direction: column; justify-content: center; flex-grow: 1;">
			        	                                                    <div>
			                                                                <div>
			                                                                    <span style="font-weight: bold;">${random.userId}</span>
			                                                                </div>
			                	                                            </div>
			            	                                                <div>
			        	                                                        <span>${random.userName}</span>
			    	                                                        </div>
				                                                        </div>
				                                                    </div>
				                                                    <div style="display: flex;">
				                                                        <div style="display: flex; align-items: center; flex-shrink: 0;">
			                                                            	<span style="font-size: 12px; color: #4cb5f9;">팔로우</span>
			                                                        	</div>
			                                                    	</div>
			                                                	</div>
			                                            	</div>
			                                        	</div>
	                                        		</c:forEach>
	                                        	</c:when>
	                                        </c:choose>	                                        
	                                    </div>
	                                </div>
	                            </div>
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
	<!-- 모달 -->
	<div class="zzz" style="margin: 0 auto; width: 100%; height: 100%; display: none;">
		<div>
			123
		</div>
	</div>
</body>
</html>