package com.ballochilly.res.client.dao.stadium;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface StadiumDao {
	
	public int getLastBoardSeqNo();
	
	/**
	 * 경기장 등록
	 * @param paramMap
	 * @return
	 */
	public int AddStadium (Map<String, String> paramMap);
	
	
	/**
	 * 모든 경기장 정보 가져오기
	 * @param map
	 * @return
	 */
	public List<Map<String, Object>> selectAllStadium (Map<String, Object> map);
	
	/**
	 * 각 경기장 정보 가져오기
	 * @param map
	 * @return
	 */
	public List<Map<String, Object>> selectEachStadium (Map<String, Object> map);
	
	/**
	 * 각 경기장 대표사진 가져오기
	 * @param map
	 * @return
	 */
	public Map<String, Object> selectTitlePhoto (Map<String, Object> map);
	
	/**
	 * 각 경기장 코트갯수 가져오기
	 * @param map
	 * @return
	 */
	public int getEachCourtNo (Map<String, Object> map);
	
	/**
	 * 등록된 경기장 갯수 가져오기
	 * @param map
	 * @return
	 */
	public int getTotalStadiumNo (Map<String, Object> map);
	
	/**
	 * 등록된 경기장정보 수정하기
	 * @param paramMap
	 * @return
	 */
	public int editEachStadiumInfo (Map<String, String> paramMap);
	
	/**
	 * 등록된 경기장정보 삭제하기
	 * @param map
	 * @return
	 */
	public int deleteEachStadiumInfo (Map<String, Object> map);
}
