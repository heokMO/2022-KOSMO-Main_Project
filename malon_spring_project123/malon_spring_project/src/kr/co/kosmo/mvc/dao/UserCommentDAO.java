package kr.co.kosmo.mvc.dao;

import java.util.List;

import kr.co.kosmo.mvc.dto.UserCommentVO;

public interface UserCommentDAO {
	public List<UserCommentVO> getComments(int songId);
	public int writeComment(UserCommentVO userCommentVO);
	public void deleteComment(int commentId);
}
