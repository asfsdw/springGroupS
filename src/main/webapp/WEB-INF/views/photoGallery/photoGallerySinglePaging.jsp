<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
	  <c:forEach var="vo" items="${vos}" varStatus="st">
	    <div class="card mb-5" style="width:95%;">
		    <c:set var="content" value="${fn:replace(vo.content,'.png\"','.png\" width=100%')}"/>
		    <b>번호:${vo.idx} / 분야:${vo.part} / 제목:${vo.title} / 사진수량:${vo.photoCount}</b><br/>
		    ${fn:replace(content,'.jpg\"','.jpg\" width=100%')}<hr/>
		  </div>
	  </c:forEach>