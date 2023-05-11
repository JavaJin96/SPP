package SPP.p2.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class P2Controller {
	
	@RequestMapping("p2/main.do")
	public ModelAndView goMain() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("p2Page");
		return mav;
	}
	
}
