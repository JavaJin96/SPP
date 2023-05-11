package SPP.dc.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import SPP.dc.FileVO;

@Service
public class DcService {
	
	
	public ArrayList<FileVO> fileSelect(){
		String filePath = "C:/Users/park/git/SPP/SPP/src/main/download";
		File file = new File(filePath);
		File fileArr [] = file.listFiles();
		ArrayList<FileVO> fileVoList = new ArrayList<FileVO>();
		for(int i = 0; i < fileArr.length; i++) {
			FileVO fvo = new FileVO();
			fvo.setFileName(fileArr[i].getName());
			fvo.setFileSize(fileSizeTransfer(fileArr[i].length()));
			fileVoList.add(fvo);
		}
		return fileVoList;
	}
	
	public boolean fileUpload(MultipartHttpServletRequest mre, HttpServletRequest req) {
		
		MultipartFile mf = mre.getFile("file1");
		String filePath = "C:/Users/park/git/SPP/SPP/src/main/download/";
		File file = new File(filePath+mf.getOriginalFilename());
		System.out.println(filePath+mf.getOriginalFilename());
		try {
			mf.transferTo(file);
		} catch (IllegalStateException e) {
			e.printStackTrace();
			return false;
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
	
	public void fileDownload(String fileName, HttpServletResponse resp) throws IOException {
		String path = "C:/Users/park/git/SPP/SPP/src/main/download/";
		String filePath = path + fileName;
		File file = new File(filePath);
		try {
			FileInputStream fis = new FileInputStream(file);
			ServletOutputStream sos = resp.getOutputStream();
			int eof = 0;
			byte [] byteArr = new byte[1024];
			try {
				while((eof = fis.read(byteArr)) != -1) {
					sos.write(byteArr);
				}
				sos.flush();
				
			} catch (IOException e) {
				e.printStackTrace();
			}
			fis.close();
			sos.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	public String fileDelete(String fileName) {
		String path = "C:/Users/park/git/SPP/SPP/src/main/download/";
		String filePath = path + fileName;
		File file = new File(filePath);
		
		boolean res = file.delete();
		
		if(res) return "success";
		return "false";
	}
	
	public String fileSizeTransfer(long fileSize) {
		String res = "";
		if(fileSize > 1024) {
			long kb = fileSize / 1024;
			if(kb > 1024) {
				long mb = kb / 1024;
				if(mb > 1024) {
					long gb = mb / 1024;
					res = gb+"GB";
				}else {
					res = String.valueOf(mb+"MB");
				}
			}else {
				res = String.valueOf(kb+"KB");
			}
		}else {
			res = String.valueOf(fileSize+"byte");
		}
		return res;
	}
	
}
