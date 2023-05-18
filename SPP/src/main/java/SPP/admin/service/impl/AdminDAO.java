package SPP.admin.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import SPP.admin.PageViewVO;
import SPP.main.MemberVO;

@Repository("adminDAO")
public class AdminDAO extends EgovAbstractMapper{
	
	public List<?> selectConfirmMember() {
		return selectList("adminDAO.selectConfirmMember");
	}
	
	public List<?> selectAuthMember() {
		return selectList("adminDAO.selectAuthMember");
	}
	
	public void confirmMember(MemberVO mvo) {
		update("adminDAO.confirmMember", mvo);
	}
	
	public void deleteMember(MemberVO mvo) {
		delete("adminDAO.deleteMember", mvo);
	}
	
	public void updateMember(MemberVO mvo) {
		update("adminDAO.updateMember", mvo);
	}
	
	public void updatePageView(PageViewVO pvvo) {
		update("adminDAO.updatePageView", pvvo);
	}
	
	public int selectTodayCnt() {
		return selectOne("adminDAO.selectTodayCnt");
	}
	
	public int selectTotCnt() {
		return selectOne("adminDAO.selectTotCnt");
	}
	
	public List<?> selectChartData() {
		return selectList("adminDAO.selectChartData");
	}
	
}
