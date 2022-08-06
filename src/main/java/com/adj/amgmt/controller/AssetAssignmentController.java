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

import com.adj.amgmt.dto.AssetAssignmentDTO;
import com.adj.amgmt.dto.AssetDTO;
import com.adj.amgmt.dto.AssetPDFExporter;
import com.adj.amgmt.dto.EmployeeDTO;
import com.adj.amgmt.service.AssetAssignmentService;
import com.adj.amgmt.service.AssetsServiceImpl;
import com.adj.amgmt.service.EmployeeService;
import com.lowagie.text.DocumentException;

@Controller
@RequestMapping("/asset_assignment")
public class AssetAssignmentController {

	@Autowired
	AssetAssignmentService assetAssignmentService;

	@Autowired
	AssetsServiceImpl assetService;

	@Autowired
	EmployeeService employeeService;

	// controller to show asset_assignment page
	@RequestMapping("/")
	public ModelAndView listView() {
		ModelAndView modelAndView = new ModelAndView();
		try {
			List<AssetAssignmentDTO> assetAssignmentListDTO = assetAssignmentService.getAssetAssignmentList();
			modelAndView.addObject("assetAssignmentList", assetAssignmentListDTO);
			modelAndView.setViewName("assetAssignmentView");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return modelAndView;
	}

	@RequestMapping(value = "/open_asset_assignemnt")
	public ModelAndView saveView() {
		ModelAndView modelAndView = new ModelAndView();
		try {
			modelAndView.addObject("assetAssignment", new AssetAssignmentDTO());

			// loading assets
			List<AssetDTO> loadAssetDTO = assetService.getAssetList();
			modelAndView.addObject("loadAsset", loadAssetDTO);

			// loading employee
			List<EmployeeDTO> loadEmployeeDTO = employeeService.getEmployeeList();
			modelAndView.addObject("loadEmployee", loadEmployeeDTO);

			modelAndView.setViewName("saveUpdateAssetAssignment");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return modelAndView;
	}

	@RequestMapping(value = "/save_update_asset_assignment")
	public ModelAndView saveAssetAssignment(
			@Valid @ModelAttribute("assetAssignment") AssetAssignmentDTO assetAssignmentDTO, Errors errors) {
		ModelAndView modelAndView = new ModelAndView();

		if (errors.hasErrors()) {
			// loading assets
			List<AssetDTO> loadAssetDTO = assetService.getAssetList();
			modelAndView.addObject("loadAsset", loadAssetDTO);

			// loading employee
			List<EmployeeDTO> loadEmployeeDTO = employeeService.getEmployeeList();
			modelAndView.addObject("loadEmployee", loadEmployeeDTO);
			modelAndView.setViewName("saveUpdateAssetAssignment");

		} else {
			assetAssignmentService.saveAssetAssignment(assetAssignmentDTO);
			modelAndView.addObject("saved", "save/update");
			modelAndView.setViewName("redirect:/asset_assignment/");
		}

		return modelAndView;
	}

	@RequestMapping("/open_update_asset_assignment_form")
	public ModelAndView openUpdateform(@RequestParam("assetAssignmentId") int assetAssignmentId) {
		ModelAndView modelAndView = new ModelAndView("assetAssignment");
		AssetAssignmentDTO assetAssignmentDTO = assetAssignmentService.getAssetAssignmentById(assetAssignmentId);
		modelAndView.addObject("assetAssignment", assetAssignmentDTO);
		// loading assets
		List<AssetDTO> loadAssetDTO = assetService.getAssetList();
		modelAndView.addObject("loadAsset", loadAssetDTO);

		// loading employee
		List<EmployeeDTO> loadEmployee = employeeService.getEmployeeList();
		modelAndView.addObject("loadEmployee", loadEmployee);
		modelAndView.setViewName("saveUpdateAssetAssignment");
		return modelAndView;
	}

	@RequestMapping("/delete_asset_assignment")
	public ModelAndView deleteById(@RequestParam int id) {
		ModelAndView modelAndView = new ModelAndView();
		try {
			assetAssignmentService.deleteAssetAssignmentById(id);
			modelAndView.addObject("deleted", "delete");
			modelAndView.setViewName("redirect:/asset_assignment/");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return modelAndView;
	}
	@RequestMapping("/pdf")
	public void exportToPDF(HttpServletResponse response)
			throws DocumentException, IOException {
		response.setContentType("application/pdf");
		DateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd_HH:mm:ss");
		String currentDateTime = dateFormatter.format(new Date());

		String headerKey = "Content-Disposition";
		String headerValue = "attachment; filename=Asset_" + currentDateTime + ".pdf";
		response.setHeader(headerKey, headerValue);

		List<AssetAssignmentDTO> asset = assetAssignmentService.getAssetAssignmentList();

		AssetPDFExporter exporter = new AssetPDFExporter(asset);
		exporter.export(response);

	}
}
