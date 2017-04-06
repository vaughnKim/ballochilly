package com.ballochilly.res.client.dao.community;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface VideoBoardDao {
	
	/**
	 * 동영상 게시물 모든 들록번호 가져오기
	 * @param map
	 * @return
	 */
	public List<Map<String, Object>> getAllVideoBoardSeqNo (Map<String, Object> map);
	
	
	/**
	 * 동영상 테이블 마지막  들록번호 가져오기
	 * @param map
	 * @return
	 */
	public int getLastVideoBoardSeqNo (Map<String, Object> map);
	
	
	/**
	 * 동영상 게시물 총 갯수 가져오기
	 * @param map
	 * @return
	 */
	public int getTotalCountVideoBoard (Map<String, Object> map);

	
	/**
	 * 동영상  게시믈 등록
	 * @param paramMap
	 * @return
	 */
	public int AddVideoBoard (Map<String, String> paramMap);
	
	
	/**
	 * 동영상  게시물 다 가져오기
	 * @param map
	 * @return
	 */
	public List<Map<String, Object>> selectAllVideoBoard (Map<String, Object> map);
	
	
	
	/**
	 * 동영상  게시물 개별정보 가져오기
	 * @param map
	 * @return
	 */
	public List<Map<String, Object>> selectEachVideoBoard (Map<String, Object> map);
	
	
	/**
	 * 동영상 게시물 수정하기
	 * @param map
	 * @return
	 */
	public int raiseVideoBoardHit (Map<String, Object> map);
	
	
	/**
	 * 동영상 게시물 수정하기
	 * @param paramMap
	 * @return
	 */
	public int editVideoBoard (Map<String, String> paramMap);
	
	
	/**
	 * 동영상 게시물 삭제하기
	 * @param map
	 * @return
	 */
	public int deleteVideoBoard (Map<String, Object> map);
	
}

