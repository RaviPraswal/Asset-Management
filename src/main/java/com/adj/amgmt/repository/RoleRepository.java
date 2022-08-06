package com.adj.amgmt.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.adj.amgmt.entity.UserRole;

@Repository
public interface RoleRepository extends JpaRepository<UserRole, Integer> {

	/*
	 * @Query("select ur from UserRole ur where ur.name=:name") UserRole
	 * findByName(@Param("name") String string);
	 */

}
