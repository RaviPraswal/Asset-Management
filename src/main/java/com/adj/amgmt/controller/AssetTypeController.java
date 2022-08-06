package com.adj.amgmt.controller;

import java.util.ArrayList;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.adj.amgmt.dto.AssetDTO;
import com.adj.amgmt.dto.AssetTypeDTO;
import com.adj.amgmt.entity.AssetTypes;
import com.adj.amgmt.service.AssetTypesServiceImpl;
import com.adj.amgmt.service.AssetsServiceImpl;

@Controller
@RequestMapping("/asset_type")
public class AssetTypeController {

	@Autowired
	AssetTypesServiceImpl assetTypesService;

	@Autowired
	AssetsServiceImpl assetsService;

	// controller to show asset type page
	@RequestMapping("/")
	public ModelAndView listView() {
		ModelAndView modelAndView = new ModelAndView();
		try {
			List<AssetTypeDTO> assetTypeListDTO = assetTypesService.getAssetTypeList();
			modelAndView.addObject("assetTypeList", assetTypeListDTO);
			modelAndView.setViewName("assetTypeView");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return modelAndView;
	}

	// controller to open save and update form
	@RequestMapping("/save_update_view")
	public ModelAndView saveAssetTypeView() {
		ModelAndView modelAndView = new ModelAndView();
		try {
			List<AssetTypeDTO> assetTypeListDTO = assetTypesService.getAssetTypeList();
			List<String> parentTypes = assetTypesService.getParentTypes(assetTypeListDTO);
			modelAndView.addObject("parentTypeList", parentTypes);
			modelAndView.addObject("assetType", new AssetTypes());
			modelAndView.setViewName("saveUpdateAssetType");
		} catch (Exception e) {

			e.printStackTrace();
		}
		return modelAndView;
	}

	// controller to save asset type
	@RequestMapping(value = "/save_asset_type", method = RequestMethod.POST)
	public ModelAndView saveAssetType(@Valid @ModelAttribute("assetType") AssetTypeDTO assetTypeDTO, Errors errors) {
		ModelAndView modelAndView = new ModelAndView();
		try {
			if (errors.hasErrors()) {
				modelAndView.setViewName("saveUpdateAssetType");
			} else {
				assetTypesService.saveAssetType(assetTypeDTO);
				modelAndView.addObject("saved", "save/update");
				modelAndView.setViewName("redirect:/asset_type/");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return modelAndView;
	}

	// controller to delete asset type
	@RequestMapping("/delete_asset_type")
	public ModelAndView deleteAssetTypeById(@RequestParam int id) {
		ModelAndView modelAndView = new ModelAndView();
		List<AssetDTO> assetList = assetsService.getAssetList();

		for (AssetDTO assetDTO : assetList) {
			int assetId = assetDTO.getAssetType().getId();
			if (assetId == id) {
				modelAndView.addObject("existId", "This asset-type already assigned.");
				modelAndView.setViewName("assetError");
			} else {
				modelAndView.addObject("deleted", "delete");
				modelAndView.setViewName("redirect:/asset_type/");
			}
		}
		return modelAndView;
	}

	// controller is used to forward the data to edit form
	@RequestMapping("/open_update_form")
	public ModelAndView openUpdateform(@RequestParam("assetTypeId") int assetTypeId) {
		ModelAndView modelAndView = new ModelAndView("assetType");
		try {
			AssetTypeDTO assetTypeDTO = assetTypesService.getAssetTypeById(assetTypeId);
			List<AssetTypeDTO> assetTypeListDTO = assetTypesService.getAssetTypeList();
			List<String> parentTypes = assetTypesService.getParentTypes(assetTypeListDTO);
			modelAndView.addObject("parentTypeList", parentTypes);
			modelAndView.addObject("assetType", assetTypeDTO);
			modelAndView.setViewName("saveUpdateAssetType");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return modelAndView;
	}

}
