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
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.adj.amgmt.dto.AssetAssignmentDTO;
import com.adj.amgmt.dto.AssetDTO;
import com.adj.amgmt.dto.AssetExcelExporter;
import com.adj.amgmt.dto.AssetTypeDTO;
import com.adj.amgmt.entity.Bill;
import com.adj.amgmt.service.AssetAssignmentService;
import com.adj.amgmt.service.AssetTypesServiceImpl;
import com.adj.amgmt.service.AssetsServiceImpl;
import com.adj.amgmt.service.BillServiceImpl;

@Controller
@RequestMapping("/asset")
public class AssetController {

	private static final String contentType = null;

	@Autowired
	AssetsServiceImpl assetsService;

	@Autowired
	AssetTypesServiceImpl assetTypesService;

	@Autowired
	BillServiceImpl billService;

	@Autowired
	AssetAssignmentService assetAssignmentService;

	// controller to show assets page
	@RequestMapping("/")
	public ModelAndView listView() {
		ModelAndView modelAndView = new ModelAndView();
		try {
			List<AssetDTO> assetListDTO = assetsService.getAssetList();
			modelAndView.addObject("assetList", assetListDTO);
			modelAndView.setViewName("assetsView");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return modelAndView;
	}

	// controller to open save asset view
	@RequestMapping(value = "/open_asset_view")
	public String saveView(Model model) {
		try {
			List<AssetDTO> assetListDTO = assetsService.getAssetList();
			
			// loading parent asset
			List<String> parentAssetList = assetsService.getParentAssetList(assetListDTO);
			model.addAttribute("parentAssetList", parentAssetList);

			// loading asset type
			List<AssetTypeDTO> assetTypeListDTO = assetTypesService.getAssetTypeList();
			if (!model.containsAttribute("assetDTOError")) {
				model.addAttribute("assetDTOError", new AssetDTO());
			}
			model.addAttribute("assetTypeList", assetTypeListDTO);

			//loading asset
			model.addAttribute("asset", new AssetDTO());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "saveUpdateAsset";
	}

	// controller to save asset
	@RequestMapping(value = "/save_update_asset", method = RequestMethod.POST)
	public ModelAndView saveAsset(@Valid @ModelAttribute("asset") AssetDTO assetDTO, Errors errors,
			HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		System.out.println("==>"+assetDTO.getFile().getOriginalFilename());
		if (errors.hasErrors()) {
			List<AssetTypeDTO> assetTypeListDTO = assetTypesService.getAssetTypeList();
			modelAndView.addObject("assetTypeList", assetTypeListDTO);
			modelAndView.setViewName("saveUpdateAsset");

		} else {
			assetsService.save(assetDTO);
			modelAndView.addObject("saved", "save/update");
			modelAndView.setViewName("redirect:/asset/");
		}
		return modelAndView;
	}

	// controller is used to forward the data to edit form
	@RequestMapping("/open_update_form")
	public ModelAndView openUpdateform(@RequestParam("assetId") int assetId) {
		ModelAndView modelAndView = new ModelAndView("asset");
		try {
			AssetDTO assetDTO = assetsService.getAssetById(assetId);
			modelAndView.addObject("asset", assetDTO);
			List<AssetTypeDTO> assetTypeListDTO = assetTypesService.getAssetTypeList();
			modelAndView.addObject("assetTypeList", assetTypeListDTO);
			modelAndView.addObject("billFileName", assetDTO.getBillFileName());
			modelAndView.setViewName("saveUpdateAsset");
		} catch (Exception e) {
			// TODO: handle exception
		}
		return modelAndView;
	}

	// controller to delete asset
	@RequestMapping("/delete_asset")
	public ModelAndView deleteById(@RequestParam int id) {
		ModelAndView modelAndView = new ModelAndView();
		try {
			List<AssetAssignmentDTO> assetAssignmentList = assetAssignmentService.getAssetAssignmentList();
			for (AssetAssignmentDTO assetAssignmentDTO : assetAssignmentList) {
				AssetDTO asset = assetAssignmentDTO.getAsset();
				if (id==asset.getId()) {
					modelAndView.addObject("existId", "This asset already assigned.");
					modelAndView.setViewName("assetError");
				} else {
					assetsService.deleteAssetById(id);
					modelAndView.addObject("deleted", "delete");
					modelAndView.setViewName("redirect:/asset/");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return modelAndView;
	}

	@RequestMapping("/bill_download/{id}")
	public ResponseEntity getFile(@PathVariable String id, HttpServletResponse response) throws IOException {

		// store in directory file codse here..
		Bill bill = billService.getFile(id);
		String stringfile = "D:/asset-mgmt-files" + bill.getFileName();
		String s = Base64.getEncoder().encodeToString(bill.getFileBill().getData());
		byte[] decode = Base64.getDecoder().decode(s);
		Files.write(Paths.get(stringfile), decode);

		// download code here...
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
		return ResponseEntity.ok().body(bill.getData());
	}

	@RequestMapping("/exportExcel")
	public void exportToExcel(HttpServletResponse response) throws IOException {
		response.setContentType("application/octet-stream");
		DateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd_HH:mm:ss");
		String currentDateTime = dateFormatter.format(new Date());

		String headerKey = "Content-Disposition";
		String headerValue = "attachment; filename=Assets" + currentDateTime + ".xlsx";

		response.setHeader(headerKey, headerValue);

		List<AssetDTO> assetList = assetsService.getAssetList();
		AssetExcelExporter excelExporter = new AssetExcelExporter(assetList);
		System.out.println("excelExporter<><><><><><<>  " + excelExporter);
		excelExporter.export(response);
		// return ResponseEntity.ok().body(excelExporter);
	}

	

	@RequestMapping(value = "/importExcel",method = RequestMethod.POST)
	  public ModelAndView uploadFile(@RequestParam("excelFile") MultipartFile file) {
	    //String message = "";
		ModelAndView modelAndView= new ModelAndView();
		System.out.println("------------------file-----------------  " +file.getOriginalFilename());
	    assetsService.saveExcelData(file);
	    System.out.println("saved successfully--------------------");
	    modelAndView.addObject("saved", "save/update");
		modelAndView.setViewName("redirect:/asset/");
		return modelAndView;
	  }
	
	

}
