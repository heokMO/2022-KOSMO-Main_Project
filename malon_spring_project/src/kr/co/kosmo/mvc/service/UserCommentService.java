package kr.co.kosmo.mvc.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.kosmo.mvc.dao.UserCommentDAO;
import kr.co.kosmo.mvc.dto.UserCommentVO;


@Repository
public class UserCommentService implements UserCommentDAO {

	@Autowired
	private SqlSessionTemplate ss;
	
	@Override
	public List<UserCommentVO> getComments(int songId) {
		return ss.selectList("comment.getList", songId);
	}

	@Override
	public int writeComment(UserCommentVO userCommentVO) {
		
		return ss.insert("comment.writeComment", userCommentVO);
	}

	@Override
	public void deleteComment(int commentId) {
		// TODO Auto-generated method stub

	}

}
