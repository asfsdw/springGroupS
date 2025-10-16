<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
	  <c:forEach var="vo" items="${vos}" varStatus="st">
	    <div class="card mb-5" style="width:220px;">
		    <div class="card-body m-0 p-2 text-center">
		      <a href="photoGalleryContent?idx=${vo.idx}">
		        <img src="${ctp}/photoGallery/${vo.thumbnail}" width="200px" height="150px" title="${vo.title}" class="m-0" />
		      </a>
		    </div> 
		    <div class="card-footer">
		      <div class="row text-center" style="font-size:11px">
		        <div class="col p-0"><i class="fa-regular fa-pen-to-square" title="댓글수"></i> ${vo.replyCnt}</div>
		        <div class="col p-0"><i class="fa-regular fa-face-grin-hearts" title="좋아요"></i> ${vo.goodCount}</div>
		        <div class="col p-0"><i class="fa-regular fa-eye" title="조회수"></i> ${vo.readNum}</div>
		        <div class="col p-0"><i class="fa-solid fa-layer-group" title="사진수"></i> ${vo.photoCount}</div>
		      </div>
		    </div>
		  </div>
	  </c:forEach>