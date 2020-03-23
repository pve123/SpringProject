package org.zerock.mapperTests;



import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.config.RootConfig;

import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

import org.zerock.mapper.ReplyMapper;


import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = RootConfig.class)
@Log4j
public class Mappertests {

	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	@Setter(onMethod_ = @Autowired)
	private ReplyVO vo;



	@Test
	public void test()
	{
		mapper.getListWithPaging(new Criteria(3,10), 6).forEach(list -> log.info(list));
	}
}
