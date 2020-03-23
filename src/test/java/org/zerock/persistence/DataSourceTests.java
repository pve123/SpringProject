package org.zerock.persistence;

import static org.junit.Assert.fail;

import java.sql.Connection;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.config.RootConfig;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = { RootConfig.class })
@Log4j
public class DataSourceTests {

	@Setter(onMethod_ = @Autowired)
	private DataSource datasource;

	@Setter(onMethod_ = @Autowired)
	private SqlSessionFactory sqlsessionFactory;

//	@Test
//	public void testConnection() {
//		
//		try(Connection con = datasource.getConnection()) {
//			
//			log.info(con);
//		} catch (Exception e) {
//			fail(e.getMessage());
//		}
//	} //datasource를 이용한 커낵션풀
	@Test
	public void testMyBatis() {
		try (SqlSession session = sqlsessionFactory.openSession(); 
				Connection con = session.getConnection()) {

			log.info(session);
			log.info(con);
		} catch (Exception e) {
			fail(e.getMessage());
		}
	} //mybatis를 이용해서 커넥션풀을 가져와 이용
}
