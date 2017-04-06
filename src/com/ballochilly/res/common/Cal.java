package com.ballochilly.res.common;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Cal {
	
	public static List<Map<String, Object>> getCalendar(Map<String, Object> paramMap) {
		
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
			map.put("month", month + 1);
			map.put("year", year);
			
			map.put("nowYear", cal.get(Calendar.YEAR));
			if((cal.get(Calendar.MONTH) + 1 )< 10) {
				map.put("nowMonth", "0" + (cal.get(Calendar.MONTH) + 1));
//				System.out.println("map : " + map);
			} else{
				map.put("nowMonth", cal.get(Calendar.MONTH) + 1);
//				System.out.println("map : " + map);
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
		
//		System.out.println(map);
		return dateList;
		
	}	//end getCalendar

}
