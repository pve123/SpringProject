console.log("Reply Module...");

var replyService = (function(){
	
	
	function add(reply, callback, error){
		console.log("reply...............");
		
		$.ajax({
		
			type : 'post',
			url : '/replies/new',
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr){
				if (callback) {				
					callback(result);
				}
			},
			error : function(xhr, status, er){
				if (error) {
					error(er);
				}
			}
			
		}) //end insert ajax
	}; //end function 등록
	
	function getList(param, callback, error){
		var bno = param.bno;
		var page = param.page || 1;
		
		$.getJSON("/replies/pages/" + page + "/" + bno + ".json", function(data){
			if(callback){
				callback(data.replyCnt, data.list);
			}
		}).fail(function(xhr,status,err){
			if(error){
				error();
			}
		});
	}//end function 목록
	
	function remove(rno , callback , error){

		$.ajax({
			
			type : 'DELETE',
			url : '/replies/' + rno,
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(er, status, xhr){
				if(error){
					error(er);
				}
			}
		}) //END ajax	
	} //End function 삭제
	
	function update(reply, callback ,error){

		$.ajax({
			type : 'PUT',
			url : '/replies/'+reply.rno,
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr){
				if (callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er){
				if (error) {
					error(er);
				}
			}
		}) //end ajax
	} // end function 수정
	
	function get(rno, callback, error){
		
		$.getJSON("/replies/" + rno + ".json", function(result){
			if(callback){			
				callback(result);			
			}
		}).fail(function(xhr,status,err){
			if(error){
				error();
			}
		});
	}
	
	function displayTime(timevalue){
		var today = new Date();
		var gap = today.getTime() - timevalue;
		var dateObj = new Date(timevalue);
		var str="";

			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			var yy =dateObj.getYear() + 1900;
			var mm =dateObj.getMonth() +1; 
			var dd =dateObj.getDate();
			return [yy, '/', (mm > 9 ? '' : '0') + mm, '/',(dd >9 ? '' : '0') +dd, " ",(hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi].join('');
		
	};//시간
	

	


	
	return { add : add, getList : getList, remove : remove, update : update, get : get, displayTime : displayTime};
})();

