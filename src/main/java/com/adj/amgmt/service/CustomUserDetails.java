package com.adj.amgmt.service;

import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.adj.amgmt.config.Authority;
import com.adj.amgmt.entity.User;
import com.adj.amgmt.entity.UserRole;

public class CustomUserDetails implements UserDetails {

	private static final long serialVersionUID = 1L;
	private User user;
	private Set<UserRole> roles;

	public CustomUserDetails() {
		super();
	}

	public CustomUserDetails(User user) {
		super();
		this.user = user;
		this.roles = user.getUserRole();
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Set<UserRole> getRoles() {
		return roles;
	}

	public void setRoles(Set<UserRole> roles) {
		this.roles = roles;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {

		try {
			Set<Authority> roles = new HashSet<>();
			this.roles.forEach(role -> {
				roles.add(new Authority(role.getName()));
			});
			return roles;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}

	@Override
	public String getPassword() {

		return user.getPassword();
	}

	@Override
	public String getUsername() {

		return user.getUsername();
	}

	@Override
	public boolean isAccountNonExpired() {

		return true;
	}

	@Override
	public boolean isAccountNonLocked() {

		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {

		return true;
	}

	@Override
	public boolean isEnabled() {

		return true;
	}

}
