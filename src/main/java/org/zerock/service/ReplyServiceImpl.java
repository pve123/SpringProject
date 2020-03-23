package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService {

	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;

	@Override
	public int modify(ReplyVO vo) {

		log.info("modify......" + vo);

		return mapper.update(vo);
	}

	@Override
	public int remove(int rno) {
		log.info("remove......" + rno);
		return mapper.delete(rno);
	}

	@Override
	public int register(ReplyVO vo) {
		log.info("register......" + vo);
		return mapper.insertSelectKey(vo);
	}

	@Override
	public ReplyVO get(int rno) {
		log.info("get......" + rno);
		return mapper.read(rno);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, int bno) {
		log.info("List<ReplyVO>......");
		return mapper.getListWithPaging(cri, bno);
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, int bno) {
		
		return new ReplyPageDTO(mapper.getCountByBno(bno), mapper.getListWithPaging(cri, bno));
	}

}
