package SPP.admin.web;

import java.util.ArrayList;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
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
		
		ArrayList<MemberVO> memArr = (ArrayList<MemberVO>) adminService.selectConfirmMember();
		
		mav.addObject("memberList", memArr);
		mav.setViewName("adminPage");
		return mav;
	}
	
}
