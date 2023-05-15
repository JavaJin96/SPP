package SPP.main.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import SPP.main.BoardVO;
import SPP.main.MemberVO;
import SPP.main.service.MainService;

@Controller
public class MainController {
	
	@Resource(name = "mainService")
	MainService mainService;
	
	@RequestMapping("main/main.do")
	public ModelAndView goMain() {
		ModelAndView mav = new ModelAndView();
		
		List<BoardVO> bvoList = (List<BoardVO>) mainService.selectAllBoard();
		
		mav.addObject("bvoList", bvoList);
		mav.setViewName("mainPage");
		return mav;
	}
	
	@PostMapping("main/login.do")
	public ModelAndView login(HttpServletRequest req, HttpServletResponse resp) {
		
		ModelAndView mav = new ModelAndView();
		
		MemberVO loginMember = new MemberVO();
		loginMember.setMemId(req.getParameter("loginId"));
		System.out.println(req.getParameter("loginId"));
		System.out.println(req.getParameter("loginPass"));
		loginMember.setMemPass(req.getParameter("loginPass"));
		
		HttpSession session =  req.getSession();
		
		MemberVO member = mainService.selectLogin(loginMember);
		if(member != null) {
			System.out.println("로그인 성공");
			session.setAttribute("loginMember", member);
		}else {
			System.out.println("로그인 실패");
			session.setAttribute("loginMember", null);
		}
		mav.setViewName("mainPage");
		return mav;
	}
	
	@RequestMapping("main/logout.do")
	public ModelAndView logout(HttpServletRequest req) {
		HttpSession session = req.getSession();
		session.removeAttribute("loginMember");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("mainPage");
		return mav;
	}
	
	@RequestMapping("main/newBoard.do")
	public ModelAndView newBoard() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("mainBoardPage");
		return mav;
	}
	
	@PostMapping("main/submitBoard.do")
	public ModelAndView insertBoard(HttpServletRequest req, HttpServletResponse resp) {
		ModelAndView mav = new ModelAndView();
		
		BoardVO bvo = new BoardVO();
		bvo.setBoTitle(req.getParameter("boardTitle"));
		bvo.setBoContent(req.getParameter("boardContent"));
		bvo.setBoWriter(req.getParameter("boardWriter"));
		
		mainService.insertBoard(bvo);
		
		mav.setViewName("mainPage");
		return mav;
	}
	
}
