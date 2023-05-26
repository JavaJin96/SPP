
package SPP.post.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import SPP.dc.FileVO;
import SPP.post.PostVO;
import SPP.post.service.impl.PostDAO;

@Service("postService")
public class PostService {
	
	@Resource(name="postDAO")
	PostDAO postDao;
	
	public List<?> selectAllPost(PostVO pvo){
		return postDao.selectAllPost(pvo);
	}
	
	public int selectAllPostCnt(PostVO pvo) {
		return postDao.selectAllPostCnt(pvo);
	}
	
	public PostVO selectPost(PostVO pvo) {
		return postDao.selectPost(pvo);
	}
	
	public void updatePost(PostVO pvo) {
		postDao.updatePost(pvo);
	}
	
	public void insertPost(PostVO pvo) {
		postDao.insertPost(pvo);
	}
	
	public void deletePost(PostVO pvo) {
		postDao.deletePost(pvo);
	}
	
	public List<?> selectPostMenu() {
		return postDao.selectPostMenu();
	}
	
	public void insertPostMenu(PostVO pvo) {
		postDao.insertPostMenu(pvo);
	}
	
	public void updatePostMenu(PostVO pvo) {
		postDao.updatePostMenu(pvo);
	}
	
	public void deletePostMenu(PostVO pvo) {
		postDao.deletePostMenu(pvo);
	}
	
	public void deletePostMenuInPost(PostVO pvo) {
		postDao.deletePostMenuInPost(pvo);
	}
	
	public void deleteMimgFile(PostVO pvo) {
		postDao.deleteMimgFile(pvo);
	}
	
	public void deleteAttFile(PostVO pvo) {
		postDao.deleteAttFile(pvo);
	}
	
	/* File I/O 관련 Service 로직 */
	public ArrayList<FileVO> fileSelect(){
		//String filePath = "C:/Users/park/git/SPP/SPP/src/main/postFile";
		String filePath = "/var/lib/tomcat9/webapps/SPP/postFile";
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
	
	public String fileUpload(MultipartHttpServletRequest mre, HttpServletRequest req, String fileType) {
		
		MultipartFile mf = mre.getFile(fileType);
		
		String filePath = "";
		if(fileType.equals("attFile")) {
			//filePath = "C:/Users/park/git/SPP/SPP/src/main/webapp/postFile/";
			filePath = "/var/lib/tomcat9/webapps/SPP/postFile/";
		}else if(fileType.equals("mImg")) {
			//filePath = "C:/Users/park/git/SPP/SPP/src/main/webapp/postImg/";
			filePath = "/var/lib/tomcat9/webapps/SPP/postImg/";
		}
		
		File file = new File(filePath+mf.getOriginalFilename());
		System.out.println(filePath+mf.getOriginalFilename());
		try {
			mf.transferTo(file);
		} catch (IllegalStateException e) {
			e.printStackTrace();
			return null;
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}
		
		return mf.getOriginalFilename();
	}
	
	public void fileDownload(String fileName, String fileType, HttpServletResponse resp) throws IOException {
		String path = "";
		if(fileType.equals("postFile")) {
			//path = "C:/Users/park/git/SPP/SPP/src/main/webapp/postFile/";
			path = "/var/lib/tomcat9/webapps/SPP/postFile/";
		}else if(fileType.equals("postImg")) {
			//path = "C:/Users/park/git/SPP/SPP/src/main/webapp/postImg/";
			path = "/var/lib/tomcat9/webapps/SPP/postImg/";
		}
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
	
	public String fileDelete(String fileName, String fileType) {
		String path = "";
		if(fileType.equals("postImg")) {
			//path = "C:/Users/park/git/SPP/SPP/src/main/webapp/postImg/";
			path = "/var/lib/tomcat9/webapps/SPP/postImg/";
		}else if(fileType.equals("postFile")) {
			//path = "C:/Users/park/git/SPP/SPP/src/main/webapp/postFile/";
			path = "/var/lib/tomcat9/webapps/SPP/postFile/";
		}
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
