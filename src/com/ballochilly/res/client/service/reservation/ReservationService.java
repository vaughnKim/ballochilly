package com.ballochilly.res.client.service.reservation;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ballochilly.res.client.dao.reservation.Datas;
import com.ballochilly.res.client.dao.reservation.ReservationDao;
import com.ballochilly.res.common.Util;

@Service
public class ReservationService {
	@Autowired
	ReservationDao rDao;
	
	
	//예약 리스트 가져오는 selectReservation
	public List<Map<String, Object>> getReservationAvailableList(Map<String, Object> map){
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		List<Map<String, Object>> list = rDao.selectReservationStadium(map);
		returnMap.put("AvailableReservationList", list);
		
		return list;
	} //end getReservationAvailableList
	
	
	//최종예약 insert
	public Map<String, Object> addReservation(Map<String, Object> map) {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		System.out.print("##########");
		System.out.println("AddReservation Service");
		
//		map.put("siSeqNo", rDao.selectSiSeqNo(map));
		int result = rDao.insertReservationStadium(map);
		System.out.println("result : " + result);
		if(result > 0) {
			returnMap.put("code", 200);
			returnMap.put("msg", "예약등록이 완료되었습니다.");
			System.out.println("returnMap : " + returnMap);
		} else {
			returnMap.put("code", 201);
			returnMap.put("msg", "예약등록이 처리되지 않았습니다.");
			System.out.println("returnMap : " + returnMap);
		}
		
		return returnMap;
	}
	
	//최종예약2 insert 
	public Map<String, Object> addFinalReservation(Datas datas) {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		System.out.print("##########");
		System.out.println("AddReservation Service");

		int result = 0;
		Map<String, Object> map = null;
		for(int i = 0; i < datas.getId().length; i++) {
			map = new HashMap<String, Object>();
			map.put("year", datas.getYear()[i]);
			map.put("month", datas.getMonth()[i]);
			map.put("day", datas.getDay()[i]);
			map.put("startTime", datas.getStartTime()[i]);
			map.put("endTime", datas.getEndTime()[i]);
			map.put("court", datas.getCourt()[i]);
			map.put("id", datas.getId()[i]);
			map.put("stadiumName", datas.getStadiumName()[i]);
			result = rDao.insertReservationFinal(map);
			if(result == 0) break;
		}
		
		if(result > 0) {
			returnMap.put("code", 200);
			returnMap.put("msg", "예약등록이 완료되었습니다.");
			System.out.println("returnMap : " + returnMap);
		} else {
			returnMap.put("code", 201);
			returnMap.put("msg", "예약등록이 처리되지 않았습니다.");
			System.out.println("returnMap : " + returnMap);
		}
		
		return returnMap;
	}
	
	
	public List<Map<String, Object>> getCalendar(Map<String, Object> paramMap) {
		
		Calendar cal = Calendar.getInstance();
		
		String tempYear = (String) paramMap.get("year");
		String tempMonth = (String) paramMap.get("month");
		
		int tempYear2 = 0;
		int tempMonth2 = 0;
		
		if(tempYear != null && !tempYear.equals("")){
			
			tempYear2 = Integer.parseInt(tempYear);
			tempMonth2 = Integer.parseInt(tempMonth);
			cal.set(tempYear2, tempMonth2 - 1, 1);
			
		}	//end if
		
		cal.set(Calendar.DATE, 1); // 현재월의 1일로 변경
		cal.add(Calendar.MONTH, 1); // 현재월 + 1월
		cal.add(Calendar.DATE, -1); // 현재월 -1일
		
		int lastDate = cal.get(Calendar.DATE);
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH);
		
		List<Map<String, Object>> dateList = new ArrayList<Map<String, Object>>();
		Map<String, Object> map = null;
		
		for(int i = 1 ; i <= lastDate ; i++) {
			
			map = new HashMap<String, Object>();
			cal.set(year, month, i);
			int week = cal.get(Calendar.DAY_OF_WEEK);
			
			map.put("date", i);
			map.put("week", week);
			
			map.put("nowYear", cal.get(Calendar.YEAR));
			if((cal.get(Calendar.MONTH) + 1 )< 10) {
				map.put("nowMonth", "0" + (cal.get(Calendar.MONTH) + 1));
			} else{
				map.put("nowMonth", cal.get(Calendar.MONTH) + 1);
			}
			
			cal.add(Calendar.MONTH, 1); // 다음달
			String nextMonth = (cal.get(Calendar.MONTH) + 1) + "";
			String nextYear = cal.get(Calendar.YEAR) + "";
			
			cal.add(Calendar.MONTH, -2); // 이전달
			String prevMonth = (cal.get(Calendar.MONTH) + 1) + "";
			String prevYear = cal.get(Calendar.YEAR) + "";
			
			map.put("prevMonth", prevMonth);
			map.put("prevYear", prevYear);
			map.put("nextMonth", nextMonth);
			map.put("nextYear", nextYear);
			
			dateList.add(map);
			
		}	//end for
		
		
		return dateList;
		
	}	//end getCalendar
	
	public Map<String, Object> getReservationList(Map<String, Object> map){
		String year = (String) map.get("year");
		if(year == null) {
			Calendar cal = Calendar.getInstance();
			
			map.put("year", cal.get(Calendar.YEAR));
			if(cal.get(Calendar.MONTH) + 1 <10){
				map.put("month", "0"+(cal.get(Calendar.MONTH) + 1));
			} else {
				map.put("month", cal.get(Calendar.MONTH) + 1);
			}//end if(2)
			if(cal.get(Calendar.DAY_OF_MONTH) < 10){
				map.put("day", "0"+cal.get(Calendar.DAY_OF_MONTH));
			} else {
				map.put("day", cal.get(Calendar.DAY_OF_MONTH) + "");
			}//end if(3)
		} else {
			String day = (String) map.get("day");
			if(day.length() < 2) {
				day = "0" + day;
			}
			map.put("day", day);
		}
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		List<Map<String, Object>> list = rDao.selectReservationList(map);
		returnMap.put("ReservationList", list);
		returnMap.put("day", Integer.parseInt((String)map.get("day")));
		
		System.out.println(returnMap.get("day"));
		
		return returnMap;
	} //end getReservationList
	
	
	public Map<String, Object> getSiSeqNo(Map<String, Object> map){
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		List<Map<String, Object>> No = rDao.selectSiSeqNo(map);
		returnMap.put("Siseqno", No);
		
		return map;
	} //end getReservationAvailableList

	public Map<String, Object> getMyReservation(Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		System.out.print("##########");
		System.out.println("getMyReservation Service");
		
		String strPage = (String) map.get("page");
		if(strPage == null) {
			strPage = "1";
		}
		int page = Integer.parseInt(strPage);
		
		String strPageSize = (String) map.get("pageSize");
		if(strPageSize == null){
			strPageSize = "10";
		}
		
		int pageSize = Integer.parseInt(strPageSize);
		int pageBlock = 10;
		
		map.put("page", page);
		System.out.println("page : " + page);
		map.put("pageSize", pageSize);
		System.out.println("pageSize : " + pageSize);
		System.out.println("map : " + map);
		
		List<Map<String, Object>> My = rDao.selectMyReservation(map);
		System.out.println("BoardList ==========" + My);
		
		int totalCount = rDao.getTotalCount(map);
		String paging = Util.getPagination(totalCount, page, pageBlock, pageSize);
		
		returnMap.put("reservation", My);
		returnMap.put("totalCount", totalCount);
		returnMap.put("paging", paging);
		returnMap.put("pageBlock", pageBlock);
		
		return returnMap;
	}
	
	public Map<String, Object> reservationDelete(Map<String, Object> map){
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		int result = rDao.reservationDelete(map);
		
		if(result > 0) {
			returnMap.put("code", 200);
			returnMap.put("msg", "성공적으로 예약이 취소되었습니다");
		} else {
			returnMap.put("code", 201);
			returnMap.put("code", "실패");
		}
		
		return returnMap;
	}
	
	public List<Map<String, Object>> getMainReservation(Map<String, Object> map) {
		String year = (String) map.get("year");
		if(year == null) {
			Calendar cal = Calendar.getInstance();
			System.out.println(cal);
			
			map.put("year", cal.get(Calendar.YEAR));
			if(cal.get(Calendar.MONTH) + 1 <10){
				map.put("month", "0"+(cal.get(Calendar.MONTH) + 1));
			} else {
				map.put("month", cal.get(Calendar.MONTH) + 1);
			}//end if(2)
			if(cal.get(Calendar.DAY_OF_MONTH) < 10){
				map.put("day", "0"+cal.get(Calendar.DAY_OF_MONTH));
			} else {
				map.put("day", cal.get(Calendar.DAY_OF_MONTH));
			}//end if(3)
		}
		
		Map<String, Object> retrunMap = new HashMap<String, Object>();
		
		List<Map<String, Object>> list = rDao.mainReservation(map);
		retrunMap.put("reservation", list);
		return list;
	}
	
	public Map<String, Object> getSimplelocationReservation(Map<String, Object> map) {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		List<Map<String, Object>> list = rDao.SimplelocationReservation(map);
		returnMap.put("Simple", list);
		return returnMap;
	}
	public Map<String, Object> getEachCourtNo(Map<String, Object> map) {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		int courtNo = rDao.getEachCourtNo(map);
		returnMap.put("courtNo", courtNo);
		return returnMap;
	}
	public Map<String, Object> getSimplelocationCourt(Map<String, Object> map) {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		List<Map<String, Object>> court = rDao.SimPlelocationCourt(map);
		returnMap.put("court", court);
		return returnMap;
	}
	
}
