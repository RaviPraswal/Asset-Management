package com.adj.amgmt.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@Table(name = "user_roles")
@NoArgsConstructor
public class UserRole {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "user_role_id", unique = true, nullable = false)
	private Integer userRoleId;

	private String name;

	public UserRole(String name) {
		this.name = name;
	}

	/*
	 * @ManyToOne(fetch = FetchType.LAZY)
	 * 
	 * @JoinColumn(name = "username", nullable = false) private User user;
	 * 
	 * @Column(name="role", nullable = false) private String role;
	 */

}
