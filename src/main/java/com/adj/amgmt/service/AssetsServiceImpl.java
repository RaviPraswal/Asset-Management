package com.adj.amgmt.service;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import org.bson.BsonBinarySubType;
import org.bson.types.Binary;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
//import org.springframework.mock.web.MockMultipartFile;
import org.springframework.web.multipart.MultipartFile;

import com.adj.amgmt.dto.AssetDTO;
import com.adj.amgmt.dto.AssetExcelImporter;
import com.adj.amgmt.entity.Asset;
import com.adj.amgmt.entity.AssetTypes;
import com.adj.amgmt.entity.Bill;
import com.adj.amgmt.repository.AssetRepository;
import com.adj.amgmt.repository.AssetTypeRepository;
import com.adj.amgmt.repository.BillRepository;

import lombok.Getter;
import lombok.Setter;

@Service
@Getter
@Setter
public class AssetsServiceImpl implements AssetService {

	@Autowired
	AssetRepository assetsRepository;

	@Autowired
	AssetTypeRepository assetTypeRepository;

	@Autowired
	AssetAssignmentService assetAssignmentService;

	@Autowired
	BillRepository billRepo;

	@Autowired
	ModelMapper modelMapper;

	// method to load all asset type from db to add asset page
	// we have to load asset type using asset type repository
	public List<AssetTypes> loadAssetTypes() {
		try {
			return assetTypeRepository.findAll();
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;

	}

	// method to save an asset
	public void save(AssetDTO assetDTO) {
		Bill bill = new Bill();
		String fileName = "";
		try {
			Asset asset = modelMapper.map(assetDTO, Asset.class);
			fileName = asset.getFile().getOriginalFilename();
			asset.setFileName(fileName);

			bill.setFileName(fileName);
			bill.setFileBill(new Binary(BsonBinarySubType.BINARY, asset.getFile().getBytes()));
			Bill billFile = billRepo.insert(bill);
			asset.setBillFileId(billFile.getId());
			assetsRepository.saveAndFlush(asset);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// method to delete an asset
	public void deleteAssetById(int id) {
		assetsRepository.deleteById(id);

	}

	// method to update an asset
	public void updateAsset(Asset asset) {
		try {
			assetsRepository.saveAndFlush(asset);
		} catch (Exception e) {
			// TODO: handle exception
		}

	}

	// method to get asset list
	public List<AssetDTO> getAssetList() {
		try {
			List<Asset> assetList = assetsRepository.findAll();
			List<AssetDTO> assetListDTO = Arrays.asList(modelMapper.map(assetList, AssetDTO[].class));
			getParentAssetList(assetListDTO);
			return assetListDTO;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;

	}

	public List<String> getParentAssetList(List<AssetDTO> assetListDTO) {
		List<String> parentAssetList = new ArrayList<String>();
		for (AssetDTO assetDTO : assetListDTO) {
			String name = assetDTO.getName();
			parentAssetList.add(name);
		}
	return parentAssetList;	
	}

	// method to get an asset by id
	public AssetDTO getAssetById(int assetId) {
		Asset assetById = assetsRepository.getById(assetId);
		AssetDTO assetDTO = modelMapper.map(assetById, AssetDTO.class);
		
		//assetDTO.setBillFileName(assetById.getFileName());
		try {
			assetDTO.setBillFileName(assetById.getFileName());
			Optional<Bill> billById = billRepo.findById(assetById.getBillFileId());
			//System.out.println(">>>>-----inside service---------->>>>>>"+ billById.get().getFileBill()/* .getData().toString() );
			Binary document = billById.get().getFileBill();
			// method 2
			if (document != null) {
				FileOutputStream fileOuputStream = null;
				try {
					fileOuputStream = new FileOutputStream(assetById.getFileName());
					fileOuputStream.write(document.getData());
					System.out.println("===--==--==--==--==-->"+fileOuputStream.toString());//fos object
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

			// at this line i have to set the file in the format of Multipart file
			assetDTO.setFile(null);
			return assetDTO;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return assetDTO;
	}
	//method to get data excel from database	
	public void saveExcelData(MultipartFile file) {
	    try {
	      List<Asset> assetList = AssetExcelImporter.excelToAssets(file.getInputStream());
	      System.out.println("assets service-----------------  " +assetList);
	      //List<AssetDTO> assetListDTO = Arrays.asList(modelMapper.map(assetList, AssetDTO[].class));
	      assetsRepository.saveAll(assetList);
	    } catch (IOException e) {
	      throw new RuntimeException("fail to store excel data: " + e.getMessage());
	    }
	  }

	
}
