package SPP.admin.web;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import SPP.admin.service.AdminService;
import SPP.main.MemberVO;
import SPP.post.PostVO;
import SPP.post.service.PostService;

@Controller
public class AdminController {

	@Resource(name = "adminService")
	AdminService adminService;
	
	@Resource(name= "postService")
	PostService postService;
	
	@RequestMapping("admin/adminMain.do")
	public ModelAndView goMain() {
		ModelAndView mav = new ModelAndView();
		
		ArrayList<MemberVO> joinMemArr = (ArrayList<MemberVO>) adminService.selectConfirmMember();
		ArrayList<MemberVO> authMemArr = (ArrayList<MemberVO>) adminService.selectAuthMember();
		List<PostVO> menuList = (List<PostVO>) postService.selectPostMenu();
		
		mav.addObject("menuList", menuList);
		mav.addObject("joinMemberList", joinMemArr);
		mav.addObject("authMemberList", authMemArr);
		mav.setViewName("adminPage");
		return mav;
	}
	
	@RequestMapping("admin/authManagement.do")
	public ModelAndView memberAuthManagement(HttpServletRequest req, @ModelAttribute("authManageMemeber") MemberVO mvo) {
		ModelAndView mav = new ModelAndView();
		
		adminService.confirmMember(mvo);
		
		mav.setViewName("redirect:/admin/adminMain.do");
		return mav;
	}
	
	@RequestMapping("admin/confrimMember.do")
	public ModelAndView confrimMember(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		
		MemberVO tempMvo = new MemberVO();
		tempMvo.setMemId(req.getParameter("memId"));
		tempMvo.setMemAuth("1");
		adminService.confirmMember(tempMvo);
		
		mav.setViewName("redirect:/admin/adminMain.do");
		return mav;
	}
	
	@RequestMapping("admin/deleteMember.do")
	public ModelAndView deleteMember(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		
		MemberVO tempMvo = new MemberVO();
		tempMvo.setMemId(req.getParameter("memId"));
		adminService.deleteMember(tempMvo);
		
		mav.setViewName("redirect:/admin/adminMain.do");
		return mav;
	}
	
	@RequestMapping("admin/updateMenu.do")
	public ModelAndView menuManageMent(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		
		PostVO pvo = new PostVO();
		pvo.setPoTypeCode(req.getParameter("code"));
		pvo.setPoTypeName(req.getParameter("name"));
		postService.updatePostMenu(pvo);
		mav.setViewName("redirect:/admin/adminMain.do");
		return mav;
	}
	
	@RequestMapping("admin/deleteMenu.do")
	public ModelAndView menuManageMentDelete(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		
		PostVO pvo = new PostVO();
		pvo.setPoTypeCode(req.getParameter("code"));
		pvo.setPoTypeName(req.getParameter("name"));
		postService.deletePostMenuInPost(pvo);
		postService.deletePostMenu(pvo);
		
		mav.setViewName("redirect:/admin/adminMain.do");
		return mav;
	}
	
	@RequestMapping("admin/insertMenu.do")
	public ModelAndView insertMenu(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		
		PostVO pvo = new PostVO();
		pvo.setPoTypeCode(req.getParameter("code"));
		pvo.setPoTypeName(req.getParameter("name"));
		postService.insertPostMenu(pvo);
		
		mav.setViewName("redirect:/admin/adminMain.do");
		return mav;
	}
}
