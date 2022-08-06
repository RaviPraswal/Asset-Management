package com.adj.amgmt.service;

import java.util.List;

import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.adj.amgmt.dto.EmployeeDTO;
import com.adj.amgmt.entity.Employee;
import com.adj.amgmt.repository.EmployeeRepository;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Service
public class EmployeeServiceImpl implements EmployeeService {

	@Autowired
	EmployeeRepository employeeRepository;

	@Autowired
	ModelMapper modelMapper;

	public void addEmployee(EmployeeDTO employeeDTO) {
		try {
			Employee employee = modelMapper.map(employeeDTO, Employee.class);
			employeeRepository.saveAndFlush(employee);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public List<EmployeeDTO> getEmployeeList() {
		try {
			List<Employee> employeeList = employeeRepository.findAll();

			List<EmployeeDTO> employeeListDTO = modelMapper.map(employeeList,
					((TypeToken<List<EmployeeDTO>>) new TypeToken<List<EmployeeDTO>>() {
					}).getType());

			return employeeListDTO;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public void updateEmployee(Employee employee) {
		try {
			employeeRepository.saveAndFlush(employee);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void deleteEmployeeById(int id) {
		try {
			employeeRepository.deleteById(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public EmployeeDTO getEmployeeById(int empId) {
		try {
			Employee employee = employeeRepository.getById(empId);
			EmployeeDTO employeeDTO = modelMapper.map(employee, EmployeeDTO.class);
			return employeeDTO;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}
