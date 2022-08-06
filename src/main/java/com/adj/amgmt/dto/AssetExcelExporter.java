package com.adj.amgmt.dto;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class AssetExcelExporter {
	private XSSFWorkbook workbook;
    private XSSFSheet sheet;
	private List<AssetDTO> assetList;
	
	public AssetExcelExporter(List<AssetDTO> assetList) {
		this.assetList = assetList;
		workbook= new XSSFWorkbook();
	}
	private void writeHeaderLine() {
		sheet = workbook.createSheet("Assets");
		Row row = sheet.createRow(0);
		 CellStyle style = workbook.createCellStyle();
		 System.out.println("after cell style    ");
	        XSSFFont font = workbook.createFont();
	        System.out.println("after font   ");
	        font.setBold(true);
	        font.setFontHeight(14);
	        style.setFont(font);
	         
	        createCell(row, 0, "#", style);      
	        createCell(row, 1, "Sku number", style);       
	        createCell(row, 2, "Name", style);
	        createCell(row, 3, "Description", style);
	        createCell(row, 4, "Model", style);    
	        createCell(row, 5, "Purchase Date", style);
	        createCell(row, 6, "Waranty Date", style);
	        createCell(row, 7, "Cost", style);
	        createCell(row, 8, "Vendor", style);
	        createCell(row, 9, "Bill-Number", style);
	        createCell(row, 10, "Bill-Document", style);
		
	}
	 private void createCell(Row row, int columnCount, Object value, CellStyle style) {
	        sheet.autoSizeColumn(columnCount);
	        Cell cell = row.createCell(columnCount);
	        if (value instanceof Integer) {
	            cell.setCellValue((Integer) value);
	        } else if (value instanceof Boolean) {
	            cell.setCellValue((Boolean) value);
	        }else {
	            cell.setCellValue((String) value);
	        }
	        cell.setCellStyle(style);
	    }
	private void writeDataLine() throws IOException {
		int rowCount = 1;
		 
        CellStyle style = workbook.createCellStyle();
        XSSFFont font = workbook.createFont();
        font.setFontHeight(14);
        style.setFont(font);
                 
        for (AssetDTO assetDTO : assetList) {		
        	System.out.println("exporter   " +assetDTO.getName());
            Row row = sheet.createRow(rowCount++);
            int columnCount = 0;
             
            createCell(row, columnCount++, assetDTO.getId(), style);
            createCell(row, columnCount++, assetDTO.getSkuNumber(), style);
            createCell(row, columnCount++, assetDTO.getName(), style);
            createCell(row, columnCount++, assetDTO.getDescription(), style);
            createCell(row, columnCount++, assetDTO.getModel(), style);
            createCell(row, columnCount++, assetDTO.getPurchaseDate(), style);
            createCell(row, columnCount++, assetDTO.getWaranty(), style);
            createCell(row, columnCount++, String.valueOf(assetDTO.getCost()), style);
            createCell(row, columnCount++, assetDTO.getVendor(), style);
            createCell(row, columnCount++, assetDTO.getBillNo(), style);
            createCell(row, columnCount++, assetDTO.getFile(), style);
             
        }
	}
	public void export(HttpServletResponse response) throws IOException {
		System.out.println("export classsssssss");
		writeHeaderLine();
		writeDataLine();
		
		ServletOutputStream outputStream = response.getOutputStream();
		workbook.write(outputStream);
		workbook.close();
		
		outputStream.close();
	}

}
