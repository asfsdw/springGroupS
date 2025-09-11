<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <title>admin.jsp</title>
</head>
<body>
<p><br/></p>
<div class="container">
  <form name="myform" method="post" action="Login">
    <table class="table table-bordered text-center">
      <tr>
        <td colspan="2" class="bg-secondary-subtle"><font size="5">관리자 인증창</font></td>
      </tr>
      <tr>
        <th class="align-middle">관리자 아이디</th>
        <td><input type="text" name="mid" value="admin" autofocus required class="form-control"/></td>
      </tr>
      <tr>
        <th class="align-middle">비밀번호</th>
        <td><input type="password" name="pwd" value="1234" required class="form-control"/></td>
      </tr>
      <tr>
        <td colspan="2">
          <div class="mb-2">
	          <input type="submit" value="로그인" class="btn btn-success me-2"/>
	          <input type="reset" value="다시입력" class="btn btn-danger me-2"/>
	          <input type="button" value="돌아가기" onclick="location.href='GuestList'" class="btn btn-warning me-2"/>
          </div>
        </td>
      </tr>
    </table>
  </form>
</div>
<p><br/></p>
</body>
</html>