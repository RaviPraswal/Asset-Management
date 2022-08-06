package com.adj.amgmt.service;

import com.adj.amgmt.entity.Bill;

public interface BillService {
	public Bill getByName(String billName);
	public Bill getFile(String id);
}
