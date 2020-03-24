package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardMapper {


//	public void insert(BoardVO board); //추가 bno= null
	public void insertSelectKey(BoardVO board); //추가 bno=not null
	public BoardVO read(int bno); //조회
	public int delete(int bno); //삭제
	public int update(BoardVO board);//수정
	public List<BoardVO> getListWithPaging(Criteria cri); //목록 페이징
	public int getTotalCount(Criteria cri); //총 게시물 개수
	public List<BoardVO> boardList(); //엑셀목록
	public void updateReplyCnt(@Param("bno") int bno, @Param("amount") int amount); //댓글수
}
