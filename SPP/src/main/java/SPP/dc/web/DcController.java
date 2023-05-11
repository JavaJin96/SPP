package SPP.dc.web;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import SPP.dc.FileVO;
import SPP.dc.service.DcService;

@Controller
public class DcController {
	
	DcService dcService = new DcService();
	
	@RequestMapping("dc/main.do")
	public ModelAndView goMain() {
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("fileVoList", dcService.fileSelect());
		mav.setViewName("dcPage");
		
		return mav;
	}
	
	@PostMapping("dc/fileUpload.do")
	public ModelAndView fileUpload(MultipartHttpServletRequest mre, HttpServletRequest req) {
		
		ModelAndView mav = new ModelAndView();
		
		if(mre.getFile("file1").getSize() == 0) {
			mav.setViewName("redirect:/dc/main.do");
			return mav;
		}else {
			if(dcService.fileUpload(mre, req)) {
				mav.setViewName("redirect:/dc/main.do");
				return mav;
			}else {
				mav.setViewName("error");
				return mav;
			}
		}
		
	}
	
	@RequestMapping("dc/fileDownload.do")
	public void fileDownload(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String fileName = req.getParameter("fileName");
		resp.setContentType("application/octet-stream; charset=utf-8");
		resp.setHeader("Content-Disposition", "attachment; filename=" + fileName);
		resp.setHeader("Content-Transfer-Encoding", "binary");
		dcService.fileDownload(fileName, resp);
	}
	
	@RequestMapping("dc/fileDelete.do")
	public ModelAndView fileDelete(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		String fileName = req.getParameter("fileName");
		
		String res = dcService.fileDelete(fileName);
		
		mav.setViewName("redirect:/dc/main.do");
		mav.addObject("message", res);
		return mav;
	}
	
}
