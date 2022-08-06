package com.adj.amgmt.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.adj.amgmt.entity.Accessory;

@Repository
public interface AccessoryRepository extends JpaRepository<Accessory, Integer> {

}
