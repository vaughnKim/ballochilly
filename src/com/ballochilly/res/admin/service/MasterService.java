package com.ballochilly.res.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ballochilly.res.admin.dao.MasterDao;

@Service
public class MasterService {
	
	@Autowired
	MasterDao mDao;
	
	public Map<String, Object> masterLogin(Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		List<Map<String, Object>> list = mDao.selectMaster(map);
		
		if (list.size() > 0) {

			Map<String, Object> resultMap = list.get(0);

			if (map.get("masterPw").equals(list.get(0).get("MASTER_PW"))) {

				returnMap.put("master", resultMap);
				returnMap.put("code", 200);
//				System.out.println("returnMap : " + returnMap);

			} else {
				returnMap.put("msg", "비밀번호가 틀렸습니다.");
				returnMap.put("code", 201);
			}
			
		} else {
			returnMap.put("msg", "해당 ID가 없습니다.");
			returnMap.put("code", 202);
		}

		return returnMap;
	}

	public Map<String, Object> myReservation(Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		returnMap.put("myReservation", mDao.myReservation(map));
		System.out.println("returnMap : " + returnMap);
		return returnMap;
	}
	
	public Map<String, Object> cntCourt(Map<String, Object> map) {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("cntCourt", mDao.cntCourt(map));
		return returnMap;
		
	}
	
	public Map<String, Object> selectSiNumber(Map<String, Object> map) {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("selectSiNumber", mDao.selectSiNumber(map));
		return returnMap;
	}
	
	public Map<String, Object> masterReservation(Map<String, Object> map) {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		int result = mDao.masterReservation(map);
		
		if(result > 0 ){
			returnMap.put("code" ,200);
			returnMap.put("msg", "성공적으로 예약했습니다.");
		} else {
			returnMap.put("code" ,201);
			returnMap.put("msg", "실패");
		}
		
		return returnMap; 
	}
	
	public Map<String, Object> masterDelete(Map<String, Object> map) {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		int result = mDao.masterDelete(map);
		
		if(result > 0 ){
			returnMap.put("code" ,200);
			returnMap.put("msg", "성공적으로 취소됐습니다.");
		} else {
			returnMap.put("code", 201);
			returnMap.put("msg", "실패");
		}
		
		return returnMap; 
	}
	
	public Map<String, Object> selectReservationUserInfo(Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();				
		returnMap.put("selectReservationUserInfo", mDao.selectReservationUserInfo(map));
		System.out.println("#################");
		System.out.println(returnMap);
		System.out.println("#################");
		return returnMap;
		
	}
	
}
