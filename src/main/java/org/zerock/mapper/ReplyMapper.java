package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

public interface ReplyMapper {

	public int insertSelectKey(ReplyVO vo);//댓글등록
	public ReplyVO read(int rno); // 댓글보기
	public int delete(int rno); //댓글삭제
	public int update(ReplyVO vo); //댓글수정
	public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri,@Param("bno")int bno); //댓글목록
}
