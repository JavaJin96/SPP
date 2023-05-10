package SPP.main.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MainController {
	
	@RequestMapping("main/main.do")
	public ModelAndView goMain() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("mainPage");
		return mav;
	}
	
}
