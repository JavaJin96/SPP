package SPP.post.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import SPP.post.PostVO;
import SPP.post.service.impl.PostDAO;

@Service("postService")
public class PostService {
	
	@Resource(name="postDAO")
	PostDAO postDao;
	
	public List<?> selectAllPost(PostVO pvo){
		return postDao.selectAllPost(pvo);
	}
	
	public int selectAllPostCnt(PostVO pvo) {
		return postDao.selectAllPostCnt(pvo);
	}
	
	public PostVO selectPost(PostVO pvo) {
		return postDao.selectPost(pvo);
	}
	
	public void updatePost(PostVO pvo) {
		postDao.updatePost(pvo);
	}
	
	public void insertPost(PostVO pvo) {
		postDao.insertPost(pvo);
	}
	
	public void deletePost(PostVO pvo) {
		postDao.deletePost(pvo);
	}
	
	public List<?> selectPostMenu() {
		return postDao.selectPostMenu();
	}
	
	public void insertPostMenu(PostVO pvo) {
		postDao.insertPostMenu(pvo);
	}
	
	public void updatePostMenu(PostVO pvo) {
		postDao.updatePostMenu(pvo);
	}
	
	public void deletePostMenu(PostVO pvo) {
		postDao.deletePostMenu(pvo);
	}
	
}
