package org.zerock.controller;

import java.io.UnsupportedEncodingException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;
import org.zerock.service.ReplyService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RequestMapping("/replies/")
@RestController
@Log4j
//produces 반환
// consumes 입력
public class ReplyController {

	@Setter(onMethod_ = @Autowired)
	private ReplyService service;

	@PostMapping(value = "/new", consumes = "application/json", produces = {"application/text; charset=utf8"})
	public ResponseEntity<String> create(@RequestBody ReplyVO vo) throws UnsupportedEncodingException {
		log.info("ReplyVO : " + vo);

		int insertCount = service.register(vo);
		log.info("Reply INSERT COUNT : " + insertCount);
		return insertCount == 1 ? new ResponseEntity<>("댓글 등록 성공", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	} // 댓글등록

	@GetMapping(value = "/pages/{page}/{bno}", produces = { MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<ReplyPageDTO> getList(@PathVariable("page") int page,@PathVariable("bno") int bno) {
		Criteria cri = new Criteria(page,10);
		log.info("get Reply List()...........");
		
		return new ResponseEntity<>(service.getListPage(cri, bno), HttpStatus.OK);
	} // 댓글목록페이징

	@DeleteMapping(value = "/{rno}", produces = {"application/text; charset=utf8"})
	public ResponseEntity<String> remove(@PathVariable("rno") int rno) throws UnsupportedEncodingException {
		log.info("delete Reply........");
		int result = service.remove(rno);
		return result == 1 ? new ResponseEntity<String>("댓글 삭제 성공", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}// 댓글삭제

	@GetMapping(value = "/{rno}", produces = { MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") int rno) {
		log.info("get Reply........");
		log.info(service.get(rno));
		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
	} // 댓글조회

	@RequestMapping(method = { RequestMethod.PUT,
			RequestMethod.PATCH }, value = "/{rno}", consumes = "application/json", 
			produces = {"application/text; charset=utf8"})
	public ResponseEntity<String> modify(@RequestBody ReplyVO vo, @PathVariable("rno") int rno) {
		log.info("modify REPLY .......");

		vo.setBno(rno);
		log.info("modify : " + vo);

		return service.modify(vo) == 1 ? new ResponseEntity<String>("댓글 수정 성공", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);

	}// 댓글 수정

}