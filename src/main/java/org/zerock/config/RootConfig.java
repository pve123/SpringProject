package org.zerock.config;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

@Configuration
@ComponentScan(basePackages = { "org.zerock.service", "org.zerock.domain" })
@MapperScan(basePackages = { "org.zerock.mapper" })
public class RootConfig {

	@Bean
	public HikariDataSource dataSource() {
		HikariConfig hikariconfig = new HikariConfig();
//		hikariconfig.setDriverClassName("oracle.jdbc.driver.OracleDriver"); //log4jdbc때문에 수정
//		hikariconfig.setJdbcUrl("jdbc:oracle:thin:@localhost:1521:XE"); //log4jdbc때문에 수정
		hikariconfig.setDriverClassName("net.sf.log4jdbc.sql.jdbcapi.DriverSpy");
		hikariconfig.setJdbcUrl("jdbc:log4jdbc:oracle:thin:@localhost:1521:XE");
		hikariconfig.setUsername("hosung");
		hikariconfig.setPassword("1111");

		HikariDataSource dataSource = new HikariDataSource(hikariconfig);

		return dataSource;
	} // hikari를 통한 커넥션 풀등록

	@Bean
	public SqlSessionFactory sqlSessionFactory() throws Exception {
		SqlSessionFactoryBean sqlSessionFactory = new SqlSessionFactoryBean();
		sqlSessionFactory.setDataSource(dataSource());
		return sqlSessionFactory.getObject();
	}
}
