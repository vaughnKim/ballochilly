package com.ballochilly.res.client.dao.stadium;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface StadiumBoardDao {
	
	/**
	 * 경기장 이용후기 게시물 모든 들록번호 가져오기
	 * @param map
	 * @return
	 */
	public List<Map<String, Object>> getAllBoardSeqNo (Map<String, Object> map);
	
	
	/**
	 * 경기장 이용후기 테이블 마지막  들록번호 가져오기
	 * @param map
	 * @return
	 */
	public int getLastBoardSeqNo (Map<String, Object> map);
	
	
	/**
	 * 경기장 이용후기 게시물 총 갯수 가져오기
	 * @param map
	 * @return
	 */
	public int getTotalCount (Map<String, Object> map);

	
	/**
	 * 경기장 이용후기 게시믈 등록
	 * @param paramMap
	 * @return
	 */
	public int AddStadiumBoard (Map<String, String> paramMap);
	
	
	/**
	 * 경기장 이용후기 게시물 다 가져오기
	 * @param map
	 * @return
	 */
	public List<Map<String, Object>> selectAllStadiumBoard (Map<String, Object> map);
	
	
	
	/**
	 * 경기장 이용후기 게시물 개별정보 가져오기
	 * @param map
	 * @return
	 */
	public List<Map<String, Object>> selectEachStadiumBoard (Map<String, Object> map);
	
	
	/**
	 * 경기장 이용후기 게시물 수정하기
	 * @param map
	 * @return
	 */
	public int raiseHit (Map<String, Object> map);
	
	
	/**
	 * 경기장 이용후기 게시물 수정하기
	 * @param paramMap
	 * @return
	 */
	public int editStadiumBoard (Map<String, String> paramMap);
	
	
	/**
	 * 경기장 이용후기 게시물 삭제하기
	 * @param map
	 * @return
	 */
	public int deleteStadiumBoard (Map<String, Object> map);
	
}

