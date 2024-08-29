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
			//메뉴창 열고 닫기
			$("#btn_bomenu").on("click", function() {
				if ($("#bomenu").css("display") == "none") {
					$("#bomenu").css("display", "block");
				}
				
				else {
					$("#bomenu").css("display", "none");
				}
			});
			
			//수정버튼
			$("#btn_reg").on("click", function() {
				//alert("reg");
				$(".view").css("display", "block");
			});
			
			//x 닫기
			$("#closes").on("click", function() {
		    	//alert("close");
		    	$(".view").css("display", "none");
		    });
			
			//취소
			$("#cancel").on("click", function() {
		    	//alert("cancel");
		    	$(".view").css("display", "none");
		    });
			
			//수정
			$("#update").on("click", function() {
				//alert("update");
				//alert($("#boardContent").val())
				
				var form = $("#updateForm")[0];
				var formData = new FormData(form);
				
				$.ajax({
					type:"POST",
					enctype:"multipart/form-data",
					url:"/board/updateProc",
					data:formData,
					processData:false,
					contentType:false,
					cache:false,
					beforeSend:function(xhr) {
						xhr.setRequestHeader("AJAX", "true");
					},
					success:function(response) {
						if (response.code == 0) {
							alert("게시물이 수정되었습니다");
							document.bbsForm.action="/board/view";
							document.bbsForm.submit();
						}
						
						else if (response.code == 400) {
							alert("값이 올바르지 않습니다");
						}
						
						else if (response.code == 403) {
							alert("본인 게시물이 아닙니다");
							location.href = "/main";
						}
						
						else if (response.code == 404) {
							alert("게시물이 존재하지 않습니다");
							location.href = "/main";
						}
						
						else {
							alert("게시물 수정 중 오류가 발생하였습니다");
						}
					},
					error:function(error) {
						icia.common.error(error);
						alert("게시물 수정 도중 알수없는 오류가 발생하였습니다");
					}
				});
			});
			
			//삭제버튼
			$("#btn_del").on("click", function() {
				//alert("del");
				if (confirm("해당 게시물을 삭제하시겠습니까?") == true) {
					//alert("삭제합니다");
					$.ajax({
						type:"POST",
						url:"/board/delete",
						data:{
							boardNum:<c:out value="${boardNum}" />
						},
						datatype:"JSON",
						beforeSend:function(xhr) {
							xhr.setRequestHeader("AJAX", "true");
						},
						success:function(response) {
							if (response.code == 0) {
								alert("게시물이 삭제되었습니다");
								location.href = "/main";
							}
							
							else if (response.code == 400) {
								alert("값이 올바르지 않습니다");
							}
							
							else if (response.code == 403) {
								alert("본인 게시물이 아닙니다");	
							}
							
							else if (response.code == 404) {
								alert("게시물이 존재하지 않습니다");	
							}
							
							else {
								alert("게시물 삭제 중 오류가 발생하였습니다");	
							}
						},
						error:function(xhr, status, error) {
							icia.common.error(error);
							alert("게시물 삭제 도중 알수없는 오류가 발생하였습니다");
						}
					});
				}
			});
			
			//댓글버튼
			$("#comment").on("click", function() {
				$("#commentForm").css("display", "flex");
				$("#replyForm").css("display", "none");
				$("#commentContent").focus();
			});
			
			//답글버튼
			$(".reply").on("click", function() {
				var userId = $(this).data("userId");
				var commentNum = $(this).data("commentNum");
				//alert(userId);
				
				$("#commentForm").css("display", "none");
				$("#replyForm").css("display", "flex");
				$("#replyContent").val("@" + userId + " ");
				$("#replyContent").focus();
				$("#replyInsert").data("commentNum", commentNum);
			});
			
			//답글
			$("#replyInsert").on("click", function() {
				//alert("답글추가");
				var commentNum = $(this).data("commentNum");
				
				$.ajax({
					type:"POST",
					url:"/board/replyProc",
					data:{
						replyContent:$("#replyContent").val(),
						boardNum:${boardNum},
						commentNum:commentNum
					},
					dataType:"JSON",
					beforeSend:function(xhr) {
						xhr.setRequestHeader("AJAX", "true");
					},
					success:function(response) {
						if (response.code == 0) {
							alert("답글이 등록되었습니다");
							document.bbsForm.action="/board/view";
							document.bbsForm.submit();
						}
						
						else if (response.code == 400) {
							alert("값이 올바르지 않습니다");
						}
						
						else if (response.code == 404) {
							alert("댓글이 존재하지 않습니다");	
						}
						
						else {
							alert("답글 등록 중 오류가 발생하였습니다");	
						}
					},
					error:function(xhr, status, error) {
						icia.common.error(error);
						alert("답글 등록 도중 알수없는 오류가 발생하였습니다");
					}
				});
			});
			
			//댓글
			$("#comInsert").on("click", function() {
				$.ajax({
					type:"POST",
					url:"/board/commentProc",
					data:{
						commentContent:$("#commentContent").val(),
						boardNum:${boardNum}
					},
					dataType:"JSON",
					beforeSend:function(xhr) {
						xhr.setRequestHeader("AJAX", "true");
					},
					success:function(response) {
						if (response.code == 0) {
							alert("댓글이 등록되었습니다");
							document.bbsForm.action="/board/view";
							document.bbsForm.submit();
						}
						
						else if (response.code == 400) {
							alert("값이 올바르지 않습니다");
						}
						
						else if (response.code == 404) {
							alert("게시물이 존재하지 않습니다");	
						}
						
						else {
							alert("댓글 등록 중 오류가 발생하였습니다");	
						}
					},
					error:function(xhr, status, error) {
						icia.common.error(error);
						alert("댓글 등록 도중 알수없는 오류가 발생하였습니다");
					}
				});
			});
			
			//댓글 삭제
			$(".comdel").on("click", function() {
				var commentNum = $(this).data("commentNum");
				//alert("댓글 삭제");
				//alert($("#commentNum").val());
				
				if (confirm("댓글을 삭제하시겠습니까?") == true) {
					$.ajax({
						type:"POST",
						url:"/board/commentDel",
						data:{
							commentNum:commentNum,
							userId:"${userId}"
						},
						dataType:"JSON",
						beforeSend:function(xhr) {
							xhr.setRequestHeader("AJAX", "true");
						},
						success:function(response) {
							if (response.code == 0) {
								alert("삭제되었습니다");
								document.bbsForm.action="/board/view";
								document.bbsForm.submit();
							}
						},
						error:function(xhr, status, error) {
							icia.common.error(error);
						}
					});	
				}
			});
			
			//좋아요
			$("#like").on("click", function() {
				//alert("좋아요");
				//alert("${userId}");
				//alert(${boardNum});
				$.ajax({
					type:"POST",
					url:"/board/likeProc",
					data:{
						boardNum:${boardNum},
						userId:"${userId}"
					},
					dataType:"JSON",
					beforeSend:function(xhr) {
						xhr.setRequestHeader("AJAX", "true");
					},
					success:function(response) {
						if (response.code == 0) {
							//alert("등록되었습니다");
							$("#heart1").attr("src", "/resources/images/favorite2.png");
							$("#heart1").attr("id", "heart2");
							$("#likeCount").text("좋아요 " + response.data + "개");
						}
						
						else if (response.code == 1) {
							//alert("취소되었습니다");
							$("#heart2").attr("src", "/resources/images/favorite1.png");
							$("#heart2").attr("id", "heart1");
							$("#likeCount").text("좋아요 " + response.data + "개");
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
			
			//댓글 좋아요
			$(".likeCom").on("click", function() {
				var $this = $(this);
				var commentNum = $(this).data("commentNum");
				//alert("댓글 좋아요");
				//alert("${userId}");
				//alert(commentNum);
				
				$.ajax({
					type:"POST",
					url:"/board/likeProc2",
					data:{
						commentNum:commentNum,
						userId:"${userId}"
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
						}
						
						else if (response.code == 1) {
							//alert("취소되었습니다");
							$this.find("img").attr("src", "/resources/images/favorite1.png");
		                    $this.find("img").removeClass("heart2").addClass("heart1");
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
		
		//ESC 닫기
		$(document).keydown(function(e) {
		    var code = e.keyCode || e.which;
		 
		    if (code == 27) { // 27은 ESC 키번호
		    	$(".view").css("display", "none");
		    }
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
                        <div style="width: 1000px; padding: 30px 20px 0px 20px; margin: 0px auto 30px auto;  flex-grow: 1;">
                            <div style="width: 100%; display: flex;">
                                <div style="width: 100%; border: 1px solid #dbdbdb; display: flex; flex-direction: row;">
                                    <!-- 좌측 -->
                                    <div style="border-right: 1px solid #dbdbdb; display: flex; flex-grow: 1; align-items: center;">
                                        <div style="width: 100%; display: flex; position: relative;">
                                            <div style="padding-bottom: 100%;">
                                                <img src="/resources/upload/${board.fileName}" style="width: 100%; height: 100%; position: absolute;">
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 우측 -->
                                    <div style="width: 350px;">
                                        <div style="width: 100%; height: 100%; display: flex; flex-direction: column;">
                                            <!-- 프로필 -->
                                            <div style="padding: 16px;">
                                                <div style="width: 100%; display: flex; flex-direction: row; align-items: center;">
                                                    <div style="margin-right: 15px;">
                                                        <div style="width: 32px; height: 32px;">
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
                                                    <div style="display: flex; flex-grow: 1;">
                                                        <div style="width: 100%;">
	                                                    	<a href="javascript:void(0)" onclick="fn_pro('${board.userId}')">
	                                                        	<span id="userId" style="font-weight: bold; color: #000">${board.userId}</span>
															</a>
                                                        </div>
                                                    </div>
	                                                <c:if test="${board.userId eq cookieUserId}">
	                                                <div id="btn_bomenu" style="display: flex; align-items: center; transform: translateY(1px); cursor: pointer;">
	                                                	<img src="/resources/images/more.png" alt="img">
	                                                    <div id="bomenu" style="position: fixed; top: 0; transform: translate(-35px, 30px); display: none;">
														    <div style="width: 100px; border: 1px solid #dbdbdb; border-radius: 10px; background-color: #fff; box-shadow: 1px 1px 1px 1px #dbdbdb; text-align: center;">
														        <div id="btn_reg" style="padding: 10px;">
														            <span>수정</span>
														        </div>
														        <div id="btn_del" style="padding: 10px;">
														            <span>삭제</span>
														        </div>
														    </div>
														</div>
	                                                </div>
													</c:if>
                                                </div>
                                            </div>
                                            <!-- 본문 -->
                                            <div style="height: 375px;">
                                                <div style="width: 100%; height: 100%; padding: 0 16px; display: flex; flex-direction: column; border-top: 1px solid #dbdbdb; border-bottom: 1px solid #dbdbdb;">
                                                    <div>
                                                        <div style="padding: 12px 0; display: flex; flex-direction: row;">
                                                            <div style="margin-right: 15px;">
		                                                        <div style="width: 32px; height: 32px;">
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
                                                            <div style="display: flex; flex-grow: 1;">
                                                                <div style="width: 100%;">
                                                                    <div style="display: flex; flex-direction: column;">
                                                                        <div style="display: flex; flex-direction: row;">
					                                                    	<a href="javascript:void(0)" onclick="fn_pro('${board.userId}')">
					                                                        	<span id="userId" style="font-weight: bold; color: #000">${board.userId}</span>
																			</a>
                                                                            &nbsp;
                                                                            <span>
                                                                                ${board.regDate}
                                                                            </span>
                                                                        </div>
                                                                        <div>
																			<pre style="display: inline; white-space: pre-wrap;"><c:out value="${board.boardContent}" /></pre>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                   	<c:choose>
                                                   		<c:when test="${!empty list}">
                                                   			<!-- 댓글 있을떄 -->
                                                   			<div style="max-height: 310px; overflow-y: scroll; display: flex; flex-direction: column; flex-grow: 1;">
		                                                        <div style="display: flex; flex-direction: column;">
		                                                            <!-- 댓글 -->
		                                                            <c:forEach var="comment" items="${list}" varStatus="status">
		                                                            	<c:choose>
		                                                            		<c:when test="${comment.commentOrder == 0}">
		                                                            			<div style="padding: 12px 0; display: flex; flex-direction: row;">
				                                                                    <div style="margin-right: 15px;">
								                                                        <div style="width: 32px; height: 32px;">
																                            <a href="javascript:void(0)" onclick="fn_pro('${comment.userId}')">
													                                            <c:choose>
													                                            	<c:when test="${!empty comment.fileName}">
													                                            		<img src="/resources/upload/${comment.fileName}" alt="img" style="width: 32px; height: 32px; border-radius: 50%;">
													                                            	</c:when>
													                                            	<c:otherwise>
													                                            		<img src="/resources/images/account.jpg" alt="img" style="width: 32px; height: 32px; border-radius: 50%;">
													                                            	</c:otherwise>
													                                            </c:choose>
												                                            </a>
								                                                        </div>
				                                                                    </div>
				                                                                    <div style="display: flex; flex-direction: row; flex-grow: 1;">
				                                                                        <div style="display: flex; flex-direction: column; flex-grow: 1;">
				                                                                            <div style="display: flex; flex-direction: column;">
				                                                                                <div style="display: flex; flex-direction: row;">
								                                                                    <a href="javascript:void(0)" onclick="fn_pro('${comment.userId}')">
											                                                        	<span id="userId" style="font-weight: bold; color: #000">${comment.userId}</span>
																									</a>
				                                                                                    &nbsp;
				                                                                                    <span>
				                                                                                        ${comment.regDate}
				                                                                                    </span>
				                                                                                </div>
				                                                                                <div>
				                                                                                	<input type="hidden" id="commentNum" name="commentNum" value="${comment.commentNum}">
				                                                                                    <span>
				                                                                                        ${comment.commentContent}
				                                                                                    </span>
				                                                                                </div>
				                                                                            </div>
				                                                                            <div style="margin-top: 8px; display: flex; flex-grow: 0;">
				                                                                                <div style="margin-right: 12px; display: flex; align-items: center;">
				                                                                                	<div class="reply" data-user-id="${comment.userId}" data-comment-num="${comment.commentNum}" style="cursor: pointer;">
				                                                                                		<span>답글 달기</span>
				                                                                                	</div>
				                                                                                    &nbsp;
				                                                                                    <c:if test="${comment.userId eq cookieUserId}">
				                                                                                    <div class="comdel" data-comment-num="${comment.commentNum}" style="cursor: pointer;">
																										<span>삭제</span>
																									</div>
																									</c:if>
																								</div>
				                                                                            </div>
				                                                                        </div>
				                                                                        <div style="margin-left: 8px; display: flex; flex-direction: column; justify-content: center;">
				                                                                            <c:choose>
								                                                            	<c:when test="${comment.isLike == 0}">
								                                                            		<a class="likeCom" data-comment-num="${comment.commentNum}" style="cursor: pointer;">
								                                                            			<img id="heart1" src="/resources/images/favorite1.png">
								                                                            		</a>
								                                                            	</c:when>
								                                                            	<c:otherwise>
								                                                            		<a class="likeCom" data-comment-num="${comment.commentNum}" style="cursor: pointer;">
								                                                            			<img id="heart2" src="/resources/images/favorite2.png">
								                                                            		</a>
								                                                            	</c:otherwise>
								                                                            </c:choose>
				                                                                        </div>
				                                                                    </div>
				                                                                </div>
		                                                            		</c:when>
		                                                            		<c:otherwise>
		                                                            			<!-- 답글 -->
					                                                            <div style="margin-left: 47px; display: flex; flex-direction: column;">
					                                                                <div id="reply">
					                                                                    <div style="padding: 12px 0; display: flex; flex-direction: row;">
						                                                                    <div style="margin-right: 15px;">
										                                                        <div style="width: 32px; height: 32px;">
																		                            <a href="javascript:void(0)" onclick="fn_pro('${comment.userId}')">
															                                            <c:choose>
															                                            	<c:when test="${!empty comment.fileName}">
															                                            		<img src="/resources/upload/${comment.fileName}" alt="img" style="width: 32px; height: 32px; border-radius: 50%;">
															                                            	</c:when>
															                                            	<c:otherwise>
															                                            		<img src="/resources/images/account.jpg" alt="img" style="width: 32px; height: 32px; border-radius: 50%;">
															                                            	</c:otherwise>
															                                            </c:choose>
														                                            </a>
										                                                        </div>
						                                                                    </div>
						                                                                    <div style="display: flex; flex-direction: row; flex-grow: 1;">
						                                                                        <div style="display: flex; flex-direction: column; flex-grow: 1;">
						                                                                            <div style="display: flex; flex-direction: column;">
						                                                                                <div style="display: flex; flex-direction: row;">
										                                                                    <a href="javascript:void(0)" onclick="fn_pro('${comment.userId}')">
													                                                        	<span id="userId" style="font-weight: bold; color: #000">${comment.userId}</span>
																											</a>
						                                                                                    &nbsp;
						                                                                                    <span>
						                                                                                        ${comment.regDate}
						                                                                                    </span>
						                                                                                </div>
						                                                                                <div>
						                                                                                	<input type="hidden" id="commentNum" name="commentNum" value="${comment.commentNum}">
						                                                                                    <span>
						                                                                                        ${comment.commentContent}
						                                                                                    </span>
						                                                                                </div>
						                                                                            </div>
						                                                                            <div style="margin-top: 8px; display: flex; flex-grow: 0;">
						                                                                                <div style="margin-right: 12px; display: flex; align-items: center;">
						                                                                                	<div class="reply" data-user-id="${comment.userId}" data-comment-num="${comment.commentNum}" style="cursor: pointer;">
						                                                                                		<span>답글 달기</span>
						                                                                                	</div>
						                                                                                    &nbsp;
						                                                                                    <c:if test="${comment.userId eq cookieUserId}">
						                                                                                    <div class="comdel" data-comment-num="${comment.commentNum}" style="cursor: pointer;">
																												<span>삭제</span>
																											</div>
																											</c:if>
																										</div>
						                                                                            </div>
						                                                                        </div>
						                                                                        <div style="margin-left: 8px; display: flex; flex-direction: column; justify-content: center;">
						                                                                            <c:choose>
										                                                            	<c:when test="${comment.isLike == 0}">
										                                                            		<a class="likeCom" data-comment-num="${comment.commentNum}" style="cursor: pointer;">
										                                                            			<img id="heart1" src="/resources/images/favorite1.png">
										                                                            		</a>
										                                                            	</c:when>
										                                                            	<c:otherwise>
										                                                            		<a class="likeCom" data-comment-num="${comment.commentNum}" style="cursor: pointer;">
										                                                            			<img id="heart2" src="/resources/images/favorite2.png">
										                                                            		</a>
										                                                            	</c:otherwise>
										                                                            </c:choose>
						                                                                        </div>
						                                                                    </div>
						                                                                </div>
					                                                                </div>
					                                                            </div>
		                                                            		</c:otherwise>
		                                                            	</c:choose>
		                                                            </c:forEach>
		                                                        </div>
		                                                    </div>
                                                   		</c:when>
                                                   		<c:otherwise>
                                                   			<!-- 댓글 없을때 -->
	                                                   		<div style="display: flex; flex-grow: 1;">
		                                                        <div style="flex-grow: 1;">
		                                                            <div style="height: 100%; display: flex; flex-direction: column; justify-content: center; align-items: center;">
		                                                                <div>
		                                                                    <div style="margin-bottom: 10px;">
		                                                                        <span style="font-size: 24px; font-weight: bold;">
		                                                                            아직 댓글이 없습니다
		                                                                        </span>
		                                                                    </div>
		                                                                    <div style="margin-top: 10px; display: flex; flex-direction: column; text-align: center;">
		                                                                        <span style="font-size: 14px; font-weight: 400;">
		                                                                            댓글을 남겨보세요
		                                                                        </span>
		                                                                    </div>
		                                                                </div>
		                                                            </div>
		                                                        </div>
		                                                    </div>
                                                   		</c:otherwise>
                                                   	</c:choose>
                                                </div>
                                            </div>
                                            <!-- 아이콘 -->
                                            <div style="width: 100%; padding: 5px 15px;">
                                                <div style="display: grid; grid-template-columns: 1fr 1fr; align-items: center;">
                                                    <div style="display: flex; flex-direction: row;">
                                                        <div style="padding: 8px; margin-left: -8px;">
                                                            <c:choose>
                                                            	<c:when test="${isLike == 0}">
                                                            		<a id="like" style="cursor: pointer;">
                                                            			<img id="heart1" src="/resources/images/favorite1.png">
                                                            		</a>
                                                            	</c:when>
                                                            	<c:otherwise>
                                                            		<a id="like" style="cursor: pointer;">
                                                            			<img id="heart2" src="/resources/images/favorite2.png">
                                                            		</a>
                                                            	</c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                        <div style="padding: 8px; cursor: pointer;">
                                                            <img id="comment" name="comment" src="/resources/images/reply.png">
                                                        </div>
                                                    </div>
                                                    <div style="margin-left: auto;">
                                                        <div>
                                                            <img src="/resources/images/mark.png">
                                                        </div>
                                                    </div>
                                                </div>
                                                
                                                <div style="margin-bottom: 10px;">
													<span id="likeCount" style="font-size: 14px; font-weight: bold;">
														좋아요 ${likeCnt}개
													</span>
												</div>
												
                                                <div style="margin-bottom: 15px;">
                                                    <span style="font-size: 14px; color: #737373">
                                                        ${board.regDate}
                                                    </span>
                                                </div>
                                                
                                            </div>
                                            <!-- 댓글달기 -->
                                            <div style="margin: 0 16px;">
                                                <div style="padding: 8px 0; display: flex; flex-direction: row;">
                                                    <div style="width: 32px; height: 32px;">
                                                 		<c:choose>
                                            				<c:when test="${!empty user.fileName}">
                                            					<img src="/resources/upload/${user.fileName}" alt="img" style="width: 32px; height: 32px; border-radius: 50%;">
                                            				</c:when>
                                            				<c:otherwise>
                                            					<img src="/resources/images/account.jpg" alt="img" style="width: 32px; height: 32px; border-radius: 50%;">
                                            				</c:otherwise>
                                           				</c:choose>
                                                    </div>
                                                    
                                                    <form name="commentForm" id="commentForm" method="POST" style="padding: 8px; display: flex; flex-grow: 1;">
                                                        <div style="display: flex; flex-direction: row; flex-grow: 1; align-items: center;">
                                                            <textarea name="commentContent" id="commentContent" placeholder="댓글달기" style="height: 18px; max-height: 80px; flex-grow: 1; border-style: none; resize: none; outline: none; overflow: hidden; color: #000;"></textarea>
                                                        </div>
                                                        <div style="margin: 0 8px; font-weight: bold; cursor: pointer;">
                                                            <span id="comInsert">
                                                                게시
                                                            </span>
                                                        </div>
                                                        <input type="hidden" name="boardNum" value="${board.boardNum}">
                                                    </form>
                                                    
                                                    <form name="replyForm" id="replyForm" method="POST" style="padding: 8px; display: none; flex-grow: 1;">
                                                        <div style="display: flex; flex-direction: row; flex-grow: 1; align-items: center;">
                                                            <textarea name="replyContent" id="replyContent" style="height: 18px; max-height: 80px; flex-grow: 1; border-style: none; resize: none; outline: none; overflow: hidden; color: #000;"></textarea>
                                                        </div>
                                                        <div style="margin: 0 8px; font-weight: bold; cursor: pointer;">
                                                            <span id="replyInsert">
                                                                게시
                                                            </span>
                                                        </div>
                                                    </form>
                                                    
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
        </div>
    </div>
    <form name="bbsForm" id="bbsForm" method="POST">
    	<input type="hidden" name="boardNum" value="${board.boardNum}">
    	<input type="hidden" name="userId" value="${user.userId}">
	</form>
	
	<!-- 모달 -->
	<div class="view" style="margin: 0 auto; width: 100%; height: 100%; display: none;">
	<!-- 게시물 쓰기 폼 -->
	    <form name="updateForm" id="updateForm" method="POST" enctype="multipart/form-data">
	        <div class="modal_box" style="width: 60%; height: auto; min-height: 300px; margin: 0 auto; padding: 20px; text-align: center; background-color: #fff; display: flex; flex-flow: column; position: fixed; top:50%; left: 50%; transform: translate(-50%, -50%); z-index: 999;">
	            <div style="display: flex; flex-direction: column;">
	                <div style="display: flex; flex-direction: row; align-items: center; height: 30px; border-bottom: 1px solid #dbdbdb;">
	                	<div id="cancel" style="cursor: pointer;">
	                		<span>취소</span>
	                	</div>
	                    <div style="flex-grow: 1;">
	                        <span>정보 수정</span>
	                    </div>
	                    <div id="update" style="cursor: pointer;">
	                        <span>완료</span>
	                    </div>
	                </div>
	                <div style="width: 100%; border: 1px solid #dbdbdb; display: flex; flex-direction: row;">
	                    <!-- 좌측 -->
	                    <div style="border-right: 1px solid #dbdbdb; display: flex; flex-grow: 1; align-items: center;">
	                        <div style="width: 100%; display: flex; position: relative;">
	                            <div style="padding-bottom: 100%;">
	                                <img src="/resources/upload/${board.fileName}" style="width: 100%; height: 100%; position: absolute;">
	                            </div>
	                        </div>
	                    </div>
	                    <!-- 우측 -->
	                    <div style="width: 350px;">
	                        <div style="width: 100%; height: 100%; display: flex; flex-direction: column;">
	                            <!-- 프로필 -->
	                            <div style="padding: 16px;">
	                                <div style="width: 100%; display: flex; flex-direction: row; align-items: center;">
	                                	<div style="margin-right: 15px;">
	                                    	<div style="width: 32px; height: 32px;">
	                                 			<c:choose>
	                            					<c:when test="${!empty user.fileName}">
	                            						<img src="/resources/upload/${user.fileName}" alt="img" style="width: 32px; height: 32px; border-radius: 50%;"> 
	                            					</c:when>
	                            					<c:otherwise>
	                            						<img src="/resources/images/account.jpg" alt="img" style="width: 32px; height: 32px; border-radius: 50%;">
	                            					</c:otherwise>
	                            				</c:choose>
	                                    	</div>
	                                    </div>
	                                    <div style="display: flex;">
	                                        <div style="width: 100%;">
	                                            <span style="font-size: 16px; font-weight: bold;">
	                                                ${user.userId}
	                                            </span>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                            <!-- 본문 -->
	                            <div style="height: 100%;">
	                                <div style="width: 100%; height: 100%; padding: 16px; display: flex; flex-direction: column; border-top: 1px solid #dbdbdb; border-bottom: 1px solid #dbdbdb;">
										<textarea id="boardContent" name="boardContent" style="width: 100%; height: 100%; border: none; resize: none;" placeholder="내용 입력"><c:out value="${board.boardContent}" /></textarea>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	        <input type="hidden" name="boardNum" value="${board.boardNum}">
	    </form>
	    <!-- 게시물 쓰기 폼 -->
	    <!-- 모달창 끄기 -->
		<div class="modal_bg" style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.5); z-index: 99;">
			<div style="position: fixed; top: 10px; right: 10px;">
				<div style="padding: 10px; display: flex;">
					<a id="closes" style="cursor: pointer;"><span style="font-size: 20px; color: #fff">X</span></a>
				</div>
			</div>
		</div>
		 <!-- 모달창 끄기 -->
	</div>
	<!-- 모달 -->
</body>
</html>