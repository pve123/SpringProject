<%@page import="org.zerock.domain.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="header.jsp"%>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">게시판</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				게시글 목록
			
					[<a
						href="<c:url value='/board/excelDown'/>">엑셀</a>]
				<button id="regBtn" type="button" class="btn btn-xs pull-right">게시글
					작성하기</button>					
			</div>
			<!-- /.panel-heading -->
			<div class="panel-body">

				<table class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>수정일</th>
						</tr>
					</thead>

					<c:forEach items="${list }" var="board">
						<tr>
							<td>${board.bno }</td>
							<td><a class="move" href="${board.bno }">${board.title }</a></td>
							<td>${board.writer }</td>
							<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
									value="${board.regdate }" /></td>
							<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
									value="${board.updateDate }" /></td>
						</tr>
					</c:forEach>
				</table>
				<!-- 테이블 끝  -->

				<!-- 검색 -->
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm" action="/board/list" method="get">
							<select name="type" style="height: 26px;">
								<option value="">--</option>
								<option value="T">제목</option>
								<option value="C">내용</option>
								<option value="W">작성자</option>
								<option value="TC">제목 or 내용</option>
								<option value="TW">제목 or 작성자</option>
								<option value="TWC">제목 or 내용 or 작성자</option>
							</select> <input type="text" name="keyword"> 
							<input type="hidden"name="pageNum" value="${pageMaker.cri.pageNum }"> 
							<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
							<button class="btn btn-default">검색</button>
						</form>
					</div>
				</div>

				<!-- 검색끝 -->

				<div class="pull-right">
					<ul class="pagination">

						<c:if test="${pageMaker.prev }">
							<li class="paginate_button previous"><a
								href="${pageMaker.startPage-1 }">이전</a></li>
						</c:if>

						<c:forEach var="num" begin="${pageMaker.startPage}"
							end="${pageMaker.endPage }">
							<li class="paginate_button ${pageMaker.cri.pageNum == num ? "active" :"" }"><a
								href="${num }">${num }</a>
						</c:forEach>

						<c:if test="${pageMaker.next }">
							<li class="paginate_button next"><a
								href="${pageMaker.endPage+1 }">다음</a>
						</c:if>

					</ul>
				</div>
			</div>
			
		

			<!-- Modal -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">&times;</button>
							<h4 class="modal-title" id="myModalLabel">게시글 등록 모달창</h4>
						</div>
						<div class="modal-body">처리가 완료되었습니다.</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">Close</button>
							<button type="button" class="btn btn-primary">Save
								changes</button>
						</div>
					</div>
					<!-- /.modal-content -->
				</div>
				<!-- /.modal-dialog -->
			</div>
			<!-- /.modal -->
		</div>
		<!-- /.panel-body -->
	</div>
	<!-- /.panel -->
</div>
<form id="actionForm" action="/board/list" method="get">
	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
	<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
	<input type="hidden" name="type" value="${pageMaker.cri.type }">
	<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
</form>

<!-- /.row -->
<script>
	$(function() {

		var result = '<c:out value="${result}"/>';
		checkModal(result);
		history.replaceState({}, null, null);
		function checkModal(result) {

			if (result === '' || history.state) {
				return;
			}

			if (parseInt(result) > 0) {
				$(".modal-body").html(
						"게시글 " + parseInt(result) + "번 이 등록되었습니다.");
			}

			$("#myModal").modal("show");
		}

		$("#regBtn").click(function() {

			self.location = "/board/register";
		});

		var actionForm = $("#actionForm");

		$(".paginate_button a").on("click", function(e) {
			e.preventDefault();
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});
		
		$(".move").on("click",function(e){
			
			console.log("123");
			e.preventDefault();
			actionForm.append("<input type='hidden' name='bno' value='"+
					$(this).attr("href")+"'>");
			actionForm.attr("action","/board/get");
			actionForm.submit();
			
			
		});
		
		var searchForm =$("#searchForm");
		 $("input[name='keyword']").click(function(e){
			if (!searchForm.find("option:selected").val()) {
				alert("검색종류를 선택하세요");
				$("input[name='keyword']").val("");
				return false;
			}
			if (!searchForm.find("input[name='keyword']").val()) {
				alert("키워드를 입력하세요");
				return false;
			}
			searchForm.find("input[name='pageNum']").val("1");
			e.preventDefault();
			searchForm.submit();
		});


	});
</script>
<%@include file="footer.jsp"%>
