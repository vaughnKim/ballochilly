package com.ballochilly.res.common;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public class Util {
	
	public static String getPagination(int totalCount, int page, int pageBlock, int pageSize) {
		
		String pagination = "";
		
		int totalPage = 0;	// 전체 페이지 수
		
		if(totalCount % pageSize == 0) {
			
			totalPage = totalCount / pageSize;
			
		} else {
			
			totalPage = totalCount / pageSize + 1; // 제대로 나누기를 한다음에 전체페이지를 보여줄 수 있음
			 
		}	//end if
		
		int startPage = 0;	// 페이지 시작 번호
		startPage = (page - 1)/ pageSize * pageSize + 1;
		int endPage = startPage + (pageSize - 1);	// 페이지 끝 번호
		
		if(endPage > totalPage) {
			
			endPage = totalPage; 
			
		}	//end if
		pagination += "<div>";
		
		if(startPage > pageBlock) {
			
			if( (startPage - pageBlock) > totalPage) {
				pagination += totalPage;
			}else {
				pagination += "<img src='./image/boardsub/hot.gif' width='30' height='9' id = 'goStartPage' pagination = '";
				pagination += startPage - pageBlock;
				pagination += "' style='cursor:pointer'> ";
			}
			
		}
		
		for(int i = startPage ; i <= endPage ; i++ ){
			
			pagination += "&nbsp;&nbsp;";
			pagination += "<a class = 'goPage' pagination = '" + i + "' style='cursor:pointer' >";
			pagination += i;
			pagination += "</a>";
			pagination += "&nbsp;&nbsp;";
			
		}	//end for
		
		if(endPage < totalCount) {
			
			if((startPage + pageBlock) > totalPage) {
//				pagination += totalPage;
			}else {
				pagination += "<img src='./image/boardsub/hot2.gif' width='30' height='9' id = 'goNextPage' pagination = '";
				pagination += startPage + pageBlock;
				pagination += "' style='cursor:pointer'> ";						
			}
			
			
		} 
		
		pagination += "</div>";
		
		return pagination;
		
	}	//end getPagination
	
	public static Map<String, String> parseQueryString(HttpServletRequest req) {
		
		Map<String, String> map = new HashMap<String, String>();
		Enumeration<String> names = req.getParameterNames();
		while(names.hasMoreElements()) {
			String name = names.nextElement();
			String value = req.getParameter(name);
			value = value.replaceAll("<", "&lt;");
			value = value.replaceAll(">", "&gt;");
			value = value.replaceAll("<br/>", "\n;");
			map.put(name, value);
			System.out.println("#############################");
			System.out.println("parseQueryString name  : " + name);
			System.out.println("parseQueryString value  : " + value);
		}
		return map;
	}

}
