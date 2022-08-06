package com.adj.amgmt.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.adj.amgmt.entity.Bill;
import com.adj.amgmt.repository.BillRepository;

@Service
public class BillServiceImpl implements BillService {

	@Autowired
	BillRepository billRepository;

	public Bill getByName(String billName) {
		try {
			Bill findByfileName = billRepository.findByfileName(billName);
			return findByfileName;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}
	public Bill getFile(String id) {
		return billRepository.findByid(id);
	}

	public java.util.stream.Stream<Bill> getAllFiles() {
		return billRepository.findAll().stream();
	}

}
