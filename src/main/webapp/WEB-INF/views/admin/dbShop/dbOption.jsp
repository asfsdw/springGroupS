<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>dbOption.jsp(상품의 옵션 등록)</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
  <script>
  	'use strict';
    let cnt = 1;
    
    // 옵션항목 추가
    function addOption() {
    	let strOption = "";
    	let test = "t" + cnt; 
    	
    	strOption += '<div id="'+test+'"><hr class="border-1 border-dark">';
    	strOption += '<font size="4"><b class="mb-2">상품옵션등록</b></font>&nbsp;&nbsp;';
    	strOption += '<div class="input-group mb-2">';
    	strOption += '<div class="input-group-text">상품옵션이름</div>';
    	strOption += '<input type="text" name="optionName" id="optionName'+cnt+'" class="form-control"/>';
    	strOption += '<input type="button" value="옵션삭제" class="btn btn-outline-danger btn-sm" onclick="removeOption('+test+')"/>'
    	strOption += '</div>';
    	strOption += '<div class="input-group mb-2">';
    	strOption += '<div class="input-group-text">상품옵션가격</div>';
    	strOption += '<input type="text" name="optionPrice" id="optionPrice'+cnt+'" class="form-control"/>';
    	strOption += '</div>';
    	strOption += '</div>';
    	$("#optionType").append(strOption);
    	cnt++;
    }
    
    // 옵션항목 삭제
    function removeOption(test) {
    	/* $("#"+test).remove(); */
    	$("#"+test.id).remove();
    }
    
    // 옵션 입력후 등록전송
    function fCheck() {
    	for(let i=1; i<=cnt; i++) {
    		if($("#t"+i).length != 0 && document.getElementById("optionName"+i).value=="") {
    			alert("빈칸 없이 상품 옵션명을 모두 등록하셔야 합니다");
    			return false;
    		}
    		else if($("#t"+i).length != 0 && document.getElementById("optionPrice"+i).value=="") {
    			alert("빈칸 없이 상품 옵션가격을 모두 등록하셔야 합니다");
    			return false;
    		}
    	}
    	if(document.getElementById("optionName").value=="") {
    		alert("상품 옵션이름을 등록하세요");
    		return false;
    	}
    	else if(document.getElementById("optionPrice").value=="") {
    		alert("상품 옵션가격을 등록하세요");
    		return false;
    	}
    	else if(document.getElementById("productName").value=="") {
    		alert("상품명을 선택하세요");
    		return false;
    	}
    	else {
    		myform.submit();
    	}
    }
    
    // 상품 입력창에서 대분류 선택(Change)시 중분류가져와서 중분류 선택박스에 뿌리기
    function categoryMainChange() {
    	var categoryMainCode = myform.categoryMainCode.value;
			$.ajax({
				type : "post",
				url  : "${ctp}/dbShop/categoryMiddleName",
				data : {categoryMainCode : categoryMainCode},
				success:function(data) {
					var str = "";
					str += "<option value=''>중분류</option>";
					for(var i=0; i<data.length; i++) {
						str += "<option value='"+data[i].categoryMiddleCode+"'>"+data[i].categoryMiddleName+"</option>";
					}
					$("#categoryMiddleCode").html(str);
				},
				error : function() {
					alert("전송오류!");
				}
			});
  	}
    
    // 상품 입력창에서 중분류 선택(Change)시 소분류가져와서 소분류 선택박스에 뿌리기
    function categoryMiddleChange() {
    	var categoryMainCode = myform.categoryMainCode.value;
    	var categoryMiddleCode = myform.categoryMiddleCode.value;
			$.ajax({
				type : "post",
				url  : "${ctp}/dbShop/categorySubName",
				data : {
					categoryMainCode : categoryMainCode,
					categoryMiddleCode : categoryMiddleCode
				},
				success:function(data) {
					var str = "";
					str += "<option value=''>소분류</option>";
					for(var i=0; i<data.length; i++) {
						str += "<option value='"+data[i].categorySubCode+"'>"+data[i].categorySubName+"</option>";
					}
					$("#categorySubCode").html(str);
				},
				error : function() {
					alert("전송오류!");
				}
			});
  	}    
    
    // 상품 입력창에서 소분류 선택(Change)시 해당 상품들을 가져와서 품목 선택박스에 뿌리기
    function categorySubChange() {
    	var categoryMainCode = myform.categoryMainCode.value;
    	var categoryMiddleCode = myform.categoryMiddleCode.value;
    	var categorySubCode = myform.categorySubCode.value;
			$.ajax({
				type : "post",
				url  : "${ctp}/dbShop/categoryProductName",
				data : {
					categoryMainCode : categoryMainCode,
					categoryMiddleCode : categoryMiddleCode,
					categorySubCode : categorySubCode
				},
				success:function(data) {
					var str = "";
					str += "<option value=''>상품선택</option>";
					for(var i=0; i<data.length; i++) {
						str += "<option value='"+data[i].productName+"'>"+data[i].productName+"</option>";
					}
					$("#productName").html(str);
				},
				error : function() {
					alert("전송오류!");
				}
			});
  	}
    
    // 상품리스트 상세보기에서 옵션등록 버튼클릭시 수행하는 부분....
    <c:if test="${!empty productVO}">productNameCheck('${productVO.productName}')</c:if>
    
    // 상품명을 선택하면 상품의 설명을 띄워준다.
    function productNameCheck(productName) {
    	if(productName == "") productName = document.getElementById("productName").value;
    	
    	$.ajax({
    		type:"post",
    		url : "${ctp}/dbShop/getProductInfor",
    		data: {productName : productName},
    		success:function(vo) {
    			let str = '<hr/>';
    			str += '<table class="table table-bordered">';
    			str += '<tr><th>대분류명</th><td>'+vo.categoryMainName+'</td>';
    			str += '<td rowspan="6" class="text-center"><img src="${ctp}/product/'+vo.fsname+'" width="160px"/></td></tr>';
    			str += '<tr><th>중분류명</th><td>'+vo.categoryMiddleName+'</td></tr>';
    			str += '<tr><th>소분류명</th><td>'+vo.categorySubName+'</td></tr>';
    			str += '<tr><th>상 품 명</th><td>'+vo.productName+'</td></tr>';
    			str += '<tr><th>상품제목</th><td>'+vo.detail+'</td></tr>';
    			str += '<tr><th>상품가격</th><td>'+numberWithCommas(vo.mainPrice)+'원</td></tr>';
    			str += '<tr><td colspan="3" class="text-center"><input type="button" value="등록된옵션보기(삭제)" onclick="optoinShow('+vo.idx+')" class="btn btn-info btn-sm"/></td></tr>';
    			str += '</table>';
    			str += '<hr/>';
    			str += '<div id="optionDemo"></div>';
    			$("#demo").html(str);
    			document.myform.productIdx.value = vo.idx;
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
    // 옵션상세내역보기
    function optoinShow(productIdx) {
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/dbShop/getOptionList",
    		data : {productIdx : productIdx},
    		success:function(vos) {
    			let str = '';
    			if(vos.length != 0) {
						str = "옵션 : / ";
	    			for(let i=0; i<vos.length; i++) {
	    				str += '<a href="javascript:optionDelete('+vos[i].idx+')">';
							str += vos[i].optionName + "</a> / ";
	    			}
    			}
    			else {
    				str = "<div class='text-center'><font color='red'>현 상품에 등록된 옵션이 없습니다.</font></div>";
    			}
					$("#optionDemo").html(str);
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
    // 옵션항목 삭제하기
    function optionDelete(idx) {
    	let ans = confirm("현재 선택한 옵션을 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/dbShop/optionDelete",
    		data : {idx : idx},
    		success:function() {
    			alert("삭제되었습니다.");
    			location.reload();
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
    // 콤마찍기
    function numberWithCommas(x) {
		  return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
  </script>
  <style>
    th {
      text-align: center;
      background-color: #eee !important;
    }
    a {
      color: #00f;
      text-decoration: none;
    }
  </style>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2>상품에 따른 옵션 등록</h2>
  <form name="myform" method="post">
    <div class="input-group mb-2">
      <label for="categoryMainCode" class="input-group-text">대분류</label>
      <select id="categoryMainCode" name="categoryMainCode" class="form-select" onchange="categoryMainChange()">
        <option value="">대분류를 선택하세요</option>
        <c:forEach var="mainVo" items="${mainVos}">
        	<option value="${mainVo.categoryMainCode}">${mainVo.categoryMainName}</option>
        </c:forEach>
        <c:if test="${!empty productVO}"><option value="${productVO.categoryMainCode}" selected>${productVO.categoryMainName}</option></c:if>
      </select>
    </div>
    <div class="input-group mb-2">
      <label for="categoryMiddleCode" class="input-group-text">중분류</label>
      <select id="categoryMiddleCode" name="categoryMiddleCode" class="form-select" onchange="categoryMiddleChange()">
        <option value="">중분류명</option>
        <c:if test="${!empty productVO}"><option value="${productVO.categoryMiddleCode}" selected>${productVO.categoryMiddleName}</option></c:if>
      </select>
    </div>
    <div class="input-group mb-2">
      <label for="categorySubCode" class="input-group-text">소분류</label>
      <select id="categorySubCode" name="categorySubCode" class="form-select" onchange="categorySubChange()">
        <option value="">소분류명</option>
        <c:if test="${!empty productVO}"><option value="${productVO.categorySubCode}" selected>${productVO.categorySubName}</option></c:if>
      </select>
    </div>
    <div class="input-group mb-2">
      <label for="productName" class="input-group-text">상품명(모델명)</label>
      <!-- <select name="productName" id="productName" class="form-control" onchange="productNameCheck('')"> -->
      <select name="productCode" id="productName" class="form-select" onchange="productNameCheck('')">
        <option value="">상품선택</option>
        <c:if test="${!empty productVO}"><option value="${productVO.productCode}" selected>${productVO.productName}</option></c:if>
        <%-- <c:if test="${!empty productVO}"><option value="${productVO.productName}" selected>${productVO.productName}</option></c:if> --%>
      </select>
    </div>
    <div id="demo"></div>
    <hr class="border-1 border-dark">
    <div class="mb-2">
	    <font size="4"><b>상품옵션등록</b></font>&nbsp;&nbsp;
	    <input type="button" value="옵션박스추가하기" onclick="addOption()" class="btn btn-secondary btn-sm"/><br/>
    </div>
    <div class="input-group mb-2">
      <label for="optionName" class="input-group-text">상품옵션이름</label>
      <input type="text" name="optionName" id="optionName" class="form-control"/>
    </div>
    <div class="input-group mb-2">
      <label for="optionPrice" class="input-group-text">상품옵션가격</label>
      <input type="text" name="optionPrice" id="optionPrice" class="form-control"/>
    </div>
    <div id="optionType"></div>
    <hr class="border-1 border-dark">
    <div class='text-end'>
      <input type="button" value="옵션등록" onclick="fCheck()" class="btn btn-primary"/>
      <input type="button" value="상품리스트" onclick="location.href='dbShopList'" class="btn btn-warning"/>
    </div>
    <input type="hidden" name="productIdx">
  </form>
</div>
<p><br/></p>
</body>
</html>