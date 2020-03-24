package org.zerock.mapperTests;



import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.config.RootConfig;

import org.zerock.service.SampleService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = RootConfig.class)
@Log4j
public class Mappertests {

	@Setter(onMethod_ = @Autowired)
	private SampleService service;

	@Test
	public void test() throws Exception
	{
		log.info("test : " +service);
		log.info("test : " +service.getClass().getName());
		log.info(service.doAdd("123", "456"));
	}
}
