package org.zerock.service;

import java.util.List;

import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;

public interface ReplyService {

	public int modify(ReplyVO vo ); //댓글수정
	public int remove(int rno); //댓글삭제
	public int register(ReplyVO vo); //댓글  추가
	public ReplyVO get(int rno); //댓글조회
	public List<ReplyVO>getList(Criteria cri, int bno); //댓글목록
	public ReplyPageDTO getListPage(Criteria cri, int bno); //댓글
}
