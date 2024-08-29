<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<div style="width: 15%; height: 100vh; padding: 8px 12px 20px; display: flex; flex-direction: column; position: fixed; border-right: 1px solid #dbdbdb;">
    <div style="width: 100%; height: 90px;">
        <div class="logo" style="padding: 25px 10px 0px; margin-bottom: 20px; display: flex; justify-content: center;">
            <a href="/main"><img src="/resources/images/Sistagram.png" alt="Instagram" class="brand_logo" style="width: 9rem;"></a>
        </div>
    </div>
    <div style="width: 100%; flex-grow: 1;">
        <div>
            <div class="nav_bar" id="home">
                <div style="width: 100%; padding: 10px; margin-bottom: 5px; display: inline-flex; align-items: center;">
                    <div>
                        <img src="/resources/images/home.png" alt="home">
                    </div>
                    <div style="width: 100%; height: 24px; display: flex; align-items: center; padding-left: 10px;">
                        <span>홈</span>
                    </div>
                </div>
            </div>
        </div>
        <div>
            <div class="nav_bar" id="search">
                <div style="width: 100%; padding: 10px; margin-bottom: 5px; display: inline-flex; align-items: center;">
                    <div>
                        <img src="/resources/images/search.png" alt="search">
                    </div>
                    <div style="width: 100%; height: 24px; display: flex; align-items: center; padding-left: 10px;">
                        <span>검색</span>
                    </div>
                </div>
            </div>
        </div>
        <div>
            <div class="nav_bar" id="msg">
                <div style="width: 100%; padding: 10px; margin-bottom: 5px; display: inline-flex; align-items: center;">
                    <div>
                        <img src="/resources/images/msg.png" alt="msg">
                    </div>
                    <div style="width: 100%; height: 24px; display: flex; align-items: center; padding-left: 10px;">
                        <span>메세지</span>
                    </div>
                </div>
            </div>
        </div>
        <div>
            <div class="nav_bar" id="heart">
                <div style="width: 100%; padding: 10px; margin-bottom: 5px; display: inline-flex; align-items: center;">
                    <div>
                        <img src="/resources/images/heart.png" alt="heart">
                    </div>
                    <div style="width: 100%; height: 24px; display: flex; align-items: center; padding-left: 10px;">
                        <span>알림</span>
                    </div>
                </div>
            </div>
        </div>
        <div>
            <div class="nav_bar" id="add">
                <div style="width: 100%; padding: 10px; margin-bottom: 5px; display: inline-flex; align-items: center;">
                    <div>
                        <img src="/resources/images/add.png" alt="add">
                    </div>
                    <div style="width: 100%; height: 24px; display: flex; align-items: center; padding-left: 10px;">
                        <span>만들기</span>
                    </div>
                </div>
            </div>
        </div>
        <div>
            <div class="nav_bar" id="pro">
                <div style="width: 100%; padding: 10px; margin-bottom: 5px; display: inline-flex; align-items: center;">
                    <div>
                     	<c:choose>
                    	<c:when test="${!empty user.fileName}">
                    		<img src="/resources/upload/${user.fileName}" alt="img" style="width: 24px; height: 24px; border-radius: 50%;">
                    	</c:when>
                    	<c:otherwise>
                    		<img src="/resources/images/account.jpg" alt="img" style="width: 24px; height: 24px; border-radius: 50%;">
                    	</c:otherwise>
                    	</c:choose>     
                    </div>
                    <div style="width: 100%; height: 24px; display: flex; align-items: center; padding-left: 10px;">
                        <span>프로필</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div>
        <div class="nav_bar" id="btn_more">
            <div style="width: 100%; padding: 10px; margin-bottom: 5px; display: inline-flex; align-items: center;">
                <div>
                    <img src="/resources/images/menu.png" alt="img">
                </div>
                <div style="width: 100%; height: 24px; display: flex; align-items: center; padding-left: 10px;">
                    <span>더 보기</span>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 하단 더보기 -->
<div id="more" style="position: fixed; transform: translate(12px, 830px) translate(0px, -100%); top: 0; display: none">
	<div style="width: 200px; border: 1px solid #dbdbdb; border-radius: 10px; background-color: #fff; box-shadow: 1px 1px 1px 1px #dbdbdb;">
        <div class="nav_bar" id="setting">
            <div style="width: 100%; padding: 10px; margin-bottom: 5px; display: inline-flex; align-items: center;">
                <div style="width: 100%; height: 24px; display: flex; align-items: center; padding-left: 10px;">
                    <span>설정</span>
                </div>
            </div>
        </div>
        <div class="nav_bar" id="logout">
            <div style="width: 100%; padding: 10px; margin-bottom: 5px; display: inline-flex; align-items: center;">
                <div style="width: 100%; height: 24px; display: flex; align-items: center; padding-left: 10px;">
                    <span>로그아웃</span>
                </div>
            </div>
        </div>
	</div>
</div>
<!-- 하단 더보기 -->
<!-- 모달 -->
<div class="wrap" style="margin: 0 auto; width: 100%; height: 100%; display: none;">
<!-- 게시물 쓰기 폼 -->
    <form name="writeForm" id="writeForm" method="post" enctype="multipart/form-data">
        <div class="modal_box" style="width: 70%; height: auto; min-height: 300px; margin: 0 auto; padding: 20px; text-align: center; background-color: #fff; display: flex; flex-flow: column; position: fixed; top:50%; left: 50%; transform: translate(-50%, -50%); z-index: 999;">
            <div style="display: flex; flex-direction: column;">
                <div style="display: flex; flex-direction: row; align-items: center; height: 30px; border-bottom: 1px solid #dbdbdb;">
                	<div>
                		<label for="boardFile">사진선택</label>
                        <input type="file" id="boardFile" name="boardFile" onchange="readURL(this);" style="display: none;">
                	</div>
                    <div style="flex-grow: 1;">
                        새 게시물 만들기
                    </div>
                    <div id="share" style="flex-shrink: 0; cursor: pointer;">
                        <span>공유하기</span>
                    </div>
                </div>
                <div style="width: 100%; border: 1px solid #dbdbdb; display: flex; flex-direction: row;">
                    <!-- 좌측 -->
                    <div style="border-right: 1px solid #dbdbdb; display: flex; flex-grow: 1; align-items: center;">
                        <div style="width: 100%; display: flex; position: relative;">
                            <div style="padding-bottom: 100%;">
                                <img id="preview" style="width: 100%; height: 100%; position: absolute;">
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
                                    	<div style="width: 35px; height: 35px;">
                                 			<c:choose>
                            					<c:when test="${!empty user.fileName}">
                            						<img src="/resources/upload/${user.fileName}" alt="img" style="width:100%;"> 
                            					</c:when>
                            					<c:otherwise>
                            						<img src="/resources/images/account.jpg" alt="img" style="width: 100%;">
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
									<textarea style="width: 100%; height: 100%; border: none; resize: none;" id="boardContent" name="boardContent" placeholder="내용 입력"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <!-- 게시물 쓰기 폼 -->
    <!-- 모달창 끄기 -->
	<div class="modal_bg" style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.5); z-index: 99;">
		<div style="position: fixed; top: 10px; right: 10px;">
			<div style="padding: 10px; display: flex;">
				<a id="close" style="cursor: pointer;"><span style="font-size: 20px; color: #fff">X</span></a>
			</div>
		</div>
	</div>
	 <!-- 모달창 끄기 -->
</div>
<!-- 모달 -->