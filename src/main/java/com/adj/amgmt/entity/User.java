package com.adj.amgmt.entity;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "users")
@Data
@NoArgsConstructor
public class User {

	@Id
	@Column(name = "username")
	private String username;

	@Column(name = "password", nullable = false)
	private String password;

	@Column(name = "enabled", nullable = false)
	private boolean enabled;

	@OneToMany(fetch = FetchType.EAGER, cascade =  CascadeType.ALL)
	@JoinTable(name = "user_and_role",joinColumns = @JoinColumn(name="username") ,inverseJoinColumns = @JoinColumn(name="userRoleId"))
	private Set<UserRole> userRole;
	
	public User(String string, String string2, boolean b, Set<UserRole> r) {
		this.username=string;
		this.password=string2;
		this.enabled=b;
		this.userRole=r;
	}

}
