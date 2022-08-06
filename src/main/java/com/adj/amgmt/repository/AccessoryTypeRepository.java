package com.adj.amgmt.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.adj.amgmt.entity.AccessoryTypes;

@Repository
public interface AccessoryTypeRepository extends JpaRepository<AccessoryTypes, Integer> {

	
}
