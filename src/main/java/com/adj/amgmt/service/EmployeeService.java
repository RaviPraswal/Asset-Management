package com.adj.amgmt.service;

import java.util.List;

import com.adj.amgmt.dto.EmployeeDTO;
import com.adj.amgmt.entity.Employee;


public interface EmployeeService {
	public void addEmployee(EmployeeDTO employeeDTO);
	public void updateEmployee(Employee employee) ;
	public List<EmployeeDTO> getEmployeeList();
	public void deleteEmployeeById(int id);
	public EmployeeDTO getEmployeeById(int empId);

}
