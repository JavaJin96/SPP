package SPP.admin.web;

import java.util.ArrayList;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import SPP.admin.service.AdminService;
import SPP.main.MemberVO;

@Controller
public class AdminController {

	@Resource(name = "adminService")
	AdminService adminService;
	
	@RequestMapping("admin/adminMain.do")
	public ModelAndView goMain() {
		ModelAndView mav = new ModelAndView();
		
		ArrayList<MemberVO> joinMemArr = (ArrayList<MemberVO>) adminService.selectConfirmMember();
		ArrayList<MemberVO> authMemArr = (ArrayList<MemberVO>) adminService.selectAuthMember();
		
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
}
