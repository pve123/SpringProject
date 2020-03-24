<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="header.jsp"%>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">게시글 수정 페이지</h1>
	</div>
</div>
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">게시글 수정</div>
			<div class="panel-body">
				<form role="form" action="/board/modify" method="post">

					<div class="form-group">
						<label>글 번호</label> <input class="form-control" name="bno"
							readonly="readonly" value="${board.bno}">
					</div>
					<div class="form-group">
						<label>제목</label> <input class="form-control" name="title"
							value="${board.title}">
					</div>
					<div class="form-group">
						<label>내용</label>
						<textarea class="form-control" rows="10" name="content">${board.content}</textarea>
					</div>
					<div class="form-group">
						<label>작성자</label> <input class="form-control" name="writer"
							readonly="readonly" value="${board.writer}">
					</div>
					<div class="form-group">
						<input type="hidden" class="form-control" name="regdate"
							readonly="readonly"
							value="<fmt:formatDate pattern='yyyy/MM/dd' value='${board.regdate }'/>">
					</div>
					<div class="form-group">
						<input type="hidden" class="form-control" name="updateDate"
							readonly="readonly"
							value="<fmt:formatDate pattern='yyyy/MM/dd ' value='${board.updateDate }'/>">

					</div>


					<input type="hidden" name='pageNum' value="${cri.pageNum }">
					<input type="hidden" name='amount' value="${cri.amount }">
					<input type="hidden" name="type" value="${cri.type }">
					<input type="hidden" name="keyword" value="${cri.keyword }">
					<button type="submit" data-oper="modify" class="btn btn-default">수정</button>
					<button type="submit" data-oper="remove" class="btn btn-danger">삭제</button>
					<button type="submit" data-oper="list" class="btn btn-info">목록</button>
				</form>

			</div>
		</div>
	</div>
</div>
<script>
	$(function() {

		var formObj = $("form");
	
		$("button").click("click", function(e) {

			e.preventDefault();
			var oper = $(this).data("oper");

			if (oper === 'remove') {
				formObj.attr("action", "/board/remove");
			} else if (oper === 'list') {
				
				formObj.attr("action", "/board/list?pageNum=${cri.pageNum }").attr("method", "get");
				var pageNum = $("input[name='pageNum']").clone();
				var amount = $("input[name='amount']").clone();
				var type = $("input[name='type']").clone();
				var keyword = $("input[name='keyword']").clone();
				formObj.empty();
				
				formObj.append(pageNum);
				formObj.append(amount);
				formObj.append(type);
				formObj.append(keyword);
			}

			formObj.submit();
		});

	});
</script>

<%@include file="footer.jsp"%>