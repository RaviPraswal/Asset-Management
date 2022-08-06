package com.adj.amgmt.dto;

import java.util.HashSet;
import java.util.Set;

import com.adj.amgmt.entity.UserRole;

import lombok.Data;

@Data
public class User {
	
	private String username;
	private String password;
	private boolean enabled;
	private Set<UserRole> userRole = new HashSet<UserRole>();

}
