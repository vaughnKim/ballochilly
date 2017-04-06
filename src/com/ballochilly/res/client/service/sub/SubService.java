package com.ballochilly.res.client.service.sub;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ballochilly.res.client.dao.sub.SubDao;

@Service
public class SubService {
	
	@Autowired
	SubDao sDao;
	
	public Map<String, Object> allReservaionForName(Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		returnMap.put("allReservaionForName", sDao.allReservaionForName(map));
		System.out.println("returnMap : " + returnMap);
		return returnMap;
		
	}

}
