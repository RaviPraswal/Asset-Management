package com.adj.amgmt.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.adj.amgmt.dto.AccessoryDTO;
import com.adj.amgmt.dto.AccessoryTypesDTO;
import com.adj.amgmt.service.AccessoryService;
import com.adj.amgmt.service.AccessoryTypesServiceImpl;

@Controller
@RequestMapping("/accessory_type")
public class AccessoryTypeController {

	@Autowired
	AccessoryTypesServiceImpl accessoryTypesService;
	
	@Autowired
	AccessoryService accessoryService;

	// controller to show accessory type page
	@RequestMapping("/")
	public ModelAndView listView() {
		ModelAndView modelAndView = new ModelAndView();
		try {
			List<AccessoryTypesDTO> accessoryTypeListDTO = accessoryTypesService.getAccessoryTypeList();
			modelAndView.addObject("accessoryTypeList", accessoryTypeListDTO);
			modelAndView.setViewName("accessoryTypeView");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return modelAndView;
	}

	// controller to open save and update form
	@RequestMapping("/save_update_view")
	public ModelAndView saveView() {
		ModelAndView modelAndView = new ModelAndView();
		try {
			List<AccessoryTypesDTO> accessoryTypeListDTO = accessoryTypesService.getAccessoryTypeList();
			List<String> parentTypes = accessoryTypesService.getParentTypes(accessoryTypeListDTO);
			modelAndView.addObject("parentTypeList", parentTypes);
			modelAndView.addObject("accessoryType", new AccessoryTypesDTO());
			modelAndView.setViewName("saveUpdateAccessoryType");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return modelAndView;
	}

	// controller to save accessory type
	@RequestMapping(value = "/save_accessory_type")
	public ModelAndView saveAccessoryType(@Valid @ModelAttribute("accessoryType") AccessoryTypesDTO accessoryTypeDTO,
			Errors errors) {
		ModelAndView modelAndView = new ModelAndView();
		if (errors.hasErrors()) {
			modelAndView.setViewName("saveUpdateAccessoryType");
		} else {
			accessoryTypesService.saveAccessoryType(accessoryTypeDTO);
			modelAndView.addObject("saved", "save/update");
			modelAndView.setViewName("redirect:/accessory_type/");
		}
		return modelAndView;
	}

	// controller to open update form for accessory type
	@RequestMapping("/open_update_form")
	public ModelAndView openUpdateform(@RequestParam("accessoryTypeId") int accessoryTypeId) {
		ModelAndView modelAndView = new ModelAndView("accessoryType");
		AccessoryTypesDTO accessoryTypeDTO = accessoryTypesService.getAccessoryTypeId(accessoryTypeId);

		List<AccessoryTypesDTO> accessoryTypeListDTO = accessoryTypesService.getAccessoryTypeList();
		List<String> parentTypes = accessoryTypesService.getParentTypes(accessoryTypeListDTO);
		modelAndView.addObject("parentTypeList", parentTypes);

		modelAndView.addObject("accessoryType", accessoryTypeDTO);
		modelAndView.setViewName("saveUpdateAccessoryType");
		return modelAndView;
	}

	// controller to delete accessory type
	@RequestMapping("/delete_accessory_type")
	public ModelAndView deleteById(@RequestParam int id) {
		ModelAndView modelAndView = new ModelAndView();
		try {
			List<AccessoryDTO> accessoryList = accessoryService.getAccessoryList();
			for (AccessoryDTO accessoryDTO : accessoryList) {
				if (accessoryDTO.getAccessoryType().getId() == id) {
					modelAndView.addObject("existId", "This Accessory Already Assigned.");
					modelAndView.setViewName("errorId");
					return modelAndView;
				} else {
					accessoryTypesService.deleteAccessoryTypeById(id);
					modelAndView.addObject("delete", "deleted");
					modelAndView.setViewName("redirect:/accessory_type/");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return modelAndView;
	}

}
