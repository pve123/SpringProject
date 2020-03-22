<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="header.jsp"%>
<script type="text/javascript" src="/resources/js/reply.js"></script>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Read Page</h1>
	</div>
</div>
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Board Read</div>
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
					<input type="hidden" name='pageNum' value="${cri.pageNum }">
					<input type="hidden" name='amount' value="${cri.amount }">
					<input type="hidden" name="type" value="${cri.type }"> <input
						type="hidden" name="keyword" value="${cri.keyword }">
				</form>

			</div>
		</div>
	</div>
</div>

<!--  댓글 -->
<div class='row'>
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i>Reply
			</div>
			<div class="panel-body">
				<ul class="chat">
					<li class="left clearfix" data-rno='12'>
						<div>
							<div class="header">
								<strong class="primary-font">user00</strong> 
								<small class="pull-right text-muted">2020-03-22 13:13</small>
							</div>
							<p>Good job!</p>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</div>
</div>
<!-- END 댓글 -->
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
<script>

$(function(){

	var bnoValue = '${board.bno}';
	var replyUL = $(".chat");
	showList(1);

	function showList(page){
		replyService.getList({
			bno : bnoValue,
			page : page || 1
		}, function(data) {
			var str= "";

			for (var i = 0, len = data.length || 0; i < len; i++) {
				str +="<li class='left clearfix' data-rno='"+data[i].rno+"'>";
				str +=" <div><div class='header'><strong class='primary- font'>"+data[i].replyer+"</strong>"; 
				str +=" <small class='pull-right text-muted'>" + replyService.displayTime(data[i].replydate)+ "</small></div>";
				str +=" <p> " + data[i].reply + "</p></div></li>";
			}
			replyUL.html(str);		
		}); //목록	
	}//End ShowList	



// 	replyService.add({
// 		reply : "asdasd123",
// 		replyer : "tester1",
// 		bno : bnoValue
// 	}, function(result) {
// 		alert("RESULT : " + result);
// 	}); //등록

// 	replyService.remove(31, function(result) {
// 		console.log(result);
// 		if(result === 'success'){
// 			alert('REMOVED');
// 		}
// 	},function(err){
// 		alert('ERROR');
// 	}); //삭제
	
// 	replyService.update({rno : 32, bno : bnoValue, reply : "Modify ajax reply"},
// 	function(result){
// 		alert("수정완료");
// 	}) //수정
	
// 	replyService.get(14, function(result){
// 		console.log(result);
// 	}); //조회
	
	
	
}); //end final function

	
</script>


<%@include file="footer.jsp"%>