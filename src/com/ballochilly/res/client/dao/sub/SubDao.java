package com.ballochilly.res.client.dao.sub;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SubDao {

	@Autowired
	SqlSessionTemplate ss;
	
	public List<Map<String, Object>> allReservaionForName(Map<String, Object> map) {
		return ss.selectList("allReservaionForName", map);
	}
		
}
