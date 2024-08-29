$(document).ready(function() {
	//홈
	$("#home").on("click", function() {
		location.href = "/main";
	});
	
	//검색
	$("#search").on("click", function() {
		location.href = "/main";
	});
	
	//메세지
	$("#msg").on("click", function() {
		location.href = "/main";
	});
	
	//알림
	$("#heart").on("click", function() {
		location.href = "/main";
	});
	
	//프로필
	$("#pro").on("click", function() {
		document.bbsForm.action = "/user/profile";
		document.bbsForm.submit();
	});
	
	//더보기
	$("#btn_more").on("click", function() {
    	if ($("#more").css("display") == "none") {
    		$("#more").css("display", "block");
    	}
    	
    	else {
    		$("#more").css("display", "none");
    	}
    	
    });
	
    //로그아웃
	$("#logout").on("click", function() {
		location.href = "/user/logout";
	});
	
	//설정
	$("#setting").on("click", function() {
		location.href = "/user/update";
	});
});

$(document).ready(function() {
	/* 모달창 컨트롤 */
	//만들기 클릭 모달창 활성
    $("#add").click(function() {
    	$(".wrap").css("display", "block");
    });
    
	//모달창 내 닫기 클릭 비활성
    $("#close").click(function() {
    	$(".wrap").css("display", "none");
    });
	
	//게시물 작성
	$("#share").on("click", function() {
		var form = $("#writeForm")[0];
		var formData = new FormData(form);
		
		if ($.trim($("#boardFile").val()).length <= 0) {
			alert("사진을 선택하세요");
			return;
		}
		
		if ($.trim($("#boardContent").val()).length <= 0) {
			alert("내용을 입력하세요");
			$("#boardContent").val("");
			$("#boardContent").focus();
			return;
		}
		
		$.ajax({
			type:"POST",
			enctype:"multipart/form-data",
			url:"/board/writeProc",
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
					alert("게시물이 등록되었습니다");
					location.href = "/main";
				}
				
				else if (response.code == 400) {
					alert("값이 올바르지 않습니다");
				}
				
				else {
					alert("게시물 등록 중 오류가 발생하였습니다");
				}
			},
			error:function(error) {
				icia.common.error(error);
				alert("게시물 등록 도중 알수없는 오류가 발생하였습니다");
			}
		});
	});
	
    $("input:file[name='boardFile']").change(function () {
        var str = $(this).val();
        var fileName = str.split('\\').pop().toLowerCase();
 
        checkFile(fileName);
    });
});

//파일 체크
function checkFile(str) {
	 
    //확장자 체크
    var ext = str.split('.').pop().toLowerCase();
    if($.inArray(ext, ['jpg', 'jpeg', 'png', 'gif']) == -1) {
        alert(ext+'파일은 업로드 하실 수 없습니다.');
        $("#boardFile").val("");
    }
 
    //특수문자 체크
    var pattern = /[\{\}\/?,;:|*~`!^\+<>@\#$%&\\\=\'\"]/gi;
    if(pattern.test(str) ){
        alert("파일명에 허용된 특수문자는 '-', '_', '(', ')', '[', ']', '.' 입니다.");
        $("#boardFile").val("");
    }
    
    //용량 체크
    var fileSize = document.getElementById("boardFile").files[0].size;
    var maxSize = 10 * 1024 * 1024;//10MB
    
    if (fileSize > maxSize) {
    	alert("첨부파일 사이즈는 10MB 이내로 등록 가능합니다");
    	$("#boardFile").val("");
    }
}

//ESC 모달창 닫기
$(document).keydown(function(e) {
	//keyCode 구 브라우저, which 현재 브라우저
    var code = e.keyCode || e.which;
 
    if (code == 27) { // 27은 ESC 키번호
    	$(".wrap").css("display", "none");
    	$("#boardFile").val("");
    	$("#boardContent").val("");
    	$("#preview").attr("src", "");
    }
});

//이미지 미리보기
function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
        document.getElementById('preview').src = e.target.result;
        };
        reader.readAsDataURL(input.files[0]);
    } 
    
    else {
        document.getElementById('preview').src = "/";
    }
}