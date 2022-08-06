package com.adj.amgmt.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.adj.amgmt.dto.AccessoryDTO;
import com.adj.amgmt.dto.AccessoryIssueDTO;
import com.adj.amgmt.dto.AccessoryPDFExporter;
import com.adj.amgmt.dto.EmployeeDTO;
import com.adj.amgmt.service.AccessoryIssueService;
import com.adj.amgmt.service.AccessoryService;
import com.adj.amgmt.service.EmployeeService;
import com.lowagie.text.DocumentException;

@Controller
@RequestMapping("/accessory_issues")
public class AccessoryIssuesController {

	@Autowired
	AccessoryIssueService accessoryIssueService;

	@Autowired
	AccessoryService accessoryService;

	@Autowired
	EmployeeService employeeService;


	// controller to show accessory issues page
	@RequestMapping("/")
	public ModelAndView listView() {
		ModelAndView modelAndView = new ModelAndView();
		try {
			List<AccessoryIssueDTO> accessoryIssueList = accessoryIssueService.getAccessoryIssuesList();
			modelAndView.addObject("accessoryIssuesList", accessoryIssueList);
			modelAndView.setViewName("accessoryIssuesView");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return modelAndView;
	}

	// controller to save accessory issue
	@RequestMapping(value = "/open_accessory_issue")
	public ModelAndView saveView() {
		ModelAndView modelAndView = new ModelAndView();
		try {
			modelAndView.addObject("accessoryIssues", new AccessoryIssueDTO());

			// loading accessories
			List<AccessoryDTO> loadAccessory = accessoryService.getAccessoryList();
			modelAndView.addObject("loadAccessory", loadAccessory);

			// loading employees
			List<EmployeeDTO> loadEmployee = employeeService.getEmployeeList();
			modelAndView.addObject("loadEmployee", loadEmployee);

			modelAndView.setViewName("saveUpdateAccessoryIssue");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return modelAndView;
	}

	// controller to save accessory issue
	@RequestMapping(value = "/save_update_accessory_issue")
	public ModelAndView saveAccessoryIssue(
			@Valid @ModelAttribute("accessoryIssues") AccessoryIssueDTO accessoryIssueDTO, Errors errors) {
		ModelAndView modelAndView = new ModelAndView();

		if (errors.hasErrors()) {
			// loading accessories
			List<AccessoryDTO> loadAccessory = accessoryService.getAccessoryList();
			modelAndView.addObject("loadAccessory", loadAccessory);

			// loading employees
			List<EmployeeDTO> loadEmployee = employeeService.getEmployeeList();
			modelAndView.addObject("loadEmployee", loadEmployee);

			modelAndView.setViewName("saveUpdateAccessoryIssue");
		} else {
			boolean saveAccessoryIssue = accessoryIssueService.saveAccessoryIssue(accessoryIssueDTO);
			if(saveAccessoryIssue==false) {
				modelAndView.addObject("qty", "Qty");
				modelAndView.setViewName("redirect:/accessory_issues/");
			}
			modelAndView.addObject("saved", "save/update");
			modelAndView.setViewName("redirect:/accessory_issues/");
		}
		return modelAndView;
	}

	// controller to save accessory issue
	@RequestMapping(value = "/open_update_accessory_issue")
	public ModelAndView openUpdateAccessoryIssue(@RequestParam("accessoryIssueId") int accessoryIssueId) {
		ModelAndView modelAndView = new ModelAndView("accessoryIssues");
		try {
			AccessoryIssueDTO accessoryIssueDTO = accessoryIssueService.getAccessoryIssueById(accessoryIssueId);
			modelAndView.addObject("accessoryIssues", accessoryIssueDTO);

			// loading accessories
			List<AccessoryDTO> loadAccessory = accessoryService.getAccessoryList();
			modelAndView.addObject("loadAccessory", loadAccessory);

			// loading employees
			List<EmployeeDTO> loadEmployee = employeeService.getEmployeeList();
			modelAndView.addObject("loadEmployee", loadEmployee);

			modelAndView.setViewName("saveUpdateAccessoryIssue");
		} catch (Exception e) {
			// TODO: handle exception
		}
		return modelAndView;
	}

	// controller to delete accessory issue
	@RequestMapping("/delete_accessory_issue")
	public ModelAndView deleteById(@RequestParam int id) {
		ModelAndView modelAndView = new ModelAndView();
		try {
			accessoryIssueService.deleteAccessoryIssueById(id);
			modelAndView.addObject("deleted", "delete");
			modelAndView.setViewName("redirect:/accessory_issues/");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return modelAndView;
	}
	@RequestMapping("/pdf")
    public void exportToPDF(HttpServletResponse response) throws DocumentException, IOException {
        response.setContentType("application/pdf");
        DateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd_HH:mm:ss");
        String currentDateTime = dateFormatter.format(new Date());         
        String headerKey = "Content-Disposition";
        String headerValue = "attachment; filename=Accessory_" + currentDateTime + ".pdf";
        response.setHeader(headerKey, headerValue);
        List<AccessoryIssueDTO> list1 = accessoryIssueService.getAccessoryIssuesList();
        AccessoryPDFExporter exporter = new AccessoryPDFExporter(list1);
        exporter.export(response);
         
    }
}
