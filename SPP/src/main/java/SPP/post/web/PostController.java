package SPP.post.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
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
		
		mav.addObject("resPvo", resPvo);
		mav.setViewName("");
		return mav;
	}
	
	@RequestMapping("post/postForm.do")
	public ModelAndView postForm(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		PostVO pvo = new PostVO();
		
		mav.addObject("pvp", pvo);
		mav.setViewName("");
		return mav;
	}
	
}
