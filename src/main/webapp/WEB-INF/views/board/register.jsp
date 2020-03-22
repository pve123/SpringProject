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
				<form role="form" action="/board/register" method="post">
					<div class="form-group">
						<label>제목</label> <input class="form-control" name="title"
							required="required">
					</div>
					<div class="form-group">
						<label>내용</label>
						<textarea class="form-control" rows="10" name="content"
							required="required"></textarea>
					</div>
					<div class="form-group">
						<label>작성자</label> <input class="form-control" name="writer"
							required="required">
					</div>
					<button type="submit" class="btn btn-default">작성</button>
					<button type="reset" class="btn btn-default">초기화</button>
				</form>
			</div>
		</div>
	</div>
</div>

<%@include file="footer.jsp"%>