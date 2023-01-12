<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<c:url value="/report/montlyReport" var="montlyReportLink" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>레포트</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<!-- datepicker 는 jquery 1.7.1 이상 bootstrap 2.0.4 이상 버전이 필요함 -->
<!-- jQuery가 먼저 로드 된 후 datepicker가 로드 되어야함.-->
<link rel="stylesheet" href="resources/css/plugin/datepicker/bootstrap-datepicker.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="resources/js/plugin/datepicker/bootstrap-datepicker.js"></script>
<!--한국어 달력 쓰려면 추가 로드-->
<script src="resources/js/plugin/datepicker/bootstrap-datepicker.ko.min.js"></script>
<!-- 구글 열차트 -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
// Load Charts and the corechart and barchart packages.
google.charts.load('current', {'packages':['corechart']});

// Draw the line chart and bar chart when Charts is loaded.
google.charts.setOnLoadCallback(drawChart);

function drawChart() {

  var data = new google.visualization.DataTable();
  data.addColumn('string', '월');
  data.addColumn('number', '매출');
  <c:forEach items="${thisYearSales}" var="sales">
	  data.addRows([
	    [${sales.month }+'월', ${sales.thisSales}]
	  <c:if test="${not empty thisYearSales.size() }">
		,
	</c:if>
		]);
  </c:forEach>
  var linechart_options = {title:'올 해 매출 현황'};
  var linechart = new google.visualization.LineChart(document.getElementById('columnchart_material1'));
  linechart.draw(data, linechart_options);

  var barchart_options = {title:'올 해 별 매출 현황',
                 legend: 'none'};
  var barchart = new google.visualization.BarChart(document.getElementById('columnchart_material2'));
  barchart.draw(data, barchart_options);
}

</script>

<style type="text/css">
	.filterText {
		text-align: center;
		
	}
	.leftFilterDiv {
		border-right-style: groove;
	}
	
#searchBox {
/*  background-color: #f4eed9cb; */
}
	
div.mainBoard {

	margin-top: 20px;
	margin-bottom: 10px;
	width: 100%;
	height: 1000px;
	
}

div.left {
	
	width: 50%;
	height: 500px;
	float: left;
	box-sizing: border-box;
	
/* 	overflow: scroll; */
}
div.right {

	width: 50%;
	height: 500px;
	float: right;
	box-sizing: border-box;
	
/* 	overflow: scroll; */
}

.tableContainer {

}

 	.primaryBtn {
		background-color: white !important;
		border-color: #1d5c83 !important;
		color: #1d5c83 !important;
 	}
 	
 	.primaryBtn:hover {
 		background-color: #1d5c83 !important;
 		color: white !important;
 	}
 	
 	.table{border-collapse:collapse; width:100%; table-layout:fixed}
	.table thead{float:left; width:1300px;}
	.table thead th{display:auto; width:1300px; text-align: left;}
	.table tbody{overflow-y:auto; overflow-x:hidden; float:left; width:1300px; height:550px;}
	.table tbody tr{display:table; width:1300px;}
	.table td{word-wrap:break-word; width:1300px; height: auto;}

</style>


</head>
<body>
<my:side_bar active=""></my:side_bar>
<div class="container-sm mt-4" style="width: 77vw; margin-left: 20%;">
	<div class="row d-flex" id ="searchBox">
		
		<!-- *좌측* 검색 조건 설명란 -->
		<div class="col-sm-2 leftFilterDiv mt-2">
			<div class="mb-5">
				<p class="filterText ">전체 검색</p>
			</div>
			<div class="mb-5">
				<p class="filterText ">조건 선택</p><!-- ( 각자 페이지에 따라 조건을 수정하세요! ex.바이어코드 / 바이어명 등등... ) -->
			</div>
			<div class="mb-5">
				<p class="filterText ">기간 선택</p><!-- ( 각자 페이지에 따라 조건을 수정하세요! ex. 주문일 / 납기일 등등... ) -->
			</div>
		</div><!-- 좌측 조건 설명 div 끝 -->
		
		<!-- *우측* 검색 필터 -->
		<div class="col-sm-10 mt-1">
			<form action="" method=""><!-- form get? post?  -->		
				<!-- 검색필터 1st row : 전체 검색. -->
				<div class="row d-flex">
					<div class="col-sm-6 mb-4">
						<div class="input-group">
							<!-- Select -->
							<!-- <select name="orderS" id="" class="form-select">
								<option value="selectAll">전체검색</option>
								<option value="selectOrderCode">주문서번호</option>
								<option value="selectBuyerCode">바이어 코드</option>
								<option value="selectWriter">담당자</option>
							</select> -->
							<input name="orderQ" value="" class="form-control" type="Search" placeholder="전체검색" aria-label="Search">
			        		<button class="btn btn-outline-secondary" type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>	
						</div>
					</div>
				</div><!-- 1st row 끝 -->
				<!-- 검색필터 2nd row : 조건 검색 ( 각자 페이지의 따라 변경  ) -->
				<div class="row d-flex">
					<div class="col-sm-3 mb-4">
						<div class="input-group" >
							<input name="productCode" value="${param.productCode}" type="text" id="" class="form-control" list="datalistOptions1" placeholder="제품코드">
							<datalist id="datalistOptions1">
								<c:forEach items="${orderList}" var="condition">
									<option value="${condition.productCode}">${condition.productCode}</option>
								</c:forEach>
							</datalist>
							<button class="btn btn-outline-secondary" type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
						</div>
					</div>
					<div class="col-sm-3">
						<div class="input-group">
							<input name="productName" value="${param.productName}" type="text" id="" class="form-control" list="datalistOptions2" placeholder="제품명">
							<datalist id="datalistOptions2">
								<c:forEach items="${orderList}" var="condition">
									<option value="${condition.productName}">${condition.productName}</option>
								</c:forEach>
							</datalist>
							<button class="btn btn-outline-secondary" type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
						</div>	
					</div>
					<div class="col-sm-3">
						<div class="input-group">
							<input name="productType" value="${param.productType}" type="text" id="" class="form-control" list="datalistOptions3" placeholder="제품타입">
							<datalist id="datalistOptions3">
								<c:forEach items="${orderList}" var="condition">
									<option value="${condition.productType}">${condition.productType}</option>
								</c:forEach>
							</datalist>
							<button class="btn btn-outline-secondary" type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
						</div>
					</div>
					<div class="col-sm-3">
						<div class="input-group">
							<input name="size" value="${param.size}" type="text" class="form-control" list="datalistOptions4" id="exampleDataList4" placeholder="제품규격 Inch">
							<datalist id="datalistOptions4">
								<c:forEach items="${orderList}" var="condition">
									<option value="${condition.size}">${condition.size}</option>
								</c:forEach>
							</datalist>
							<button class="btn btn-outline-secondary" type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
						</div>
					</div>
				</div><!-- 2nd row 끝 -->
				<!-- 검색필터 3rd row : 기간 선택 -->
				<div class="row d-flex">
					<div class="col-sm-2">
						<div class="form-check"  style="margin-top: 10px;">
						    <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault" checked>
							<label class="form-check-label" for="flexCheckDefault">전체기간</label>
						</div>
					</div>
					<div class="col-sm-5">
						<div class="input-group">
							<input name="startDateTime" value="" type="date" id="demo1" class="form-control">
							<span class="input-group-text">~</span>
			        		<input name="endDateTime" value="${nowDate}" type="date" id="endTime" class="form-control">
						</div>
					</div>
					<div class="col-sm-5 d-flex">
						<input type="button" id="" name="Today" class="btn btn-outline-secondary" style="font-size: 12pt" value="오늘">
						<input type="button" id="" name="1Week" class="btn btn-outline-secondary" style="font-size: 12pt" value="1주">
						<input type="button" id="" name="15Day" class="btn btn-outline-secondary" style="font-size: 12pt" value="15일">
						<input type="button" id="" name="1Month" class="btn btn-outline-secondary" style="font-size: 12pt" value="1개월">
						<input type="button" id="" name="3Month" class="btn btn-outline-secondary" style="font-size: 12pt" value="3개월">
						<input type="button" id="" name="6Month" class="btn btn-outline-secondary" style="font-size: 12pt" value="6개월">
						<input type="button" id="" name="1Year" class="btn btn-outline-secondary" style="font-size: 12pt" value="1년">
						
				
						<!--
				   		<button type="button" id="" class="btn btn-outline-secondary" style="font-size: 12pt">오늘</button>		
						<button type="button" id="" class="btn btn-outline-secondary" style="font-size: 12pt">1주 </button>	
						<button type="button" id="" class="btn btn-outline-secondary" style="font-size: 12pt">15일</button>		
						<button type="button" id="" class="btn btn-outline-secondary" style="font-size: 12pt">1개월</button>
						<button type="button" id="" class="btn btn-outline-secondary" style="font-size: 12pt">3개월</button>
						<button type="button" id="" class="btn btn-outline-secondary" style="font-size: 12pt">6개월</button>
						<button type="button" id="" class="btn btn-outline-secondary" style="font-size: 12pt">1년</button> 
						-->	
						
					</div>
				</div><!-- 3rd row 끝 -->
				<div class="row mt-4">
					<div class="col-sm-4"></div>
					<div class="col-sm-4">
						<div style="text-align: justify;">
							<button class="btn btn-outline-primary primaryBtn" type="submit">선택 조건 검색</button>
						</div>
					</div>
				</div>
			</form>	
		</div><!-- 우측 검색 조건 div 끝 -->
	</div><!-- 좌측 + 우측 전체를 감싸는 d-flex 끝-->
	
	
	<hr>
	
	<div class="mainBoard">
		<!-- 그래프 -->
        <div class="left p-2">
        	<div id="columnchart_material1" style="width: 500px; height: 450px; margin-left: 80px;"></div>
        </div>
		<div class="right p-2">
			<div id="columnchart_material2" style="width: 500px; height: 450px; margin-left: 50px;"></div>
		</div>
	</div>
	
	
<div class="tableContainer">

		<h4>주문목록</h4>

		<div style="float: right;">
			<c:set var="ctx" value="${pageContext.request.contextPath}" />
			<a href="${ctx }/report/excelDown?orderQ=${param.orderQ }"
				class="btn btn-primary primaryBtn" type="submit"
				style="margin-bottom: 10px;"> 엑셀 다운로드 </a>
		</div>
		<!-- 리스트 -->
		<table class="table">
			<thead>
				<!-- productCode, productName, productType, weight, size, price, unit, content -->
				<tr>
					<th style="width: 9%;">주문서 ID</th>
					<th>바이어코드</th>
					<th>제품코드</th>
					<th>단가</th>
					<th>수량</th>
					<th>합계</th>
					<th style="width: 9%;">등록일</th>
					<th style="width: 9%;">수정일</th>
					<th style="width: 9%;">납기일</th>
					<th>담당자</th>
					<th>상태</th>
					<th>메세지</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${orderList}" var="order">
					<tr>
						<td style="width: 9%;">${order.orderId}</td>
						<td>${order.buyerCode}</td>
						<td>${order.productCode}</td>
						<td>${order.finalPrice}</td>
						<td>${order.quantity}</td>
						<td>${order.sum}</td>
						<td style="width: 9%;">${order.inserted}</td>
						<td style="width: 9%;">${order.modified}</td>
						<td style="width: 9%;">${order.deliveryDate}</td>
						<td>${order.writer}</td>
						<td>${order.status}</td>
						<td>${order.message}</td>
					</tr>
				</c:forEach>		
			</tbody>
		</table>
		
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>
function myFunction() {

	var str = document.getElementById("demo").value; 

	document.getElementById("demo1").value = str;

	}
</script>
	
</body>
</html>