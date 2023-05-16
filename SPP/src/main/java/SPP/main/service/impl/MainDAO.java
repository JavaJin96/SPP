package SPP.main.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import SPP.main.BoardVO;
import SPP.main.MemberVO;

@Repository("mainDAO")
public class MainDAO extends EgovAbstractMapper{
	
	public List<?> testSelectAll(){
		return selectList("mainDAO.testSelectAll");
	}
	
	public MemberVO selectLogin(MemberVO loginMember) {
		return selectOne("mainDAO.selectLogin", loginMember);
	}
	
	public List<?> selectAllBoard(){
		return selectList("mainDAO.selectAllBoard");
	}
	
	public void insertBoard(BoardVO bvo) {
		insert("mainDAO.insertBoard", bvo);
	}
	
}
