package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;

	@Override
	public void register(BoardVO board) {

		log.info("추가 하실수 있어요..............");
		mapper.insertSelectKey(board);

	}

	@Override
	public BoardVO get(int bno) {

		log.info("한명만 조회할수있어요..............");

		return mapper.read(bno);

	}

	@Override
	public boolean modify(BoardVO board) {

		boolean result = false;
		if (mapper.update(board) == 1) {
			result = true;
			log.info(board.getBno() + "번 게시물 수정");
		} else {
			log.info(board.getBno() + "번 게시물 수정 실패");
		}

		return result;
	}

	@Override
	public boolean remove(int bno) {

		boolean result = false;
		if (mapper.delete(bno) == 1) {
			result = true;
		}

		return result;
	}

	@Override
	public List<BoardVO> getList(Criteria cri) {

		
		log.info("게시물 목록을 조회합니다...........");
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("-----------총 게시물 개수-------------");
		return mapper.getTotalCount(cri);
	} //총게시물개수

	@Override
	public List<BoardVO> boardList() {
		
		return mapper.boardList();
	} //엑셀목록



}
