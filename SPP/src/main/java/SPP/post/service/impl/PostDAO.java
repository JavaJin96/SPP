package SPP.post.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import SPP.post.PostVO;

@Repository("postDAO")
public class PostDAO extends EgovAbstractMapper{
	
	public List<?> selectAllPost(PostVO pvo){
		return selectList("postDAO.selectAllPost", pvo);
	}
	
	public int selectAllPostCnt(PostVO pvo) {
		return selectOne("postDAO.selectAllPostCnt", pvo);
	}
	
	public PostVO selectPost(PostVO pvo) {
		return selectOne("postDAO.selectPost", pvo);
	}
	
	public void updatePost(PostVO pvo) {
		update("postDAO.updatePost", pvo);
	}
	
	public void insertPost(PostVO pvo) {
		insert("postDAO.insertPost", pvo);
	}
	
	public void deletePost(PostVO pvo) {
		delete("postDAO.deletePost", pvo);
	}
	
	public List<?> selectPostMenu() {
		return selectList("postDAO.selectPostMenu");
	}
	
	public void insertPostMenu(PostVO pvo) {
		insert("postDAO.insertPostMenu", pvo);
	}
	
	public void updatePostMenu(PostVO pvo) {
		update("postDAO.updatePostMenu", pvo);
	}
	
	public void deletePostMenu(PostVO pvo) {
		delete("postDAO.deletePostMenu", pvo);
	}
	
	public void deletePostMenuInPost(PostVO pvo) {
		delete("postDAO.deletePostMenuInPost", pvo);
	}
	
	public void deleteMimgFile(PostVO pvo) {
		update("postDAO.deleteMimgFile", pvo);
	}
	
	public void deleteAttFile(PostVO pvo) {
		update("postDAO.deleteAttFile", pvo);
	}
	
}
