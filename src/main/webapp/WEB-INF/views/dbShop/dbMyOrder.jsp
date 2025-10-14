<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
  <meta charset="UTF-8">
  <title>dbMyOrder.jsp(회원 주문확인)</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
  <script>
    'use strict';
    
    // 배송지 정보보기
    function nWin(orderIdx) {
    	var url = "${ctp}/dbShop/dbOrderBaesong?orderIdx="+orderIdx;
    	window.open(url,"dbOrderBaesong","width=400px,height=450px");
    }
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2 class="text-center">주문/배송 확인</h2>
  <table class="table table-borderless m-0">
    <tr>
      <td>
        날짜기간 및 조건검색 : (날짜로도, 주문상태로도 조회가능하게 처리할것)
      </td>
      <td class="text-end">
	      <a href="${ctp}/dbShop/dbCartList" class="btn btn-success btn-sm">장바구니조회</a>
	      <a href="${ctp}/dbShop/dbProductList" class="btn btn-primary btn-sm">계속쇼핑하기</a>
      </td>
    </tr>
  </table>
  <table class="table table-hover">
    <tr class="table-secondary text-center">
      <th>주문정보</th>
      <th>상품</th>
      <th>주문내역</th>
      <th>주문일시</th>
    </tr>
    <c:if test="${productVos.length == 0}">
	    <tr>
	    	<td colspan="4" class="text-center">구매하신 상품이 없습니다.</td>
	    </tr>
    </c:if>
    <c:set var="sw" value="0"/>
    <c:set var="tempOrderIdx" value="0"/>
    <c:forEach var="vo" items="${vos}" varStatus="st">
    	<!-- 같은 주문상품은 한번에 총 금액을 출력처리한다. -->
      <c:if test="${tempOrderIdx != vo.orderIdx}">
        <c:if test="${sw != 0}">
		      <tr class="bg-light">
		        <td colspan="4" class="p-0">
		          <div class="text-center m-3">주문번호 : ${tempOrderIdx} / 총 구입금액 : <b><fmt:formatNumber value="${tempOrderTotalPrice}" /></b> 원</div>
		          <hr class="border-1 border-dark">
		        </td>
		      </tr>
	      </c:if>
        <c:set var="tempOrderIdx" value="${vo.orderIdx}" />
        <c:set var="tempOrderTotalPrice" value="${vo.orderTotalPrice}" />
	      <c:set var="sw" value="1"/>
      </c:if>
      
      <tr class="text-center align-middle">
        <td>
          <p>주문번호 : ${vo.orderIdx}</p>
          <p><b>총 주문액 : <font color="blue"><fmt:formatNumber value="${vo.totalPrice}"/>원</font></b></p>
          <p><input type="button" value="배송지정보" onclick="nWin('${vo.orderIdx}')"></p>
        </td>
        <td><br/><img src="${ctp}/data/dbShop/product/${vo.thumbImg}" class="thumb" width="100px"/></td>
        <td class="text-start">
	        <p><br/>모델명 : <span style="color:orange;font-weight:bold;">${vo.productName}</span><br/> &nbsp; &nbsp; <fmt:formatNumber value="${vo.mainPrice}"/>원</p><br/>
	        <c:set var="optionNames" value="${fn:split(vo.optionName,',')}"/>
	        <c:set var="optionPrices" value="${fn:split(vo.optionPrice,',')}"/>
	        <c:set var="optionNums" value="${fn:split(vo.optionNum,',')}"/>
	        <p>
	          - 주문 내역
	          <c:if test="${fn:length(optionNames) > 1}">(옵션 ${fn:length(optionNames)-1}개 포함)</c:if><br/>
	          <c:forEach var="i" begin="1" end="${fn:length(optionNames)}">
	            &nbsp; &nbsp; ㆍ ${optionNames[i-1]} / <fmt:formatNumber value="${optionPrices[i-1]}"/>원 / ${optionNums[i-1]}개<br/>
	          </c:forEach>
	        </p>
	      </td>
        <td style="text-align:center;">
          주문일자 : ${fn:substring(vo.orderDate,0,10)}<br/><br/>
          <font color="brown">${vo.orderStatus}</font><br/>
          <c:if test="${vo.orderStatus eq '결제완료'}">(배송준비중)</c:if>
        </td>
      </tr>
      
      <c:if test="${st.last}">
        <c:set var="lastOrderTotalPrice" value="${vo.orderTotalPrice}"/>
        <c:set var="lastOrderIdx" value="${vo.orderIdx}"/>
      </c:if>
    </c:forEach>
    
    <tr class="bg-light">
      <td colspan="4" class="p-0">
        <div class="text-center m-3">주문번호 : ${lastOrderIdx} / 총 구입금액 : <b><fmt:formatNumber value="${lastOrderTotalPrice}" /></b> 원</div>
      </td>
    </tr>
    <tr><td colspan="4" class="p-0"></td></tr>
  </table>
  <!-- 블록 페이징처리 시작 -->
	<div class="container">
		<ul class="pagination justify-content-center">
			<c:if test="${pageVO.totPage == 0}"><p style="text-align:center"><b>자료가 없습니다.</b></p></c:if>
			<c:if test="${pageVO.totPage != 0}">
			  <c:if test="${pageVO.pag != 1}">
			    <li class="page-item"><a href="${ctp}/dbShop/dbMyOrder?pag=1" title="첫페이지" class="page-link text-secondary">◁◁</a></li>
			  </c:if>
			  <c:if test="${pageVO.curBlock > 0}">
			    <li class="page-item"><a href="${ctp}/dbShop/dbMyOrder?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}" title="이전블록" class="page-link text-secondary">◀</a></li>
			  </c:if>
			  <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}">
			    <c:if test="${i == pageVO.pag && i <= pageVO.totPage}">
			      <li class="page-item active"><a href='${ctp}/dbShop/dbMyOrder?pag=${i}' class="page-link text-light bg-secondary border-secondary">${i}</a></li>
			    </c:if>
			    <c:if test="${i != pageVO.pag && i <= pageVO.totPage}">
			      <li class="page-item"><a href='${ctp}/dbShop/dbMyOrder?pag=${i}' class="page-link text-secondary">${i}</a></li>
			    </c:if>
			  </c:forEach>
			  <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
			    <li class="page-item"><a href="${ctp}/dbShop/dbMyOrder?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}" title="다음블록" class="page-link text-secondary">▶</a>
			  </c:if>
			  <c:if test="${pageVO.pag != pageVO.totPage}">
			    <li class="page-item"><a href="${ctp}/dbShop/dbMyOrder?pag=${pageVO.totPage}" title="마지막페이지" class="page-link" style="color:#555">▷▷</a>
			  </c:if>
			</c:if>
		</ul>
	</div>
	<!-- 블록 페이징처리 끝 -->
<p><br/></p>
</div>
</body>
</html>