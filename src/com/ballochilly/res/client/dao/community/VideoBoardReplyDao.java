package com.ballochilly.res.client.dao.community;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface VideoBoardReplyDao {
	

	/**
	 * 동영상 댓글 등록
	 * @param paramMap
	 * @return
	 */
	public int AddCommentVideoBoard (Map<String, String> paramMap);
	
	
	/**
	 * 동영상 댓글 다 가져오기
	 * @param map
	 * @return
	 */
	public List<Map<String, Object>> selectCommentVideoBoard (Map<String, Object> map);
	
	
	/**
	 * 동영상 댓글 갯수 가져오기
	 * @param map
	 * @return
	 */
	public int getCountNoVideoComment (Map<String, Object> map);
	
	
	/**
	 * 동영상 댓글 수정하기
	 * @param paramMap
	 * @return
	 */
	public int editCommentVideoBoard (Map<String, String> paramMap);
	
	
	/**
	 * 동영상 댓글 삭제하기
	 * @param map
	 * @return
	 */
	public int deleteCommentVideoBoard (Map<String, Object> map);
}
