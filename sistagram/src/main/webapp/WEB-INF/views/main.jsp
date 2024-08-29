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
			//좋아요
			$(".like").on("click", function() {
				var $this = $(this);
				var boardNum = $(this).data("boardNum");
				//alert("좋아요");
				//alert("${cookieUserId}");
				//alert(boardNum);
				
				$.ajax({
					type:"POST",
					url:"/board/likeProc",
					data:{
						boardNum:boardNum,
						userId:"${cookieUserId}"
					},
					dataType:"JSON",
					beforeSend:function(xhr) {
						xhr.setRequestHeader("AJAX", "true");
					},
					success:function(response) {
						if (response.code == 0) {
							//alert("등록되었습니다");
							$this.find("img").attr("src", "/resources/images/favorite2.png");
                    		$this.find("img").removeClass("heart1").addClass("heart2");
                    		location.reload();
						}
						
						else if (response.code == 1) {
							//alert("취소되었습니다");
							$this.find("img").attr("src", "/resources/images/favorite1.png");
		                    $this.find("img").removeClass("heart2").addClass("heart1");
		                    location.reload();
						}
					
						else if (response.code == 400) {
							alert("값이 올바르지 않습니다");
						}
						
						else if (response.code == 500) {
							alert("좋아요 등록 중 오류가 발생하였습니다");
						}
						
						else {
							alert("좋아요 등록 도중 알수없는 오류가 발생하였습니다");
						}
					},
					error:function(xhr, status, error) {
						icia.common.error(error);
					}
				});
				
			});
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
							                                            		<img src="/resources/upload/${board.ufileName}" alt="img" style="width: 35px; height: 35px; border-radius: 50%;">
							                                            	</c:when>
							                                            	<c:otherwise>
							                                            		<img src="/resources/images/account.jpg" alt="img" style="width: 35px; height: 35px; border-radius: 50%;">
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
	                                                                <div style="padding: 8px;">
	                                                                	<a class="like" data-board-num="${board.boardNum}" style="cursor: pointer;">
	                                                                    <c:choose>
			                                                            	<c:when test="${board.isLike == 0}">
			                                                            		<img class="heart1" src="/resources/images/favorite1.png">
			                                                            	</c:when>
			                                                            	<c:otherwise>
			                                                            		<img class="heart2" src="/resources/images/favorite2.png">
			                                                            	</c:otherwise>
			                                                            </c:choose>
			                                                            </a>
	                                                                </div>
	                                                                <div style="padding: 8px;">
	                                                                    <a class="reply" style="cursor: pointer" href="javascript:void(0)" onclick="fn_view(${board.boardNum})">
	                                                                    	<img src="/resources/images/reply.png" alt="img">
	                                                                    </a>
	                                                                </div>
	                                                            </div>
	                                                            <div style="margin-left: auto;">
	                                                                <a style="cursor: pointer">
	                                                                	<img src="/resources/images/mark.png" alt="img">
	                                                                </a>
	                                                            </div>
	                                                        </div>
	                                                        <div>
	                                                        	<span class="likeCount" data-type="${board.boardNum}" style="font-weight: bold;">
	                                                        		좋아요 ${board.likeCnt}개
	                                                        	</span>
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
	                                                            	<pre style="display: inline; white-space: pre-wrap;"><c:out value="${board.boardContent}" /></pre>
	                                                            </div>
	                                                        </div>
	                                                        <div style="margin-top: 10px;">
	                                                        	<c:choose>
	                                                        		<c:when test="${board.commentCnt == 0}">
	                                                        			<a class="reply" style="cursor: pointer" href="javascript:void(0)" onclick="fn_view(${board.boardNum})">
	                                                        				<span>댓글 보기</span>
	                                                        			</a>
	                                                        		</c:when>
	                                                        		<c:otherwise>
	                                                        			<a style="cursor: pointer" href="javascript:void(0)" onclick="fn_view(${board.boardNum})">
	                                                        				<span>댓글 ${board.commentCnt}개 모두보기</span>
	                                                        			</a>
	                                                        		</c:otherwise>
	                                                        	</c:choose>
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
			                                            		<img src="/resources/upload/${user.fileName}" alt="img" style="width: 35px; height: 35px; border-radius: 50%;">
			                                            	</c:when>
			                                            	<c:otherwise>
			                                            		<img src="/resources/images/account.jpg" alt="img" style="width: 35px; height: 35px; border-radius: 50%;">
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
	                                        	<c:when test="${!empty random}">
	                                        		<c:forEach var="random" items="${random}" varStatus="status">
		                                        		<div style="width: 100%;">
			                                            	<div style="padding: 10px;">
			                                                	<div style="display: flex; flex-direction: row; justify-content: space-between;">
			                                                    	<div style="margin-right: 10px;">
							                                            <div style="cursor: pointer;">
								                                            <a href="javascript:void(0)" onclick="fn_pro('${random.userId}')">
									                                            <c:choose>
									                                            	<c:when test="${!empty random.fileName}">
									                                            		<img src="/resources/upload/${random.fileName}" alt="img" style="width: 35px; height: 35px; border-radius: 50%;">
									                                            	</c:when>
									                                            	<c:otherwise>
									                                            		<img src="/resources/images/account.jpg" alt="img" style="width: 35px; height: 35px; border-radius: 50%;">
									                                            	</c:otherwise>
									                                            </c:choose>
								                                            </a>                                               
							                                            </div>
				                                                    </div>
				                                                    <div style="width: 100%; display: flex;">
			    	                                                    <div style="display: flex; flex-direction: column; justify-content: center; flex-grow: 1;">
			                                                            	<span style="font-weight: bold;">
			                                                            		${random.userId}
			                                                            	</span>
			        	                                                    <span>
			        	                                                    	${random.userName}
			        	                                                    </span>
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
</body>
</html>