package com.adj.amgmt.service;

import java.util.List;

import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.adj.amgmt.dto.AssetAssignmentDTO;
import com.adj.amgmt.entity.AssetAssignment;
import com.adj.amgmt.repository.AssetAssignmentRepository;

import lombok.Getter;
import lombok.Setter;

@Service
@Getter
@Setter
public class AssetAssignmentServiceImpl implements AssetAssignmentService {

	@Autowired
	AssetAssignmentRepository assetAssignmentRepository;

	@Autowired
	ModelMapper modelMapper;

	public List<AssetAssignmentDTO> getAssetAssignmentList() {
		try {
			List<AssetAssignment> assetAssignmentList = assetAssignmentRepository.findAll();
			List<AssetAssignmentDTO> assetAssignmentListDTO = modelMapper.map(assetAssignmentList,
					((TypeToken<List<AssetAssignmentDTO>>) new TypeToken<List<AssetAssignmentDTO>>() {
					}).getType());

			return assetAssignmentListDTO;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public void saveAssetAssignment(AssetAssignmentDTO assetAssignmentDTO) {
		try {
			// here we are setting the status by checking that issueDate is empty or not
			if (!assetAssignmentDTO.getIssueDate().isEmpty()) {
				assetAssignmentDTO.setStatus("Assigned");
				if (!assetAssignmentDTO.getIssueDate().isEmpty() && !assetAssignmentDTO.getReturnDate().isEmpty()) {
					assetAssignmentDTO.setStatus("Returned");
				}
			}
			AssetAssignment assetAssignment = modelMapper.map(assetAssignmentDTO, AssetAssignment.class);
			assetAssignmentRepository.saveAndFlush(assetAssignment);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void deleteAssetAssignmentById(int id) {
		try {
			assetAssignmentRepository.deleteById(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public AssetAssignmentDTO getAssetAssignmentById(int assetAssignmentId) {
		try {
			AssetAssignment assetAssignmentById = assetAssignmentRepository.getById(assetAssignmentId);
			AssetAssignmentDTO assetAssignmentDTO = modelMapper.map(assetAssignmentById, AssetAssignmentDTO.class);
			return assetAssignmentDTO;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public void updateAssetAssignment(AssetAssignment assetAssignment) {
		try {
			assetAssignmentRepository.saveAndFlush(assetAssignment);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
