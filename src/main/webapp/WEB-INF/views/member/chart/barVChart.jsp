<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>barVChart.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  <script type="text/javascript">
    google.charts.load('current', {'packages':['bar']});
    google.charts.setOnLoadCallback(drawChart);
    function drawChart() {
    	let str = [];
    	let nickNames = "${nickName}".split("/");
    	let visitCnts = "${visitCnt}".split("/");
    	let points = "${point}".split("/");
    	
    	for(let i=0; i<nickNames.length; i++) {
    		str.push([nickNames[i],Number(visitCnts[i]),Number(points[i])]);
    	}
    	
      var data = google.visualization.arrayToDataTable([
        ["닉네임", "총 방문일", "보유 포인트"],
        // 전개 연산자.
        ...str
      ]);

      var options = {
        chart: {"title" : "최다방문자(1개월)"}
      };

      var chart = new google.charts.Bar(document.getElementById('columnchart_material'));

      chart.draw(data, google.charts.Bar.convertOptions(options));
    }
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <div id="columnchart_material" style="width: 800px; height: 500px;"></div>
</div>
<p><br/></p>
</body>
</html>