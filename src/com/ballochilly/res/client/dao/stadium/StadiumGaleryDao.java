package com.ballochilly.res.client.dao.stadium;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface StadiumGaleryDao {
	
	
//	public int getLastSeqNo();
	
	/**
	 * 경기장 등록
	 * @param map
	 * @return
	 */
	public int AddStadiumGalery (Map<String, Object> map);
	
	
	/**
	 * 각 경기장 정보 가져오기
	 * @param map
	 * @return
	 */
	public List<Map<String, Object>> selectEachStadiumGalery (Map<String, Object> map);
	
	/**
	 * 각 경기장 사진  가져오기
	 * @param map
	 * @return
	 */
	public Map<String, Object> selectStadiumGaleryBySeqNo (Map<String, Object> map);
	
	
	/**
	 * 각 경기장 사진  가져오기
	 * @param map
	 * @return
	 */
	public int deleteEachStadiumGalery (Map<String, Object> map);
	
}
