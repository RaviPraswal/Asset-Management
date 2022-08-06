package com.adj.amgmt.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.adj.amgmt.dto.AccessoryIssueDTO;
import com.adj.amgmt.dto.AssetAssignmentDTO;
import com.adj.amgmt.dto.EmployeeDTO;
import com.adj.amgmt.service.AccessoryIssueService;
import com.adj.amgmt.service.AssetAssignmentService;
import com.adj.amgmt.service.EmployeeService;

@Controller
@RequestMapping("/employee")
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;
	
	@Autowired
	AssetAssignmentService assetAssignmentService;
	
	@Autowired
	AccessoryIssueService accessoryIssueService;
	
	Logger logger
    = LoggerFactory.getLogger(this.getClass().getName());

	// controller to open employee page
	@RequestMapping(value = "/")
	public ModelAndView listView() {
		ModelAndView modelAndView = new ModelAndView();
		try {
			List<EmployeeDTO> employeeListDTO = employeeService.getEmployeeList();
			modelAndView.addObject("employeeList", employeeListDTO);
			modelAndView.setViewName("employeeView");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return modelAndView;

	}

	// controller to open save form of employee
	@RequestMapping(value = "/open_employee")
	public String saveView(Model model) {
		model.addAttribute("employee", new EmployeeDTO());
		return "saveUpdateEmployee";
	}

	// controller to save an employee
	@RequestMapping(value = "/save_update_employee")
	public ModelAndView saveEmployee(@ModelAttribute("employee") EmployeeDTO employeeDTO) {
		ModelAndView modelAndView = new ModelAndView();
		try {
			/*
			 * List<EmployeeDTO> employeeList = employeeService.getEmployeeList(); for
			 * (EmployeeDTO employeeDTO2 : employeeList) { if
			 * (employeeDTO2.getEmail().equals(employeeDTO.getEmail())) {
			 * System.out.println("Employee already exists<----");
			 * modelAndView.addObject("existEmail", " * This Email already exist!");
			 * modelAndView.setViewName("saveUpdateEmployee"); return modelAndView; } }
			 */
			employeeService.addEmployee(employeeDTO);
			modelAndView.addObject("saved", "savedSuccessfully");
			modelAndView.setViewName("redirect:/employee/");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return modelAndView;
	}

	// controller to save an employee
	@RequestMapping(value = "/editEmployee")
	public ModelAndView editEmployee(@RequestParam("empId") int empId) {
		ModelAndView modelAndView = new ModelAndView("employee");
		EmployeeDTO employeeDTO = employeeService.getEmployeeById(empId);
		modelAndView.addObject("employee", employeeDTO);
		modelAndView.setViewName("saveUpdateEmployee");
		return modelAndView;
	}

	// controller to delete an employee by id
	@RequestMapping("/delete_employee_by_Id")
	public ModelAndView deleteById(@ModelAttribute("id") int id) {
		ModelAndView modelAndView = new ModelAndView();
		List<AccessoryIssueDTO> accessoryIssueDTOList= accessoryIssueService.getAccessoryIssuesList();
		List<AssetAssignmentDTO> assList=assetAssignmentService.getAssetAssignmentList();
		for (AssetAssignmentDTO assetAssignmentDTO : assList) {
			for (AccessoryIssueDTO accessoryIssueDTO : accessoryIssueDTOList) {
				if((id==assetAssignmentDTO.getEmployee().getEmployeeId()) &&(id==accessoryIssueDTO.getIssuedToEmployee().getEmployeeId())) {
					modelAndView.addObject("exist", "this employee already assigned");
					modelAndView.setViewName("emp_error");
				}else if(id==assetAssignmentDTO.getEmployee().getEmployeeId()) {
					modelAndView.addObject("exist", "this employee already assigned");
					modelAndView.setViewName("emp_error");
				}else if(id==accessoryIssueDTO.getIssuedToEmployee().getEmployeeId()) {
					modelAndView.addObject("exist", "this employee already assigned");
					modelAndView.setViewName("emp_error");
				}else {					
					employeeService.deleteEmployeeById(id);
					modelAndView.addObject("delete", "deleted");
					modelAndView.setViewName("redirect:/employee/");
				}
			}
		}
		return modelAndView;
	}

}
