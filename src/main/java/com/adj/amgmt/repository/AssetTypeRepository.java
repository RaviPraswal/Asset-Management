package com.adj.amgmt.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.adj.amgmt.entity.AssetTypes;

@Repository
public interface AssetTypeRepository extends JpaRepository<AssetTypes, Integer> {

}
