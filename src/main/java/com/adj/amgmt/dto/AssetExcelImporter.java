package com.adj.amgmt.dto;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;

import com.adj.amgmt.entity.Asset;

public class AssetExcelImporter {
	public static String TYPE = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
	static String[] HEADERs = {"skuNumber", "name","Description","model","Purchase Date","Waranty","cost, vendor", "billNo","bill-document"};
	static String SHEET = "AssetData";

	public static boolean hasExcelFormat(MultipartFile file) {
		if (!TYPE.equals(file.getContentType())) {
			return false;
		}
		return true;
	}

	public static List<Asset> excelToAssets(InputStream is) throws IOException {
		try {
			Workbook workbook = new XSSFWorkbook(is);
			Sheet sheet = workbook.getSheet(SHEET);
			Iterator<Row> rows = sheet.iterator();
			List<Asset> assetList = new ArrayList<Asset>();
			int rowNumber = 0;
			while (rows.hasNext()) {
				Row currentRow = rows.next();
				// skip header
				if (rowNumber == 0) {
					rowNumber++;
					continue;
				}
				Iterator<Cell> cellsInRow = currentRow.iterator();
				Asset asset = new Asset();
				int cellIdx = 0;
				while (cellsInRow.hasNext()) {
					Cell currentCell = cellsInRow.next();
					switch (cellIdx) {
					case 0:
						asset.setSkuNumber(currentCell.getStringCellValue());
						break;
					case 1:
						asset.setName(currentCell.getStringCellValue());
						break;
					case 2:
						asset.setDescription(currentCell.getStringCellValue());
						break;	
					case 3:
						asset.setModel(currentCell.getStringCellValue());
						break;
					case 4:
						asset.setPurchaseDate(currentCell.getStringCellValue());
						break;
					case 5:
						asset.setWaranty(currentCell.getStringCellValue());
						break;
					case 6:
						double cost=currentCell.getNumericCellValue();
						asset.setCost(cost);
						break;
					case 7:
						asset.setVendor(currentCell.getStringCellValue());
						break;
					case 8:
						asset.setBillNo(currentCell.getStringCellValue());
						break;
					case 9:
						asset.setFileName(currentCell.getStringCellValue());
						break;

					default:
						break;
					}
					cellIdx++;					
				}
				assetList.add(asset);
				workbook.close();
			}
			return assetList;
		} catch (IOException e) {
			throw new RuntimeException("fail to parse Excel file: " + e.getMessage());

		}
	}

}
