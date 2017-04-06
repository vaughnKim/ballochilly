package com.ballochilly.res.client.dao.team;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class TeamDao {
	
	@Autowired
	SqlSessionTemplate ss;
	
	public int insertTeam(Map<String, Object> map) {
		return ss.insert("insertTeam", map);
	}
	
	public int isExistTeamName(Map<String, Object> map) {
		return ss.selectOne("isExistTeamName", map);
	}
	
	public List<Map<String, Object>> teamList(Map<String, Object> map) {
		return ss.selectList("teamList", map);
	}
	
	public int countTeam(Map<String, Object> map) {
		return ss.selectOne("countTeam", map);
	}
	
	public int joinTeamMessage(Map<String, Object> map) {
		return ss.insert("joinTeamMessage", map);
	}
	
	public List<Map<String, Object>> selectTeam(Map<String, Object> map) {
		return ss.selectList("selectTeam", map);
	}
	
	public int insertTeamMember(Map<String, Object> map) {
		return ss.insert("insertTeamMember", map);
	}
	
	public int isExistTeamMember(Map<String, Object> map) {
		return ss.selectOne("isExistTeamMember", map);
	}
	
	public int rejectMsg(Map<String, Object> map) {
		return ss.insert("rejectMsg", map);
	}
	
	public int updateMsgYnState(Map<String, Object> map) {
		return ss.update("msgYnState", map);
	}
	
	public int alreadyJoinTeam(Map<String, Object> map) {
		return ss.selectOne("alreadyJoinTeam", map);
	}
	
	public int countTeamMember(Map<String, Object> map) {
		return ss.selectOne("countTeamMember", map);
	}
	
	public List<Map<String, Object>> teamSearch(Map<String, Object> map) {
		return ss.selectList("teamSearch", map);
	}
	
	public int teamSearchCnt(Map<String, Object> map) {
		return ss.selectOne("teamSearchCnt", map);
	}
	
	public int updateTeam(Map<String, Object> map) {
		return ss.update("updateTeam", map);
	}
	
	public int updateEmblemTeam(Map<String, Object> map) {
		return ss.update("updateEmblemTeam", map);
	}
	
}
