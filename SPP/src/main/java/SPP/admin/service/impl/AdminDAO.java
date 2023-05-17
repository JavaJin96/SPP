package SPP.admin.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import SPP.main.MemberVO;

@Repository("adminDAO")
public class AdminDAO extends EgovAbstractMapper{
	
	public List<?> selectConfirmMember() {
		return selectList("adminDAO.selectConfirmMember");
	}
	
	public void confirmMember(MemberVO mvo) {
		update("adminDAO.confirmMember", mvo);
	}
	
	public void deleteMember(MemberVO mvo) {
		delete("adminDAO.deleteMember", mvo);
	}
	
}
