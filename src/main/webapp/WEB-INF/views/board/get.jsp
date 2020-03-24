<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="header.jsp"%>
<script type="text/javascript" src="/resources/js/reply.js"></script>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">게시글 조회 페이지</h1>
	</div>
</div>
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">조회</div>
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
				<i class="fa fa-comments fa-fw"></i>댓글
				<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>댓글작성</button>
			</div>
			<div class="panel-body">
				<ul class="chat">
					<li class="left clearfix" data-rno='1'>
						<div>
							<div class="header">
								<strong class="primary-font"></strong> 
								<small class="pull-right text-muted"></small>
							</div>
							<p></p>
						</div>
					</li>
				</ul>
			</div>
			<div class="panel-footer">
			</div>
		</div>
	</div>
</div>
<!-- END 댓글 -->

<!-- 댓글Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" 
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">댓글 창</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>댓글</label> <input class="form-control" name="reply"
						value="New Reply!!!">
				</div>
				<div class="form-group">
					<label>작성자</label> <input class="form-control" name="replyer"
						value="replyer">
				</div>
				<div class="form-group">
					<label>작성일</label> <input class="form-control" name="replydate"
						value="">
				</div>
			</div>
			<div class="modal-footer">
				<button id='modalModBtn' type="button" class='btn btn-warning'>수정</button>
				<button id='modalRemoveBtn' type="button" class='btn btn-danger'>삭제</button>
				<button id='modalRegisterBtn' type="button" class='btn btn-primary'>생성</button>
				<button id='modalCloseBtn' type="button" class='btn btn-default'>닫기</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- End 댓글모달  -->
<script>
$(function(){
	var operForm = $("#operForm");

	$("button[data-oper='modify']").on("click", function() {
		operForm.attr("action", "/board/modify").submit();
	});

	$("button[data-oper='list']").on("click", function() {
		operForm.find("#bno").remove();
		operForm.attr("action", "/board/list")
		operForm.submit();
	}); //Board페이지 이동
	
	/* ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------  */
	var bnoValue = '${board.bno}';
	var replyUL = $(".chat");
	
	showList(1);
	
	function showList(page){
		console.log(" show list : " + page);
		replyService.getList({
			bno : bnoValue,
			page : page || 1
		}, function(replyCnt, list) {
			console.log("replyCnt : " +replyCnt);

			if (page ==-1) {
				pageNum = Math.ceil(replyCnt/10.0);
				showList(pageNum);
				return;
			}
			var str= "";
			if (list==null || list.length ==0) {
				return;
			}

			for (var i = 0,len=list.length || 0; i < len; i++) {
				str +="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
				str +=" <div><div class='header'><strong class='primary- font'>"+list[i].replyer+"</strong>"; 
				str +=" <small class='pull-right text-muted'>" + replyService.displayTime(list[i].replydate)+ "</small></div>";
				str +=" <p> " + list[i].reply + "</p></div></li>";
			}
			replyUL.html(str);		
			showReplyPage(replyCnt);
		}); //댓글 목록 처리	
	}//End ShowList	
	
	var pageNum=1;
	var replyPageFooter= $(".panel-footer");
	
	function showReplyPage(replyCnt){
		var endNum = Math.ceil(pageNum / 10.0) * 10;
		var startNum = endNum - 9;
		var prev = startNum != 1;
		var next = false;
		
		if (endNum * 10 >=replyCnt) {
			endNum =Math.ceil(replyCnt/10.0);
		}
		if (endNum * 10 <replyCnt) {
			next = true;
		}
	
		var str= "<ul class='pagination pull-right'>";
		if (prev) {
			str+=	"<li class='page-item'><a class='page-link' href='"+(startNum-1)+"'>이전</a></li>";
		}
		for (var i = startNum; i <=endNum; i++) {
			var active = pageNum == i ? "active" : "";
			str+= "<li class='page-item ' "+active+"' ><a class='page-link' href='"+i+"'>"+i+"</a></li>";
		}
		if (next) {
			str+= "<li class='page-item'><a class='page-link' href='"+(endNum+1)+"'>다음</a></li>";
		}
		str+="</ul></div>"
		replyPageFooter.html(str);
	} //페이지 번호 표시
	
	replyPageFooter.on("click","li a",function(e){
		e.preventDefault();
		var targetPageNum = $(this).attr("href");
		console.log("t : " + targetPageNum);
		pageNum = targetPageNum;
		showList(pageNum);
	});
	
	/* ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------  */
	
	
	var modal = $(".modal");	
	var modalInputReply = modal.find("input[name='reply']");
	var modalInputReplyer = modal.find("input[name='replyer']");
	var modalInputReplydate = modal.find("input[name='replydate']");
	var modalModBtn = $('#modalModBtn');
	var modalRemoveBtn = $('#modalRemoveBtn');
	var modalRegisterBtn = $('#modalRegisterBtn');
	var modalCloseBtn = $('#modalCloseBtn');
	 
	 $("#addReplyBtn").click(function(){
		modalInputReplyer.removeAttr("readonly");
		modal.modal({keyboard: false,backdrop: 'static'});
		modal.find("input").val('');
		modalInputReplydate.closest("div").hide();
		modal.find("button[id != 'modalCloseBtn']").hide();
		modalRegisterBtn.show();
		modal.modal("show");
		
	}); //댓글등록버튼
	
	modalRegisterBtn.click(function(){	
		replyService.add({reply : modalInputReply.val(),replyer : modalInputReplyer.val(),
							bno : bnoValue} , function(result){
			alert(result);
			modal.find("input").val("");
			modal.modal("hide");
			showList(-1);
		});
		
	}); //댓글 등록처리
	var rnoValue ;
	replyUL.on("click","li",function(e){
		var rno = $(this).data("rno");
		rnoValue= rno;
		replyService.get(rno,function(reply){
			modal.modal({keyboard: false,backdrop: 'static'});
			modalModBtn.show();
			modalRemoveBtn.show();
			modalInputReplydate.closest("div").show();
			modalInputReply.val(reply.reply);
			modalInputReplyer.val(reply.replyer).attr("readonly","readonly");
			modalInputReplydate.val(replyService.displayTime(reply.replydate)).attr("readonly","readonly");
			modalRegisterBtn.hide();
			modal.modal("show");
		})
		
	}); //댓글클릭처리조회 (삭제, 수정 하기위해서)

	modalModBtn.click(function() {
			
			var reply = {rno : rnoValue, reply : modalInputReply.val(), bno : parseInt(bnoValue)};	
			replyService.update(reply,function(result){
				alert(result);
				modal.modal("hide");
				showList(pageNum);
 			})
		}); //댓글 수정처리
		
	modalRemoveBtn.click(function(){
		
		replyService.remove(rnoValue, function(result){
			alert(result);
			modal.modal("hide");
			showList(pageNum);			
		})
	});//댓글 삭제
	
	 modalCloseBtn.click(function(){
		 modalInputReplyer.removeAttr("readonly");
		 modal.modal("hide");
	 });

	}); //end final function
	
</script>

<%@include file="footer.jsp"%>