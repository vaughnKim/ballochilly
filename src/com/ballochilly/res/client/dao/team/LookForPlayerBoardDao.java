package com.ballochilly.res.client.dao.team;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LookForPlayerBoardDao {

	@Autowired
	SqlSessionTemplate ss;
	
	public List<Map<String, Object>> selectPlayerHireBoard(Map<String, Object> map) {
		return ss.selectList("selectPlayerHireBoard", map);
	}
	
	public int countPlayerHireBoard(Map<String, Object> map) {
		return ss.selectOne("countPlayerHireBoard", map);
	}
	
	public int insertPlayerBoard(Map<String, Object> map) {
		return ss.insert("insertPlayerBoard", map);
	}
	
	public int updatePlayerBoard(Map<String, Object> map) {
		return ss.update("updatePlayerBoard", map);
	}
	
	public List<Map<String, Object>> selectPlayerHireBoardReply(Map<String, Object> map) {
		return ss.selectList("selectPlayerHireBoardReply", map);
	}
	
	public int countPlayerHireBoardReply(Map<String, Object> map) {
		return ss.selectOne("countPlayerHireBoardReply", map);
	}
	
	public int replyPlayerInsert(Map<String, Object> map) {
		return ss.insert("replyPlayerInsert", map);
	}
	
	public int replyPlayerDelete(Map<String, Object> map) {
		return ss.delete("replyPlayerDelete", map);
	}
	
	public int updatePlayerReply(Map<String, Object> map) {
		return ss.update("updatePlayerReply", map);
	}
	
	public int updatePlayerHit(Map<String, Object> map) {
		return ss.update("updatePlayerHit", map);
	}
	
}







