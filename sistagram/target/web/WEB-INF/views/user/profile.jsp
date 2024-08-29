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
		
		function fn_view(boardNum) {
			document.bbsForm.boardNum.value = boardNum;
			document.bbsForm.action = "/board/view";
			document.bbsForm.submit();
		}
	</script>
	<style>
		article {
            position: relative;
            background-color: #000;
        }
        
        article:hover .thumbImg img {
            opacity: 0.8;
        }
        
        article:hover .links {
            opacity: 1;
        }

        .thumbImg img {
            width: 300px;
            height: 300px;
            opacity: 1;
        }
        
        .icon {
            width: 20px;
            height: 20px;
        }
        
        .links {
	        opacity: 0;
	        position: absolute;
	        text-align: center;
	        top: 50%;
	        left: 50%;
	        transform: translate(-50%, -50%);
	        -ms-transform: translate(-50%, -50%);
	        display: flex;
	        align-items: center;
        }
	</style>
</head>
<body>
    <div class="main">
        <div class="aaa">
        	<!-- 메뉴 -->
        	<%@ include file="/WEB-INF/views/include/menu.jsp" %>
        	<!-- 상세 -->
            <div style="width: 85%; margin-left: auto;">
             <div style="height: 100vh; display: flex; flex-direction: column;">
                 <div style="display: flex; flex-direction: column; flex-grow: 1;">
                     <div style="display: flex; flex-direction: row; justify-content: center;">
                         <div style="width: calc(100% - 40px); max-width: 960px; padding: 30px 20px 0px 20px; margin: 0px auto 30px auto;">
                             <div style="margin-bottom: 40px; display: flex; flex-direction: row;">
                                 <div style="margin-right: 30px; flex-grow: 1; display: flex; justify-content: center;">
                                     <div style="width: 150px; margin: 0 auto;">
	                                     <div style="cursor: pointer;">
		                                     <c:choose>
		                                     	<c:when test="${!empty user2.fileName}">
		                                     		<img src="/resources/upload/${user2.fileName}" alt="img" style="width: 100%; border-radius: 50%;">
		                                     	</c:when>
		                                     	<c:otherwise>
		                                     		<img src="/resources/images/account.jpg" alt="img" style="width: 100%; border-radius: 50%;">
		                                     	</c:otherwise>
		                                     </c:choose>                                               
	                                     </div>
                                     </div>
                                 </div>
                                 <div style="display: flex; flex-direction: column; flex-grow: 2;">
                                     <div style="display: flex; flex-direction: row; align-items: center; margin-bottom: 20px;">
                                         <div>
                                             <span style="font-size: 20px;">${user2.userId}</span>
                                         </div>
	                                     <div style="margin-left: 20px;">
	                                         <div>
	                                         	<c:choose>
	                                         		<c:when test="${user2.userId eq cookieUserId}">
	                                         			<button type="button" style="height: 30px; padding: 0 10px; border: none; border-radius: 5px; font-weight: bold; cursor: pointer;">프로필 편집</button>
	                                         		</c:when>
	                                         		<c:otherwise>
	                                         			<button type="button" style="height: 30px; padding: 0 10px; border: none; border-radius: 5px; font-weight: bold; cursor: pointer;">팔로우</button>
	                                         		</c:otherwise>
	                                         	</c:choose>
	                                         </div>
	                                     </div>
                                     </div>
                                     <div style="display: flex; flex-direction: row; margin-bottom: 20px;"> 
                                         <div style="margin-right: 40px;">
                                             <span>게시물</span>
                                             <span>${cnt}</span>
                                         </div>
                                         <div style="margin-right: 40px;">
                                             <span>팔로워</span>
                                             <span>0</span>
                                         </div>
                                         <div style="margin-right: 40px;">
                                             <span>팔로우</span>
                                             <span>0</span>
                                         </div>
                                     </div>
                                     <div style="display: flex; flex-direction: column; margin-bottom: 20px;">
                                         <span>${user2.userName}</span>
                                     </div>
                                     <div style="display: flex; flex-direction: column; margin-bottom: 20px;">
                                         <span style="font-weight: bold;">${user2.userIntro}</span>
                                     </div>
                                 </div>
                             </div>
                             <div style="display: flex; flex-direction: row; align-items: center; justify-content: center; border-top: 1px solid #dbdbdb;">
                                 <div style="cursor: pointer; height: 50px; display: flex; align-items: center; margin-right: 60px; border-top: 1px solid #000;">
                                     <div>
                                         <span>게시물</span>
                                     </div>
                                 </div>
                                 <div style="cursor: pointer; height: 50px; display: flex; align-items: center; margin-right: 60px;">
                                     <div>
                                         <span>저장됨</span>
                                     </div>
                                 </div>
                             </div>
                             <div>
								 <div style="display: flex; flex-direction: column;">
								    <c:set var="i" value="0"/>
								    <c:set var="j" value="3"/>
								    <c:choose>
								    <c:when test="${!empty list}">
								    <c:forEach var="board" items="${list}" varStatus="status">
								    <c:if test="${i%j == 0}">
								    <div style="display: flex; flex-direction: row; margin-bottom: 5px;">
								    </c:if>
							            <article style="margin-right: 5px;">
							                <div class="thumbImg" style="flex: 1 0 0%; width:auto;">
							                    <a href="javascript:void(0)" onclick="fn_view(${board.boardNum})">
							                        <img src="/resources/upload/${board.fileName}" style="background-color: #fff">
							                    </a>
							                </div>
							                <div class="links">
							                    <img src="/resources/images/heart-white.png" class="icon">
							                    <span style="color: #fff; padding: 0 10px">0</span>
							                    <img src="/resources/images/reply-white.png" class="icon">
							                    <span style="color: #fff; padding: 0 10px">0</span>
							                </div>
							            </article>
								    <c:if test="${i%j == j-1}">
								    </div>
								    </c:if>
								    <c:set var="i" value="${i+1}"/>
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
	<form name="bbsForm" id="bbsForm" method="POST">
		<input type="hidden" name="boardNum" value="">
		<input type="hidden" name="userId" value="${user.userId}">
	</form>
</body>
</html>