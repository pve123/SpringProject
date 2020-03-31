package org.zerock.config;


import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.zerock.security.CustomLoginSuccessHandler;

import lombok.extern.log4j.Log4j;

@Configuration
@EnableWebSecurity
@Log4j
public class SecurityConfig extends WebSecurityConfigurerAdapter {

//	@Setter(onMethod_ = @Autowired)
//	private DataSource datasource;

	@Override
	protected void configure(HttpSecurity http) throws Exception {

		http.authorizeRequests().antMatchers("/sample/all").permitAll().antMatchers("/sample/admin")
				.access("hasRole('ROLE_ADMIN')").antMatchers("/sample/member").access("hasRole('ROLE_MEMBER')");

		http.formLogin().loginPage("/customLogin").loginProcessingUrl("/login").successHandler(loginSuccessHandler());

		http.logout().logoutUrl("/customLogout").invalidateHttpSession(true).deleteCookies("remember-me",
				"JSESSION_ID");

	}

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {

		log.info("configure....................");
		auth.inMemoryAuthentication().withUser("admin").password("{noop}admin").roles("ADMIN");
		auth.inMemoryAuthentication().withUser("member")
				.password("$2a$10$QwtAmzJTCHg80xLJv1gbZurMySuYJOuPkif426A3ek/nGeR8y.wtC").roles("MEMBER");
	}

	@Bean
	public AuthenticationSuccessHandler loginSuccessHandler() {
		return new CustomLoginSuccessHandler();
	}

	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	} //암호화 하지않을거야

}
