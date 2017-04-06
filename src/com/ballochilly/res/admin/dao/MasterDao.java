package com.ballochilly.res.admin.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MasterDao {
	
	@Autowired
	SqlSessionTemplate ss;

	public List<Map<String, Object>> selectMaster(Map<String, Object> map) {
		return ss.selectList("selectMaster", map);
	}
	
	public List<Map<String, Object>> myReservation(Map<String, Object> map ){
		return ss.selectList("myReservation", map);
	}
	
	public List<Map<String, Object>> cntCourt(Map<String, Object> map) {
		return ss.selectList("cntCourt", map);
	}
	
	public String selectSiNumber(Map<String, Object> map) {
		return ss.selectOne("selectSiNumber", map);
	}
	
	public int masterReservation(Map<String, Object> map) {
		return ss.insert("masterReservation", map);
	}
	
	public int masterDelete(Map<String, Object> map) {
		return ss.delete("masterDelete", map);
	}
	
	public List<Map<String, Object>> selectReservationUserInfo(Map<String, Object> map) {
		return ss.selectList("selectReservationUserInfo", map);
	}
	
}
