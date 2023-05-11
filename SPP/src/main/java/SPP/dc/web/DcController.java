package SPP.dc.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class DcController {

	@RequestMapping("dc/main.do")
	public ModelAndView goMain() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("dcPage");
		return mav;
	}
	
}
