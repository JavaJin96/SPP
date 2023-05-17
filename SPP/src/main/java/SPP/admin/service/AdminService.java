package SPP.admin.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import SPP.admin.service.impl.AdminDAO;
import SPP.main.MemberVO;

@Service("adminService")
public class AdminService {
	
	@Resource(name = "adminDAO")
	AdminDAO adminDao;
	
	public List<?> selectConfirmMember() {
		return adminDao.selectConfirmMember();
	}
	
	public void confirmMember(MemberVO mvo) {
		adminDao.confirmMember(mvo);
	}
	
	public void deleteMember(MemberVO mvo) {
		adminDao.deleteMember(mvo);
	}
}
