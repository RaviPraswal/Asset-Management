package com.adj.amgmt.service;

import java.util.List;

import com.adj.amgmt.dto.AssetAssignmentDTO;
import com.adj.amgmt.entity.AssetAssignment;

public interface AssetAssignmentService {

	List<AssetAssignmentDTO> getAssetAssignmentList();

	void saveAssetAssignment(AssetAssignmentDTO assetAssignmentDTO);

	void deleteAssetAssignmentById(int id);

	AssetAssignmentDTO getAssetAssignmentById(int assetAssignmentId);

	void updateAssetAssignment(AssetAssignment assetAssignment);

}
