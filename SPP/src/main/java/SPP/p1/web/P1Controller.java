package SPP.p1.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class P1Controller {
	
	@RequestMapping("p1/main.do")
	public ModelAndView goMain() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("p1Page");
		return mav;
	}
	
}
