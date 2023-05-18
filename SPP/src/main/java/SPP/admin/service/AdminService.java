package SPP.admin.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.google.gson.Gson;

import SPP.admin.PageViewVO;
import SPP.admin.service.impl.AdminDAO;
import SPP.main.MemberVO;

@Service("adminService")
public class AdminService {
	
	@Resource(name = "adminDAO")
	AdminDAO adminDao;
	
	public List<?> selectConfirmMember() {
		return adminDao.selectConfirmMember();
	}
	
	public List<?> selectAuthMember() {
		return adminDao.selectAuthMember();
	}
	
	public void confirmMember(MemberVO mvo) {
		adminDao.confirmMember(mvo);
	}
	
	public void deleteMember(MemberVO mvo) {
		adminDao.deleteMember(mvo);
	}
	
	public void updatePageView(PageViewVO pvvo) {
		adminDao.updatePageView(pvvo);
	}
	
	public int selectTodayCnt() {
		return adminDao.selectTodayCnt();
	}
	
	public int selectTotCnt() {
		return adminDao.selectTotCnt();
	}
	
	public String selectChartData(){
		Gson gson = new Gson();
		List<PageViewVO> list = (List<PageViewVO>) adminDao.selectChartData();
		for(PageViewVO pv : list) {
			System.out.println(pv);
		}
		String res = gson.toJson(adminDao.selectChartData());
		return res;
	}
	
}
