package SPP.main.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import SPP.main.BoardVO;
import SPP.main.MemberVO;
import SPP.main.service.impl.MainDAO;

@Service("mainService")
public class MainService {
	
	@Resource(name = "mainDAO")
	MainDAO mainDao;
	
	public List<?> selectTestMember(){
		return mainDao.testSelectAll();
	}
	
	public MemberVO selectLogin(MemberVO loginMember) {
		return mainDao.selectLogin(loginMember);
	}
	
	public List<?> selectAllBoard(){
		return mainDao.selectAllBoard();
	}
	
	public void insertBoard(BoardVO bvo) {
		mainDao.insertBoard(bvo);
	}
	
}
