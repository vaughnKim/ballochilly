package com.ballochilly.res.client.dao.stadium;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface StadiumBoardAtchDao {
	
	
	/**
	 * 경기장 이용후기 게시믈 첨부파일 등록
	 * @param map
	 * @return
	 */
	public int AddBoardAtch (Map<String, Object> map);
	
	
	/**
	 * 경기장 이용후기 게시믈 첨부파일 가져오기
	 * @param map
	 * @return
	 */
	public List<Map<String, Object>> selectAtchFile (Map<String, Object> map);
	
	
	/**
	 * 경기장 이용후기 게시물 첨부파일 삭제하기
	 * @param map
	 * @return
	 */
	public int deleteStadiumAtchBoard (Map<String, Object> map);
}
