<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>photoGalleryContent.jsp</title>
  <%@ include file = "/WEB-INF/views/include/bs5.jsp" %>
  <style>
	  /* Make the image fully responsive */
	  .carousel-inner img {
	    width: 100%;
	    height: 100%;
	  }
  </style>
  <script>
    'use strict';
    
    $(function() {
    	$("#photoGalleryContentView").hide();
    });
    
    function replyHide() {
    	$("#replyHideBtn").hide();
    	$("#replyShowBtn").show();
    	$("#replyList").hide();
    }
    
    function replyShow() {
    	$("#replyHideBtn").show();
    	$("#replyShowBtn").hide();
    	$("#replyList").show();
    }
    
    function replyInputShow() {
    	$("#replyInput").toggle();
    }
    
    // 내용 삭제하기
    function deleteCheck(idx) {
    	let ans = confirm("현재 게시글을 삭제하시겠습니까?");
    	if(!ans) return false;
    	else location.href = "photoGalleryDelete?idx="+idx;
    }
    
    // 댓글달기
    function replyCheck() {
    	let content = $("#content").val();
    	if(content.trim() == "") {
    		alert("댓글을 입력하세요");
    		return false;
    	}
    	let query = {
    			mid				: '${sMid}',
    			photoIdx	: '${vo.idx}',
    			content		: content
    	}
    	
    	$.ajax({
    		url  : "${ctp}/photoGallery/photoGalleryReplyInput",
    		type : "post",
    		data : query,
    		success:function(res) {
    			if(res != 0) {
    				alert("댓글이 입력되었습니다.");
    				location.reload();
    			}
    			else alert("댓글 입력 실패~~");
    		},
    		error : function() {
    			alert("전송 오류!");
    		}
    	});
    }
    
    // 댓글 삭제하기
    function replyDelete(idx) {
    	let ans = confirm("선택한 댓글을 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		url  : "${ctp}/photoGallery/photoGalleryReplyDelete",
    		type : "post",
    		data : {idx : idx},
    		success:function(res) {
    			if(res != 0) {
    				alert("댓글이 삭제되었습니다.");
    				location.reload();
    			}
    			else alert("삭제 실패~~");
    		},
    		error : function() {
    			alert("전송 오류!");
    		}
    	});
    }
    
    // 좋아요 처리(중복불허)
    function goodCheck() {
    	$.ajax({
    		url  : "${ctp}/photoGallery/photoGalleryGoodCheck",
    		type : "post",
    		data : {idx : ${vo.idx}},
    		success:function(res) {
    			if(res != 0) location.reload();
    			else alert("이미 좋아요 버튼을 클릭하셨습니다.");
    		},
    		error : function() {
    			alert("전송오류");
    		}
    	});
    }
    
    // 화살표클릭시 화면 상단으로 부드럽게 이동하기
    $(window).scroll(function(){
    	if($(this).scrollTop() > 100) {
    		$("#topBtn").addClass("on");
    	}
    	else {
    		$("#topBtn").removeClass("on");
    	}
    	
    	$("#topBtn").click(function(){
    		window.scrollTo({top:0, behavior: "smooth"});
    	});
    });
    
    // 원래 내용으로 보여주기
    function photoGalleryContentViewCheck() {
    	$("#photoGalleryImageView").hide();
    	$("#photoGalleryContentView").show();
    	$("#photoGalleryContentViewBtn").hide();
    	$("#photoGalleryImageViewBtn").show();
    }
    
    // 그림으로 보여주기
    function photoGalleryImageViewCheck() {
    	$("#photoGalleryImageView").show();
    	$("#photoGalleryContentView").hide();
    	$("#photoGalleryContentViewBtn").show();
    	$("#photoGalleryImageViewBtn").hide();
    }
  </script>
  
  <style>
		h6 {
		  position: fixed;
		  right: 1rem;
		  bottom: -50px;
		  transition: 0.7s ease;
		}
   	.on {
		  opacity: 0.8;
		  cursor: pointer;
		  bottom: 0;
		}
	</style>
</head>
<body>
<p><br/></p>
<div class="container">
  <div class="row">
  	<div class="col"><h2>[${vo.part}] ${vo.title}</h2></div>
  	<div class="col text-end mt-4"><a href="photoGalleryList" class="btn btn-secondary btn-sm">목록으로</a></div>
  </div>
  <div class="row">
    <div class="col">
      ${vo.mid} | ${fn:substring(vo.PDate,0,16)} | ${vo.hostIp}
    </div>
    <div class="col text-end">
      <i class="fa-regular fa-pen-to-square" title="댓글수"></i> ${vo.replyCnt} &nbsp;
	    <i class="fa-regular fa-face-grin-hearts" title="좋아요"></i> ${vo.goodCount} &nbsp;
	    <i class="fa-regular fa-eye" title="조회수"></i> ${vo.readNum} &nbsp;
	    <i class="fa-solid fa-layer-group" title="사진수"></i> ${vo.photoCount}
    </div>
  </div>
  <br/>
  
	<div id="demo" class="carousel slide" data-bs-ride="carousel">
	  <!-- Indicators -->
	  <ul class="carousel-indicators">
		  <c:forEach var="i" begin="0" end="${fn:length(photoList)-1}" varStatus="st">
		    <c:if test="${i == 0}"><li data-bs-target="#demo" data-bs-slide-to="${st.index}" class="active"></li></c:if>
		    <c:if test="${i != 0}"><li data-bs-target="#demo" data-bs-slide-to="${st.index}"></li></c:if>
		  </c:forEach>
	  </ul>
	  
	  <!-- The slideshow -->
	  <div class="carousel-inner">
	    <c:forEach var="photo" items="${photoList}" varStatus="st">
		    <c:if test="${st.index == 0}"><div class="carousel-item active"></c:if>
		    <c:if test="${st.index != 0}"><div class="carousel-item"></c:if>
		      <img src="${ctp}/photoGallery/${photo}" title="${photo}" alt="${photo}" width="100%" />
		    </div>
	    </c:forEach>
	  </div>
	  
	  <!-- Left and right controls -->
	  <a class="carousel-control-prev" href="#demo" data-bs-slide="prev">
	    <span class="carousel-control-prev-icon"></span>
	  </a>
	  <a class="carousel-control-next" href="#demo" data-bs-slide="next">
	    <span class="carousel-control-next-icon"></span>
	  </a>
	</div>

  <hr/>
  <div class="row">
    <div class="col">
      <input type="button" value="돌아가기" onclick="location.href='photoGalleryList';" class="btn btn-primary"/>
      <input type="button" value="내용보기" onclick="photoGalleryContentViewCheck()" id="photoGalleryContentViewBtn" class="btn btn-success"/>
      <input type="button" value="그림보기" onclick="photoGalleryImageViewCheck()" id="photoGalleryImageViewBtn" class="btn btn-success" style="display:none;"/>
      <input type="button" value="댓글가리기" onclick="replyHide()" id="replyHideBtn" class="btn btn-info"/>
      <input type="button" value="댓글보이기" onclick="replyShow()" id="replyShowBtn" class="btn btn-secondary" style="display:none;"/>
      <c:if test="${sMid == vo.mid}">
	      <input type="button" value="수정" onclick="location.href='photoGalleryUpdate?idx=${vo.idx}'" class="btn btn-warning"/>
	      <input type="button" value="삭제" onclick="deleteCheck(${vo.idx})" class="btn btn-danger"/>
      </c:if>
    </div>
    <div class="col text-end" style="font-size:22px">
      <a href="javascript:replyInputShow()"><i class="fa-regular fa-pen-to-square" title="댓글쓰기"></i></a> ${vo.replyCnt} &nbsp;
      <a href="javascript:goodCheck()"><i class="fa-regular fa-face-grin-hearts text-danger" title="좋아요 선택"></i></a> ${vo.goodCount}
    </div>
  </div>
  <!-- 댓글 입력창 -->
  <div id="replyInput" style="display:none;">
		<!-- 댓글 입력창 -->
		<form name="replyForm">
		  <table class="table table-center">
		    <tr>
		      <td style="width:85%" class="text-left">
		        글내용 :
		        <textarea rows="4" name="content" id="content" class="form-control"></textarea>
		      </td>
		      <td style="width:15%">
		        <br/>
		        <p>작성자 : ${sNickName}</p>
		        <p><input type="button" value="댓글달기" onclick="replyCheck()" class="btn btn-info btn-sm"/></p>
		      </td>
		    </tr>
		  </table>
		</form>
  </div>
  <hr/>
  <div id="replyList">
	  <!-- 댓글 리스트 보여주기 -->
		<table class="table table-hover text-center">
		  <tr class="table-secondary">
		    <th>작성자</th>
		    <th>댓글내용</th>
		    <th>댓글일자</th>
		  </tr>
		  <c:forEach var="replyVo" items="${replyVos}" varStatus="st">
		    <tr>
		      <td>${replyVo.mid}
		        <c:if test="${sMid == replyVo.mid || sLevel == 0}">
		          (<a href="javascript:replyDelete(${replyVo.idx})" title="댓글삭제">x</a>)
		        </c:if>
		      </td>
		      <td class="text-start">${fn:replace(replyVo.content,newLine,"<br/>")}</td>
		      <td>${fn:substring(replyVo.prDate, 0, 10)}</td>
		    </tr>
		  </c:forEach>
		  <tr><td colspan="3" class='m-0 p-0'></td></tr>
		</table>
  </div>
  <hr/>
  <div class="text-center" id="photoGalleryImageView">
	  <c:forEach var="photo" items="${photoList}" varStatus="st">
	  	<img src="${ctp}/photoGallery/${photo}" width="90%"/><br/><br/>
	  </c:forEach>
  </div>
  <div class="text-center" id="photoGalleryContentView">
	  ${vo.content}
  </div>
  <hr/>
</div>
<p><br/></p>
<!-- 위로가기 버튼 -->
<h6 id="topBtn" class="text-end me-3"><img src="${ctp}/images/arrowTop.gif" title="위로이동"/></h6>
</body>
</html>