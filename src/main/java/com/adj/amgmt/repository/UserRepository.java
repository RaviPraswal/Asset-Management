package com.adj.amgmt.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.adj.amgmt.entity.User;

@Repository
public interface UserRepository extends JpaRepository<User, String>{
	public User findByusername(String userName);
}
