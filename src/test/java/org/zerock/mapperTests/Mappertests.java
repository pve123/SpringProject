package org.zerock.mapperTests;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.config.RootConfig;
import org.zerock.config.SecurityConfig;
import org.zerock.service.SampleService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {RootConfig.class,SecurityConfig.class})
@Log4j
public class Mappertests {

	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pw;

	@Test
	public void test() {

		String str = "member";
		String enStr = pw.encode(str);
		log.info(enStr);
	}
}
