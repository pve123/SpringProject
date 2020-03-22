<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="header.jsp"%>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Register</h1>
	</div>
</div>
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Board Register</div>
			<div class="panel-body">

				<div class="form-group">
					<label>글 번호</label> <input class="form-control" name="bno"
						readonly="readonly" value="${board.bno}">
				</div>
				<div class="form-group">
					<label>제목</label> <input class="form-control" name="title"
						readonly="readonly" value="${board.title}">
				</div>
				<div class="form-group">
					<label>내용</label>
					<textarea class="form-control" rows="10" name="content"
						readonly="readonly">${board.content}</textarea>
				</div>
				<div class="form-group">
					<label>작성자</label> <input class="form-control" name="writer"
						readonly="readonly" value="${board.writer}">
				</div>
				<button data-oper="modify" class="btn btn-default">수정</button>
				<button data-oper="list" class="btn btn-default">목록</button>

				<form id="operForm" action="/board/modify" method="get">
					<input type="hidden" id='bno' name='bno' value="${board.bno }">
					<input type="hidden" name='pageNum'value="${cri.pageNum }"> 
					<input type="hidden" name='amount' value="${cri.amount }">
					<input type="hidden" name="type" value="${cri.type }">
					<input type="hidden" name="keyword" value="${cri.keyword }">
				</form>

			</div>
		</div>
	</div>
</div>
<script>
	$(function() {

		var operForm = $("#operForm");

		$("button[data-oper='modify']").on("click", function() {
			operForm.attr("action", "/board/modify").submit();
		});

		$("button[data-oper='list']").on("click", function() {
			operForm.find("#bno").remove();
			operForm.attr("action", "/board/list")
			operForm.submit();
		});

	});
</script>
<%@include file="footer.jsp"%>