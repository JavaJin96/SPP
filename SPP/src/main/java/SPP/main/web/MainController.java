package SPP.main.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import SPP.admin.service.AdminService;
import SPP.main.BoardVO;
import SPP.main.MemberVO;
import SPP.main.service.MainService;
import SPP.main.service.impl.MainDAO;

@Controller
public class MainController {
	
	@Resource(name = "mainService")
	MainService mainService;
	
	@Resource(name = "adminService")
	AdminService adminService;
	
	@RequestMapping("main/main.do")
	public ModelAndView goMain() {
		ModelAndView mav = new ModelAndView();
		
		List<BoardVO> bvoList = (List<BoardVO>) mainService.selectAllBoard();
		int todayCnt = adminService.selectTodayCnt();
		int totCnt = adminService.selectTotCnt();
		
		String chartJsonData = adminService.selectChartData();
		System.out.println(chartJsonData);
		mav.addObject("chartJsonData", chartJsonData);
		mav.addObject("todayCnt", todayCnt);
		mav.addObject("totCnt", totCnt);
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
		mav.setViewName("redirect:/main/main.do");
		return mav;
	}
	
	@RequestMapping("main/logout.do")
	public ModelAndView logout(HttpServletRequest req) {
		HttpSession session = req.getSession();
		session.removeAttribute("loginMember");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/main/main.do");
		return mav;
	}
	
	@RequestMapping("board/boardForm.do")
	public ModelAndView newBoard() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("boardFormPage");
		return mav;
	}
	
	@PostMapping("board/insertBoard.do")
	public ModelAndView insertBoard(HttpServletRequest req, HttpServletResponse resp) {
		ModelAndView mav = new ModelAndView();
		
		BoardVO bvo = new BoardVO();
		bvo.setBoTitle(req.getParameter("boardTitle"));
		bvo.setBoContent(req.getParameter("boardContent"));
		bvo.setBoWriter(req.getParameter("boardWriter"));
		
		mainService.insertBoard(bvo);
		
		mav.setViewName("redirect:/main/main.do");
		return mav;
	}
	
	@RequestMapping("board/main.do")
	public ModelAndView goBoard() {
		ModelAndView mav = new ModelAndView();
		
		List<BoardVO> bvoList = (List<BoardVO>) mainService.selectAllBoard();
		
		mav.addObject("bvoList", bvoList);
		mav.setViewName("mainBoardPage");
		return mav;
	}
	
	@RequestMapping("board/boardDtl.do")
	public ModelAndView dtlBoard(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		
		BoardVO bvo = new BoardVO();
		bvo.setBoNo(req.getParameter("boNo"));
		bvo.setBoType("0");
		bvo = mainService.selectBoard(bvo);
		
		mav.addObject("Board", bvo);
		mav.setViewName("boardDtl");
		return mav;
	}
	
	@PostMapping("board/updateBoardForm.do")
	public ModelAndView updateBoardForm(HttpServletRequest req)  {
		ModelAndView mav = new ModelAndView();
		
		BoardVO bvo = new BoardVO();
		bvo.setBoNo(req.getParameter("boNo"));
		bvo.setBoType("0");
		bvo = mainService.selectBoard(bvo);
		
		mav.addObject("Board", bvo);
		mav.setViewName("updateBoardForm");
		return mav;
	}
	
	@PostMapping("board/updateBoard.do")
	public ModelAndView updateBoard(HttpServletRequest req, @ModelAttribute("board")BoardVO bvo)  {
		ModelAndView mav = new ModelAndView();
		
		bvo.setBoType("0");
		mainService.updateBoard(bvo);
		mav.setViewName("redirect:/board/boardDtl.do?boNo="+bvo.getBoNo());
		
		return mav;
	}
	
	@PostMapping("board/deleteBoard.do")
	public ModelAndView deleteBoard(HttpServletRequest req)  {
		ModelAndView mav = new ModelAndView();
		
		BoardVO bvo = new BoardVO();
		bvo.setBoNo(req.getParameter("boNo"));
		bvo.setBoType("0");
		
		mainService.deleteBoard(bvo);
		mav.setViewName("redirect:/board/main.do");
		return mav;
	}
	
	@RequestMapping("main/joinForm.do")
	public ModelAndView joinForm() {
		ModelAndView mav = new ModelAndView();
		
		MemberVO mvo = new MemberVO();
		
		mav.addObject("member", mvo);
		mav.setViewName("joinFormPage");
		return mav;
	}
	
	@PostMapping("main/join.do")
	public ModelAndView goJoin(HttpServletRequest req, @ModelAttribute("member")MemberVO mvo) {
		ModelAndView mav = new ModelAndView();
		
		mainService.joinMember(mvo);
		
		mav.setViewName("redirect:/main/main.do");
		return mav;
	}
	
	@Async
	@ResponseBody
	@PostMapping("main/idValidation.do")
	public String idValidation(HttpServletRequest req) {
		MemberVO mvo = new MemberVO();
		mvo.setMemId(req.getParameter("idValue"));
		MemberVO resMvo = mainService.validationMember(mvo);
		String res = "";
		System.out.println(resMvo);
		if(resMvo == null) {
			res = "{\"res\" : \"사용가능한 아이디입니다.\"}";
		}else if(resMvo != null){
			res = "{\"res\" : \"중복된 아이디입니다.\"}";
		}
		
		return res;
	}
	
	
}
