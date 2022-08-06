package com.adj.amgmt.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.adj.amgmt.entity.Asset;

@Repository
public interface AssetRepository extends JpaRepository<Asset, Integer>{

}
