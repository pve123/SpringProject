package org.zerock.service;

import java.util.List;

import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardService {

	public void register(BoardVO board); //추가
	public BoardVO get(int bno); //조회
	public boolean modify(BoardVO board); //수정
	public boolean remove(int bno); //삭제
	public List<BoardVO> getList(Criteria cri); //목록(페이징)
	public int getTotal(Criteria cri); //총 게시물 개수
	public List<BoardVO> boardList(); //엑셀목록

	
}
