package com.adj.amgmt.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/admin")
public class AppController {

	@RequestMapping("/")
	public String home() {
		return "home";
	}
	
	// controller for asset
	@RequestMapping("/asset_view")
	public ModelAndView assetView() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/asset/");
		return modelAndView;
	}

	// controller to asset type
	@RequestMapping("/asset_type_view")
	public ModelAndView assetTypeView() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/asset_type/");
		return modelAndView;
	}

	// controller to show accessory page
	@RequestMapping("/accessory_view")
	public ModelAndView accessoryView() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/accessory/");
		return modelAndView;
	}

	// controller to show accessory page
	@RequestMapping("/asset_assignment_view")
	public ModelAndView assetAssignmentView() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/asset_assignment/");
		return modelAndView;
	}

	// controller to show accessory page
	@RequestMapping("/accessory_type_view")
	public ModelAndView accessoryTypeView() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/accessory_type/");
		return modelAndView;
	}

	// controller to show accessory issues page
	@RequestMapping("/accessory_issues_view")
	public ModelAndView accessoryIssuesView() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/accessory_issues/");
		return modelAndView;
	}

	// controller to show accessory type page
	@RequestMapping("/employee_view")
	public ModelAndView employeeView() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/employee/");
		return modelAndView;
	}

}
