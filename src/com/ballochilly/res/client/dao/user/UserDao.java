package com.ballochilly.res.client.dao.user;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserDao {
	
	@Autowired
	SqlSessionTemplate ss;
	
	public int insertUser(Map<String, Object> map) {
		return ss.insert("insertUser", map);
	}
	
	public int isExistId(Map<String, Object> map) {
		return ss.selectOne("isExistId", map);
	}
	
	public List<Map<String, Object>> searchId(Map<String, Object> map) {
		return ss.selectList("searchId", map);
	}
	
	public List<Map<String, Object>> searchEmail(Map<String, Object> map) {
		return ss.selectList("searchEmail", map);
	}
	
	public int tempPassword(Map<String, Object> map){
		return ss.update("tempPassword", map);
	}
	
	public List<Map<String, Object>> selectUser(Map<String, Object> map) {
		return ss.selectList("selectUser", map);
	}
	
	public int updateUserInfo(Map<String, Object> map) {
		return ss.update("updateUserInfo", map);
	}
	
	public String selectPw(Map<String, Object> map) {
		return ss.selectOne("selectPw", map);
	}
	
	public int updateUserPw(Map<String, Object> map) {
		return ss.update("updateUserPw", map);
	}
	
	public List<Map<String, Object>> message(Map<String, Object> map) {
		return ss.selectList("message", map);
	}
	
	public int countMsg(Map<String, Object> map) {
		return ss.selectOne("countMsg", map);
	}
	
	public int updateMsgStatus(Map<String, Object> map) {
		return ss.update("updateMsgStatus", map);
	}
	
	public List<Map<String, Object>> myTeamList(Map<String, Object> map) {
		return ss.selectList("myTeamList", map);
	}
	
	public int myTeamCnt(Map<String, Object> map) {
		return ss.selectOne("myTeamCnt", map);
	}
	
	public int deleteMsg(Map<String, Object> map) {
		return ss.delete("deleteMsg", map);
	}
	
	public int dropOut(Map<String, Object> map) {
		return ss.delete("dropOut", map);
	}
	
	public int teamDelete(Map<String, Object> map) {
		return ss.delete("teamDelete", map);
	}
	
	public int insertNote(Map<String, Object> map) {
		return ss.insert("insertNote", map);
	}
	
	public List<Map<String, Object>> myNote(Map<String, Object> map) {
		return ss.selectList("myNote", map);
	}
	
	public int myNoteCount(Map<String, Object> map) {
		return ss.selectOne("myNoteCount", map);
	}
	
	public int updateNoteStatus(Map<String, Object> map) {
		return ss.update("updateNoteStatus", map);
	}
	
	public int deleteNote(Map<String, Object> map) {
		return ss.delete("deleteNote", map);
	}
	
	public List<Map<String, Object>> sendNote(Map<String, Object> map) {
		return ss.selectList("sendNote", map);
	}
	
	public int sendCount(Map<String, Object> map) {
		return ss.selectOne("sendCount", map);
	}
	
	public int newNote(Map<String, Object> map) {
		return ss.selectOne("newNote", map);
	}
	
	public int newMsg(Map<String, Object> map) {
		return ss.selectOne("newMsg", map);
	}
	
}







