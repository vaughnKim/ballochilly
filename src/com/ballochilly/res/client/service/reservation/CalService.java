package com.ballochilly.res.client.service.reservation;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.ballochilly.res.common.WeatherInfo;

@Service
public class CalService {
	
	public List<Map<String, Object>> getCalendar(Map<String, Object> paramMap) {
		
		Calendar cal = Calendar.getInstance();
		Map<String, Object> weather = WeatherInfo.weather();
		
		String tempYear = (String) paramMap.get("year");
		String tempMonth = (String) paramMap.get("month");
		
		int tempYear2 = 0;
		int tempMonth2 = 0;
		
		if(tempYear != null && !tempYear.equals("")){
			
			tempYear2 = Integer.parseInt(tempYear);
			tempMonth2 = Integer.parseInt(tempMonth);
			cal.set(tempYear2, tempMonth2 - 1, 1);
			
		}	//end if
		
		List<Map<String, Object>> dateList = new ArrayList<Map<String, Object>>();
		Map<String, Object> map = null;
		Map<String, Object> testMap = new HashMap<String, Object>();
		
		int today = 0;
//		int tomorrow = 0;
//		int afterTomorrow = 0;
//		System.out.println(weather.get("weatherList"));
		
//		List<Map<String, Object>> weatherList = (List<Map<String, Object>>) weather.get("weatherList");
		
		// 오늘 날짜 구하기
//		if(weatherList.get(0).get("day").equals("0")) {
////			
//			today = cal.get(Calendar.DATE);
//			testMap.put("today", today);
//			dateList.add(testMap);
//			System.out.println(today);
//			System.out.println(testMap);
////
//		}
//		// 내일 날짜 구하기
//		if(weatherList.get(1).get("day").equals("1")){
//			
//			cal.add(Calendar.DATE, 1); // 내일 날짜
//			tomorrow = cal.get(Calendar.DATE);
//			System.out.println(tomorrow);
//		
//		}
//		// 낼모레 날짜 구하기
//		if(weatherList.get(2).get("day").equals("2")){
//			
//			cal.add(Calendar.DATE, 1); // 내일 날짜
//			afterTomorrow = cal.get(Calendar.DATE);
//			System.out.println(afterTomorrow);
//			
//		}
		
		cal.set(Calendar.DATE, 1); // 현재월의 1일로 변경
		cal.add(Calendar.MONTH, 1); // 현재월 + 1월
		cal.add(Calendar.DATE, -1); // 현재월 -1일
		
		int lastDate = cal.get(Calendar.DATE);
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH);
		
		
		for(int i = 1 ; i <= lastDate ; i++) {
			
			map = new HashMap<String, Object>();
			cal.set(year, month, i);
			int week = cal.get(Calendar.DAY_OF_WEEK);
			
			map.put("date", i);
			map.put("week", week);
			
			map.put("nowYear", cal.get(Calendar.YEAR));
			if((cal.get(Calendar.MONTH) + 1 ) < 10) {
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

}
