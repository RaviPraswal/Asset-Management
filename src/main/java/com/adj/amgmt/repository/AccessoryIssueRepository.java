package com.adj.amgmt.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.adj.amgmt.entity.AccessoryIssue;

@Repository
public interface AccessoryIssueRepository extends JpaRepository<AccessoryIssue, Integer> {

}
