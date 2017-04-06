package com.ballochilly.res.client.dao.team;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LookForTeamBoardDao {

	@Autowired
	SqlSessionTemplate ss;
	
	public List<Map<String, Object>> selectTeamHireBoard(Map<String, Object> map) {
		return ss.selectList("selectTeamHireBoard", map);
	}
	
	public int countTeamHireBoard(Map<String, Object> map) {
		return ss.selectOne("countTeamHireBoard", map);
	}
	
	public int insertBoard(Map<String, Object> map) {
		return ss.insert("insertBoard", map);
	}
	
	public int updateBoard(Map<String, Object> map) {
		return ss.update("updateBoard", map);
	}
	
	public List<Map<String, Object>> selectTeamHireBoardReply(Map<String, Object> map) {
		return ss.selectList("selectTeamHireBoardReply", map);
	}
	
	public int countTeamHireBoardReply(Map<String, Object> map) {
		return ss.selectOne("countTeamHireBoardReply", map);
	}
	
	public int replyInsert(Map<String, Object> map) {
		return ss.insert("replyInsert", map);
	}
	
	public int replyDelete(Map<String, Object> map) {
		return ss.delete("replyDelete", map);
	}
	
	public int updateReply(Map<String, Object> map) {
		return ss.update("updateReply", map);
	}
	
	public int updateHit(Map<String, Object> map) {
		return ss.update("updateHit", map);
	}
	
	public int deleteList(Map<String, Object> map) {
		return ss.delete("deleteList", map);
	}
	
	public int deleteListReply(Map<String, Object> map) {
		return ss.delete("deleteListReply", map);
	}
	
	public int cmtOfCmt(Map<String, Object> map) {
		return ss.insert("cmtOfCmt", map);
	}
	
}







