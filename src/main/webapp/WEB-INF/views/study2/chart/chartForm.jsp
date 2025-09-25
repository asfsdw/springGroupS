<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <title>chartForm.jsp</title>
  <script>
    'use script';
    
    function chartChange() {
    	let part = document.getElementById("part").value;
    	
    	let str = "";
    	if(part == "pie2") {
    		str += '<form name="chartForm1" method="post" action="googleChart1">';
    		str += '<table class="table table-bordered text-center">';
    		str += '<tr>';
    		str += '<th class="bg-secondary">차트제목</th><td colspan="3" class="bg-secondary"><input type="text" name="title" size="30" class="form-control"/></td>';
    		str += '</tr>';
    		str += '<tr>';
    		str += '<th class="bg-light">범례1</th><td><input type="text" name="subTitle1" class="form-control"/></td>';
    		str += '<th>값1</th><td><input type="number" name="value1" class="form-control"/></td>';
    		str += '</tr>';
    		str += '<tr>';
    		str += '<th class="bg-light">범례2</th><td><input type="text" name="subTitle2" class="form-control"/></td>';
    		str += '<th class="bg-light">값2</th><td><input type="number" name="value2" class="form-control"/></td>';
    		str += '</tr>';
    		str += '<tr>';
    		str += '<th class="bg-light">범례3</th><td><input type="text" name="subTitle3" class="form-control"/></td>';
    		str += '<th class="bg-light">값3</th><td><input type="number" name="value3"  class="form-control"/></td>';
    		str += '</tr>';
    		str += '<tr>';
    		str += '<th class="bg-light">범례4</th><td><input type="text" name="subTitle4" class="form-control"/></td>';
    		str += '<th class="bg-light">값4</th><td><input type="number" name="value4" class="form-control"/></td>';
    		str += '</tr>';
    		str += '<tr>';
    		str += '<th class="bg-light">범례5</th><td><input type="text" name="subTitle5" class="form-control"/></td>';
    		str += '<th class="bg-light">값5</th><td><input type="number" name="value5" class="form-control"/></td>';
    		str += '</tr>';
    		str += '<tr>';
    		str += '<td colspan="4"><input type="button" value="차트그리기" onclick="chartShow(\'pie2\')" class="btn btn-primary form-control"/></td>';
    		str += '</tr></table>';
    		str += '<input type="hidden" name="part" id="part">';
    		str += '</form>';
    		$("#demo").html(str);
    	}
    	else if(part == "barV2") {
    		str += '<form name="chartForm1" method="post" action="googleChart1">';
    		str += '<table class="table table-bordered text-center">';
    		str += '<tr><th class="bg-secondary">차트 주제목</th><td colspan="4" class="bg-secondary"><input type="text" name="title" size="30" class="form-control"/></td></tr>';
    		str += '<tr><th class="bg-secondary">차트 부제목</th><td colspan="4" class="bg-secondary"><input type="text" name="subTitle" size="30" class="form-control"/></td></tr>';
    		str += '<tr>';
    		str += '<th colspan="2">범례</th>';
    		str += '<td><input type="text" name="legend1" class="form-control"/></td>';
    		str += '<td><input type="text" name="legend2" class="form-control"/></td>';
    		str += '<td><input type="text" name="legend3" class="form-control"/></td>';
    		str += '</tr>';
    		str += '<tr>';
    		str += '<th>X축1</th><td><input type="text" name="x1" class="form-control"/></td>';
    		str += '<td><input type="number" name="x1Value1" class="form-control"/></td>';
    		str += '<td><input type="number" name="x1Value2" class="form-control"/></td>';
    		str += '<td><input type="number" name="x1Value3" class="form-control"/></td>';
    		str += '</tr>';
    		str += '<tr>';
    		str += '<th>X축2</th><td><input type="text" name="x2" class="form-control"/></td>';
    		str += '<td><input type="number" name="x2Value1" class="form-control"/></td>';
    		str += '<td><input type="number" name="x2Value2" class="form-control"/></td>';
    		str += '<td><input type="number" name="x2Value3" class="form-control"/></td>';
    		str += '</tr>';
    		str += '<tr>';
    		str += '<th>X축3</th><td><input type="text" name="x3" class="form-control"/></td>';
    		str += '<td><input type="number" name="x3Value1" class="form-control"/></td>';
    		str += '<td><input type="number" name="x3Value2" class="form-control"/></td>';
    		str += '<td><input type="number" name="x3Value3" class="form-control"/></td>';
    		str += '</tr>';
    		str += '<tr>';
    		str += '<th>X축4</th><td><input type="text" name="x4" class="form-control"/></td>';
    		str += '<td><input type="number" name="x4Value1" class="form-control"/></td>';
    		str += '<td><input type="number" name="x4Value2" class="form-control"/></td>';
    		str += '<td><input type="number" name="x4Value3" class="form-control"/></td>';
    		str += '</tr>';
    		str += '<tr>';
    		str += '<td colspan="5"><input type="button" value="차트그리기" onclick="chartShow(\'barV2\')" class="btn btn-primary form-control"/></td>';
    		str += '</tr></table>';
    		str += '<input type="hidden" name="part" id="part">';
    		str += '</form>';
    		$("#demo").html(str);
    	}
    	else chartForm.submit();    	
    }
    
    
    function chartShow(part) {
    	if(part == 'barV2') {
    		document.chartForm1.part.value = part;
    		chartForm1.submit();
    	}
    	else if(part == 'pie2') {
    		document.chartForm1.part.value = part;
    		chartForm1.submit();
    	}
		}
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2>구글 차트 연습</h2>
  <div>
    <div>학습할 차트를 선택하세요</div>
    <form name="chartForm">
      <select name="part" id="part" onchange="chartChange()">
        <option value="">차트선택</option>
        <option value="barV"     ${part == 'barV' ? 'selected' : ''}>수직막대차트</option>
        <option value="barH"     ${part == 'barH' ? 'selected' : ''}>수평막대차트</option>
        <option value="line"     ${part == 'line' ? 'selected' : ''}>꺽은선차트</option>
        <option value="pie"      ${part == 'pie' ? 'selected' : ''}>원형차트</option>
        <option value="pie3D"    ${part == 'pie3D' ? 'selected' : ''}>3D원형차트</option>
        <option value="pieDonut" ${part == 'pieDonut' ? 'selected' : ''}>도우넛차트</option>
        <option value="bubble"   ${part == 'bubble' ? 'selected' : ''}>버블차트</option>
        <option value="gant"     ${part == 'gant' ? 'selected' : ''}>간트차트</option>
        <option value="timeline" ${part == 'timeline' ? 'selected' : ''}>TimeLines</option>
        <option value="combo"    ${part == 'combo' ? 'selected' : ''}>콤보차트</option>
	      <option value="barV2" ${part == 'barV2' ? 'selected' : ''}>수직막대차트2</option>
	      <option value="pie2" ${part == 'pie2' ? 'selected' : ''}>원형차트2</option>
      </select>
    </form>
  </div>
  <hr/>
  <div id="demo"></div>
  <hr/>
  <div>
    <c:if test="${part == 'barV'}"><jsp:include page="barVChart.jsp" /></c:if>
    <c:if test="${part == 'barV2'}"><jsp:include page="barVChart2.jsp" /></c:if>
    <c:if test="${part == 'barH'}"><jsp:include page="barHChart.jsp" /></c:if>
    <c:if test="${part == 'line'}"><jsp:include page="lineChart.jsp" /></c:if>
    <c:if test="${part == 'pie'}"><jsp:include page="pieChart.jsp" /></c:if>
    <c:if test="${part == 'pie2'}"><jsp:include page="pieChart2.jsp" /></c:if>
    <c:if test="${part == 'pie3D'}"><jsp:include page="pie3DChart.jsp" /></c:if>
    <c:if test="${part == 'pieDonut'}"><jsp:include page="pieDonutChart.jsp" /></c:if>
    <c:if test="${part == 'bubble'}"><jsp:include page="bubbleChart.jsp" /></c:if>
    <c:if test="${part == 'gant'}"><jsp:include page="gantChart.jsp" /></c:if>
    <c:if test="${part == 'timeline'}"><jsp:include page="timelineChart.jsp" /></c:if>
    <c:if test="${part == 'combo'}"><jsp:include page="comboChart.jsp" /></c:if>
  </div>
</div>
<p><br/></p>
</body>
</html>