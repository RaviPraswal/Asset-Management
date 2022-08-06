package com.adj.amgmt.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.adj.amgmt.entity.User;
import com.adj.amgmt.repository.UserRepository;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {

	@Autowired
	private UserRepository userRepository;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		try {
			User userRepo = userRepository.findByusername(username);
			CustomUserDetails customUserDetails = null;
			if (userRepo == null) {
				throw new UsernameNotFoundException("User does Not Found...");
			}
			customUserDetails = new CustomUserDetails(userRepo);
			return customUserDetails;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}

}
