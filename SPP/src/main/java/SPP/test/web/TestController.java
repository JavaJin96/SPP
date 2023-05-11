package SPP.test.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class TestController {

	@RequestMapping("test/main.do")
	public ModelAndView goMain() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("testPage");
		return mav;
	}
	
}
