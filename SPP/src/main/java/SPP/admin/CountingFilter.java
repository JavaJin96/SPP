package SPP.admin;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

import SPP.admin.service.AdminService;

public class CountingFilter implements HandlerInterceptor{
	
	@Resource(name = "adminService")
	AdminService adminService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		PageViewVO pvvo = new PageViewVO();
		pvvo.setPvIp(request.getRemoteAddr());
		adminService.updatePageView(pvvo);
		
		return HandlerInterceptor.super.preHandle(request, response, handler);
	}
	 
	


}
