package com.adj.amgmt.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.adj.amgmt.entity.AssetAssignment;

@Repository
public interface AssetAssignmentRepository extends JpaRepository<AssetAssignment, Integer> {

}
