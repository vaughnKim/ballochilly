package com.ballochilly.res.client.dao.stadium;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface StadiumBoardReplyDao {
	

	/**
	 * 경기장 이용후기 댓글 등록
	 * @param paramMap
	 * @return
	 */
	public int AddCommentBoard (Map<String, String> paramMap);
	
	
	/**
	 * 경기장 이용후기 댓글 갯수 가져오기
	 * @param map
	 * @return
	 */
	public int getCountCommentNo (Map<String, Object> map);
	
	
	/**
	 * 경기장 이용후기 댓글 다 가져오기
	 * @param map
	 * @return
	 */
	public List<Map<String, Object>> selectCommentBoard (Map<String, Object> map);
	
	
	/**
	 * 경기장 이용후기 댓글 수정하기
	 * @param paramMap
	 * @return
	 */
	public int editCommentBoard (Map<String, String> paramMap);
	
	
	/**
	 * 경기장 이용후기 댓글 삭제하기
	 * @param map
	 * @return
	 */
	public int deleteCommentBoard (Map<String, Object> map);
}
