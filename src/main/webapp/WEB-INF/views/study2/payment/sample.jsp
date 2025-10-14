<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>sample.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
  <script>
    IMP.init("imp68516704");

    IMP.request_pay(
      {
        pg: "html5_inicis.INIpayTest",
        pay_method: "card",
        merchant_uid: "springGroupS12_" + new Date().getTime(),
        name : "${vo.name}",
        amount : "${vo.amount}",
        buyer_email: "${vo.buyer_email}",
        buyer_name: "${vo.buyer_name}",
        buyer_tel: "${vo.buyer_tel}",
        buyer_addr: "${vo.buyer_addr}",
        buyer_postcode: "${vo.buyer_postcode}",
      },
      (res) => {
        if(res.success) {
      	  alert("결재가 완료 되었습니다.");
      	  location.href = '${ctp}/study2/payment/paymentOk';
        } else {
      	  alert("결재가 취소 되었습니다.");
      	  location.href = '${ctp}/study2/payment/payment';
        }
      }
    );
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <h3>현재 결제가 진행중입니다.</h3>
  <hr class="border-1 border-dark">
  <p><img src="${ctp}/images/payment.gif"/></p>
  <hr class="border-1 border-dark">
</div>
<p><br/></p>
</body>
</html>