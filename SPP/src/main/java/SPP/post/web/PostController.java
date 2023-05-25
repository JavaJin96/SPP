package SPP.post.web;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import SPP.post.PostVO;
import SPP.post.service.PostService;

@Controller
public class PostController {
	
	@Resource(name = "postService")
	PostService postService;
	
	@RequestMapping("post/main.do")
	public ModelAndView goMain(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		PostVO paramPvo = new PostVO();
		
		String searchType = req.getParameter("searchType");
		String searchCon = req.getParameter("searchCon");
		if(searchType != null && searchCon != null) {
			if(searchType.equals("title")) {
				paramPvo.setPoTitle(searchCon);
			}else if(searchType.equals("content")) {
				paramPvo.setPoContent(searchCon);
			}else {
				paramPvo.setPoBoth(searchCon);
			}
		}
		
		String pageNo = req.getParameter("pageNo");
		if(pageNo == null) pageNo = "1";
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(Integer.parseInt(pageNo));
		paginationInfo.setPageSize(5);
		paginationInfo.setRecordCountPerPage(6);
		
		String poType = req.getParameter("pageType");
		if(poType == null) poType = "1";
		
		paramPvo.setPoType(poType);
		paginationInfo.setTotalRecordCount(postService.selectAllPostCnt(paramPvo));
		
		int startNo = paginationInfo.getFirstRecordIndex();
		int endNo = paginationInfo.getLastRecordIndex();
		paramPvo.setStartNum(startNo+"");
		paramPvo.setEndNum(endNo+"");
		List<PostVO> pList = (List<PostVO>) postService.selectAllPost(paramPvo);
		
		List<PostVO> postMenus = (List<PostVO>) postService.selectPostMenu();
		
		mav.addObject("postList", pList);
		mav.addObject("postMenus", postMenus);
		mav.addObject("paginationInfo", paginationInfo);
		mav.setViewName("postMainPage");
		return mav;
	}
	
	@RequestMapping("post/postDtl.do")
	public ModelAndView postDtl(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		PostVO pvo = new PostVO();
		pvo.setPoNo(req.getParameter("poNo"));
		
		PostVO resPvo = postService.selectPost(pvo);
		List<PostVO> postMenus = (List<PostVO>) postService.selectPostMenu();
		
		mav.addObject("resPvo", resPvo);
		mav.addObject("postMenus", postMenus);
		mav.setViewName("postDtlPage");
		return mav;
	}
	
	@RequestMapping("post/postForm.do")
	public ModelAndView postForm(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		PostVO pvo = new PostVO();
		
		List<PostVO> postMenus = (List<PostVO>) postService.selectPostMenu();
		
		mav.addObject("postMenus", postMenus);
		mav.addObject("pvo", pvo);
		mav.setViewName("postFormPage");
		return mav;
	}
	
	@PostMapping("post/insertPost.do")
	public ModelAndView insertForm(MultipartHttpServletRequest mre, HttpServletRequest req, @ModelAttribute("pvo")PostVO pvo) {
		ModelAndView mav = new ModelAndView();
		
		pvo.setPoWriter("박상진(amor3436)");
		pvo.setPoType(pvo.getPoTypeCode());
		
		if(mre.getFile("attFile").getSize() != 0) {
			String attFilePath = postService.fileUpload(mre, req, "attFile");
			if(attFilePath != null) pvo.setPoAttfile(attFilePath);
		}
		
		if(mre.getFile("mImg").getSize() != 0) {
			String imgFilePath = postService.fileUpload(mre, req, "mImg");
			if(imgFilePath != null) pvo.setPoMimg(imgFilePath);
		}
		
		postService.insertPost(pvo);
		
		mav.setViewName("redirect:/post/main.do");
		return mav;
	}
	
	@RequestMapping("post/postModifyForm.do")
	public ModelAndView postModifyForm(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		PostVO pvo = new PostVO();
		
		pvo.setPoNo(req.getParameter("poNo"));
		PostVO resPvo = postService.selectPost(pvo);
		
		List<PostVO> postMenus = (List<PostVO>) postService.selectPostMenu();
		
		mav.addObject("modiFlag", "modify");
		mav.addObject("postMenus", postMenus);
		mav.addObject("resPvo", resPvo);
		mav.setViewName("postFormPage");
		return mav;
	}
	
	@RequestMapping("post/postUpdate.do")
	public ModelAndView postUpdate(MultipartHttpServletRequest mre, HttpServletRequest req, @ModelAttribute("pvo")PostVO pvo) {
		ModelAndView mav = new ModelAndView();
		
		pvo.setPoWriter("박상진(amor3436)");
		pvo.setPoType(pvo.getPoTypeCode());
		
		String poAttfileFlag = req.getParameter("poAttfileFlag");
		if(poAttfileFlag == null) {
			System.out.println("첨부들어왔어유!");
			if(mre.getFile("attFile").getSize() != 0) {
				String attFilePath = postService.fileUpload(mre, req, "attFile");
				if(attFilePath != null) pvo.setPoAttfile(attFilePath);
			}
		}
		
		String poMimgFlag = req.getParameter("poMimgFlag");
		if(poMimgFlag == null) {
			System.out.println("섬네일들어왔어유!");
			if(mre.getFile("mImg").getSize() != 0) {
				String imgFilePath = postService.fileUpload(mre, req, "mImg");
				if(imgFilePath != null) pvo.setPoMimg(imgFilePath);
			}
		}
		
		postService.updatePost(pvo);
		
		mav.setViewName("redirect:/post/postDtl.do?poNo="+pvo.getPoNo());
		return mav;
	}
	
	@RequestMapping("post/downloadFile.do")
	public void downloadFile(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String fileName = req.getParameter("fileName");
		String fileType = req.getParameter("fileType");
		
		resp.setContentType("application/octet-stream; charset=utf-8");
		resp.setHeader("Content-Disposition", "attachment; filename=" + fileName);
		resp.setHeader("Content-Transfer-Encoding", "binary");
		postService.fileDownload(fileName, fileType, resp);
	}
	
	@RequestMapping("post/deleteFile.do")
	public ModelAndView deleteFile(HttpServletRequest req) throws IOException {
		ModelAndView mav = new ModelAndView();
		PostVO pvo = new PostVO();
		String fileType = req.getParameter("fileType");
		String fileName = req.getParameter("fileName");
		String poNo = req.getParameter("poNo");
		pvo.setPoNo(poNo);
		if(fileType.equals("postImg")) {
			postService.deleteMimgFile(pvo);
			postService.fileDelete(fileName, fileType);
		}else if(fileType.equals("postFile")) {
			postService.deleteAttFile(pvo);
			postService.fileDelete(fileName, fileType);
		}
		mav.setViewName("redirect:/post/postModifyForm.do?poNo="+poNo);
		return mav;
	}
	
}
