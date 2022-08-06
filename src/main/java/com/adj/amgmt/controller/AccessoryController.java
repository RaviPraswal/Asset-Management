package com.adj.amgmt.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.adj.amgmt.dto.AccessoryDTO;
import com.adj.amgmt.dto.AccessoryExcelExporter;
import com.adj.amgmt.dto.AccessoryIssueDTO;
import com.adj.amgmt.dto.AccessoryTypesDTO;
import com.adj.amgmt.entity.Bill;
import com.adj.amgmt.service.AccessoryIssueService;
import com.adj.amgmt.service.AccessoryService;
import com.adj.amgmt.service.AccessoryTypesServiceImpl;
import com.adj.amgmt.service.BillServiceImpl;

@Controller
@RequestMapping("/accessory")
public class AccessoryController {

	@Autowired
	AccessoryService accessoryService;

	@Autowired
	AccessoryIssueService accessoryIssueService;

	@Autowired
	AccessoryTypesServiceImpl accessoryTypesService;
	
	@Autowired
	BillServiceImpl billService;


	// controller to show accessory page
	@RequestMapping("/")
	public ModelAndView listView() {
		ModelAndView modelAndView = new ModelAndView();
		try {
			List<AccessoryDTO> accessoryListDTO = accessoryService.getAccessoryList();
			modelAndView.addObject("accessoryList", accessoryListDTO);
			modelAndView.setViewName("accessoryView");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return modelAndView;
	}

	// controller to open saveAccessory page
	@GetMapping(value = "/open_accessory_view")
	public ModelAndView saveView() {
		ModelAndView modelAndView = new ModelAndView();
		try {
			modelAndView.addObject("accessory", new AccessoryDTO());
			// loading accessory type
			List<AccessoryTypesDTO> accessoryTypesDTO = accessoryTypesService.getAccessoryTypeList();
			modelAndView.addObject("loadAccessoryTypes", accessoryTypesDTO);
			modelAndView.setViewName("saveUpdateAccessory");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return modelAndView;
	}

	// controller to save accessory
	@PostMapping(value = "/save_update_accessory")
	public ModelAndView saveAccessory(@Valid @ModelAttribute("accessory") AccessoryDTO accessoryDTO, Errors errors,
			HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		System.out.println("---->"+accessoryDTO.getFile().getOriginalFilename());
		if (errors.hasErrors()) {
			List<AccessoryTypesDTO> accessoryTypesDTO = accessoryTypesService.getAccessoryTypeList();
			modelAndView.addObject("loadAccessoryTypes", accessoryTypesDTO);
			modelAndView.setViewName("saveUpdateAccessory");
		} else {
		accessoryService.saveAccessory(accessoryDTO);
			modelAndView.addObject("saved", "save/update");
			modelAndView.setViewName("redirect:/accessory/");
		}

		return modelAndView;
	}

	// controller to open update form for accessory type
	@RequestMapping("/open_update_accessory_form")
	public ModelAndView openUpdateform(@RequestParam("accessoryId") int accessoryId) {
		ModelAndView modelAndView = new ModelAndView("accessory");

		try {
			AccessoryDTO accessoryDTO = accessoryService.getAccessoryById(accessoryId);
			modelAndView.addObject("accessory", accessoryDTO);
			List<AccessoryTypesDTO> accessoryTypesDTO = accessoryTypesService.getAccessoryTypeList();
			modelAndView.addObject("loadAccessoryTypes", accessoryTypesDTO);
			modelAndView.addObject("billFileName", accessoryDTO.getBillFileName());
			modelAndView.setViewName("saveUpdateAccessory");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return modelAndView;
	}

	// controller to delete accessory
	@RequestMapping(value = "/delete_accessory",method = RequestMethod.POST)
	public ModelAndView deleteById(@RequestParam int id) {
		ModelAndView modelAndView = new ModelAndView();
		List<AccessoryIssueDTO> accessoryIssuesList = accessoryIssueService.getAccessoryIssuesList();
		try {
			for (AccessoryIssueDTO accessoryIssueDTO : accessoryIssuesList) {
				AccessoryDTO accessory = accessoryIssueDTO.getAccessory();
				if (accessory.getId() == id) {
					modelAndView.addObject("existId", "This accessory already assigned.");
					modelAndView.setViewName("accessoryError");
				} else {
					accessoryService.deleteAccessoryBySkuId(id);
					modelAndView.addObject("deleted", "delete");
					modelAndView.setViewName("redirect:/accessory/");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return modelAndView;
	}
	@RequestMapping(value = "/bill_download/{id}",method = RequestMethod.GET)
	public ResponseEntity getFile(@PathVariable String id, HttpServletResponse response) throws IOException {
		//store in directory file codse here..
		Bill bill = billService.getFile(id);
		String stringfile = "D:/asset-mgmt-files" + bill.getFileName();
		String s = Base64.getEncoder().encodeToString(bill.getFileBill().getData());
		byte[] decode = Base64.getDecoder().decode(s);
		Files.write(Paths.get(stringfile), decode);
		
		//download code here...
		File file = new File(stringfile);
		response.setContentType("application/octet-stream");
		String headerKey = "content-Disposition";
		String headerValue = "attachment; filename=" + file.getName();
		response.setHeader(headerKey, headerValue);
		ServletOutputStream out = response.getOutputStream();
		FileInputStream fin = new FileInputStream(file);
		BufferedInputStream bin = new BufferedInputStream(fin);
		BufferedOutputStream bout = new BufferedOutputStream(out);
		String st = Base64.getEncoder().encodeToString(bill.getFileBill().getData());
		byte[] decode1 = Base64.getDecoder().decode(st);
		out.write(decode1);
		
		return ResponseEntity.ok() .header(HttpHeaders.CONTENT_DISPOSITION,
				  "attachment; filename=\"" + bill.getFileName() + "\"")
				  .body(bill.getData());
	}
	@RequestMapping("/exportExcel")
	public void exportToExcel(HttpServletResponse response) throws IOException {
		response.setContentType("application/octet-stream");
		DateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd_HH:mm:ss");
		String currentDateTime = dateFormatter.format(new Date());

		String headerKey = "Content-Disposition";
		String headerValue = "attachment; filename=Accessory" + currentDateTime + ".xlsx";

		response.setHeader(headerKey, headerValue);

		List<AccessoryDTO> accessoryDTOs = accessoryService.getAccessoryList();
		AccessoryExcelExporter excelExporter = new AccessoryExcelExporter(accessoryDTOs);
		System.out.println("excelExporter<><><><><><<>  " + excelExporter);
		excelExporter.export(response);
		// return ResponseEntity.ok().body(excelExporter);
	}
	@RequestMapping(value = "/importExcel",method = RequestMethod.POST)
	  public ModelAndView uploadFile(@RequestParam("excelFile") MultipartFile file) {
		ModelAndView modelAndView= new ModelAndView();
		System.out.println("------------------file-----------------  " +file.getOriginalFilename());
	    accessoryService.saveExcelData(file);
	    System.out.println("saved successfully--------------------");
	    modelAndView.addObject("saved", "save/update");
		modelAndView.setViewName("redirect:/accessory/");
		return modelAndView;
	  }
}
