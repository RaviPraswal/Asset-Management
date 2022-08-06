package com.adj.amgmt.config;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;

import com.adj.amgmt.service.UserDetailsServiceImpl;

@Configuration
@EnableWebSecurity
public class ApplicationConfig extends WebSecurityConfigurerAdapter {

	@Autowired
	private UserDetailsServiceImpl userDetailsServiceImpl;

	@Bean
	public ModelMapper modelMapper() {
		ModelMapper modelMapper = new ModelMapper();
		return modelMapper;
	}

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(userDetailsServiceImpl);

	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {

		http.authorizeHttpRequests().antMatchers("/admin/**").hasRole("ADMIN").antMatchers("/").permitAll().and()
				.formLogin().loginPage("/login").defaultSuccessUrl("/admin/").failureUrl("/authFail").and().logout()
				.logoutUrl("/logout").permitAll();
		http.csrf().disable();
	}

	@Bean
	public UserDetailsService getDetailsService() {
		return new UserDetailsServiceImpl();
	}

	@Bean
	public NoOpPasswordEncoder passwordEncoder() {

		return (NoOpPasswordEncoder) NoOpPasswordEncoder.getInstance();
	}

	
}
