package com.adj.amgmt.repository;

import org.springframework.data.mongodb.repository.MongoRepository;

import com.adj.amgmt.entity.Bill;

public interface BillRepository extends MongoRepository<Bill, String>{

	public Bill findByfileName(String billName);

	 public Bill findByid(String id);

}
