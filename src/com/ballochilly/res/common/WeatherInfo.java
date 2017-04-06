package com.ballochilly.res.common;

import java.io.IOException;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class WeatherInfo {
	
	public static Map<String, Object> weather() {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		List<Map<String, Object>> weatherList =  new ArrayList<Map<String, Object>>();
//		String url = HttpUtil.sendGet("http://www.kma.go.kr/wid/queryDFSRSS.jsp?zone=3017058800");
		String url = "http://www.kma.go.kr/wid/queryDFSRSS.jsp?zone=3017058800";
		
		URL ur = null;
		URLConnection conn = null;
		
		try {
			
			ur = new URL(url);
			conn = ur.openConnection();
			
            DocumentBuilderFactory f = DocumentBuilderFactory.newInstance();
            DocumentBuilder b = f.newDocumentBuilder();
            Document doc = b.parse(conn.getInputStream());
 
            doc.getDocumentElement().normalize();
            System.out.println ("Root element: " + doc.getDocumentElement().getNodeName());
       
            // loop through each item
            NodeList data = doc.getElementsByTagName("data");
            
            for (int i = 0; i < data.getLength(); i++) {
            	
            	Map<String, Object> resultMap = new HashMap<String, Object>();
            	
                Node n = data.item(i);
                if (n.getNodeType() != Node.ELEMENT_NODE)
                    continue;
                Element e = (Element) n;
 
                // get the "title elem" in this item (only one)
                NodeList hour = e.getElementsByTagName("hour");
                Element hourElem = (Element) hour.item(0);
 
                // get the "text node" in the title (only one)
                Node hourNode = hourElem.getChildNodes().item(0);
                
                NodeList day = e.getElementsByTagName("day");
                Element dayElem = (Element) day.item(0);
                Node dayNode = dayElem.getChildNodes().item(0);
                
                NodeList temp = e.getElementsByTagName("temp");
                Element tempElem = (Element) temp.item(0);
                Node tempNode = tempElem.getChildNodes().item(0);
                
                NodeList tmx = e.getElementsByTagName("tmx");
                Element tmxElem = (Element) tmx.item(0);
                Node tmxNode = tmxElem.getChildNodes().item(0);
                
                
                NodeList tmn = e.getElementsByTagName("tmn");
                Element tmnElem = (Element) tmn.item(0);
                Node tmnNode = tmnElem.getChildNodes().item(0);
                
                NodeList wfKor = e.getElementsByTagName("wfKor");
                Element wfKorElem = (Element) wfKor.item(0);
                Node wfKorNode = wfKorElem.getChildNodes().item(0);
                
                
                if(hourNode.getNodeValue().equals("24")) {
                	
                	resultMap.put("day", dayNode.getNodeValue());
                	resultMap.put("temp", tempNode.getNodeValue());
                	resultMap.put("tmx", tmxNode.getNodeValue());
                	resultMap.put("tmn", tmnNode.getNodeValue());
                	resultMap.put("wfKor", wfKorNode.getNodeValue());
                	
                	weatherList.add(resultMap);
                	
                }
                
            }
            
            returnMap.put("weatherList", weatherList);
            
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
            e.printStackTrace();
        }
		
		return returnMap;
	}
	
	public static Map<String, Object> weekWeather() {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		List<Map<String, Object>> weekWeatherList =  new ArrayList<Map<String, Object>>();
		String url = "http://www.kma.go.kr/weather/forecast/mid-term-rss3.jsp?stnId=108";
		String fullDays = "";
		String date = "";
		String date_2 = "";
		String reallyDay[] = null;
		String testDay = "";
		
		Node test;
		
		URL ur = null;
		URLConnection conn = null;
		
		try {
			
			ur = new URL(url);
			conn = ur.openConnection();
			
            DocumentBuilderFactory f = DocumentBuilderFactory.newInstance();
            DocumentBuilder b = f.newDocumentBuilder();
            Document doc = b.parse(conn.getInputStream());
 
            doc.getDocumentElement().normalize();
            System.out.println ("Root element: " + doc.getDocumentElement().getNodeName());
       
            // loop through each item
            NodeList data = doc.getElementsByTagName("data");
            
//            System.out.println("ttttttttttttttttttttttt : " + data.getLength());
            
            for (int i = 0; i < 12 ; i++) {
            	
            	Map<String, Object> resultMap = new HashMap<String, Object>();
            	
                Node n = data.item(i);
                if (n.getNodeType() != Node.ELEMENT_NODE)
                    continue;
                Element e = (Element) n;
                
                NodeList location = doc.getElementsByTagName("location");
                
                for(int j = 0 ; j < location.getLength() ; j++) {
                	
                	Node node = location.item(j);
                    if (node.getNodeType() != Node.ELEMENT_NODE)
                        continue;
                    Element element = (Element) node;
                    
                    NodeList city = element.getElementsByTagName("city");
                    Element cityElem = (Element) city.item(0);
                    Node cityNode = cityElem.getChildNodes().item(0);
                    
                    if(cityNode.getNodeValue().equals("대전")) {
                    	
		                NodeList day = e.getElementsByTagName("tmEf");
		                Element dayElem = (Element) day.item(0);
		                Node dayNode = dayElem.getChildNodes().item(0);
		                fullDays = dayNode.getNodeValue();
		                
		                NodeList wf = e.getElementsByTagName("wf");
		                Element wfElem = (Element) wf.item(0);
		                Node wfNode = wfElem.getChildNodes().item(0);
		                
		                NodeList tmn = e.getElementsByTagName("tmn");
		                Element tmnElem = (Element) tmn.item(0);
		                Node tmnNode = tmnElem.getChildNodes().item(0);
		                
		                NodeList tmx = e.getElementsByTagName("tmx");
		                Element tmxElem = (Element) tmx.item(0);
		                Node tmxNode = tmxElem.getChildNodes().item(0);
		                
		                date = fullDays.substring(fullDays.indexOf("-", 0) + 1, fullDays.indexOf(" ", 0));
		                
		                System.out.println("풀데이트 : " + fullDays);
		                System.out.println("자른데이트 : " + date);
		                
		                reallyDay = date.split("-");
		                testDay = Integer.parseInt(reallyDay[0]) + "/" + Integer.parseInt(reallyDay[1]);
		                System.out.println("데이트의 갯수 : " + date_2.length());
		                
		                if(!date_2.equals(date)) {
		                	
		                	resultMap.put("day", testDay);
		                	
		                	resultMap.put("month", Integer.parseInt(reallyDay[0]));
		                	resultMap.put("weekOfDays", Integer.parseInt(reallyDay[1]));
		                	
		                	resultMap.put("tmx", tmxNode.getNodeValue());
		                	resultMap.put("tmn", tmnNode.getNodeValue());
		                	resultMap.put("wf", wfNode.getNodeValue());
		                	date_2 = date;
		                	
		                }
                    }
                	
                }
                	
            	weekWeatherList.add(resultMap);
                
            }
            
            returnMap.put("weekWeatherList", weekWeatherList);
            System.out.println("returnMap : " + returnMap);
            
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
            e.printStackTrace();
        }
		
		
		return returnMap;
		
		
	}
	
	
	public static Map<String, Object> weatherAndDay() {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		List<Map<String, Object>> weatherList =  new ArrayList<Map<String, Object>>();
//		String url = HttpUtil.sendGet("http://www.kma.go.kr/wid/queryDFSRSS.jsp?zone=3017058800");
		String url = "http://www.kma.go.kr/wid/queryDFSRSS.jsp?zone=3017058800";
		
		URL ur = null;
		URLConnection conn = null;
		Calendar cal = Calendar.getInstance();
		
		try {
			
			ur = new URL(url);
			conn = ur.openConnection();
			
            DocumentBuilderFactory f = DocumentBuilderFactory.newInstance();
            DocumentBuilder b = f.newDocumentBuilder();
            Document doc = b.parse(conn.getInputStream());
 
            doc.getDocumentElement().normalize();
            System.out.println ("Root element: " + doc.getDocumentElement().getNodeName());
       
            // loop through each item
            NodeList data = doc.getElementsByTagName("data");
            
            for (int i = 0; i < data.getLength(); i++) {
            	
            	Map<String, Object> resultMap = new HashMap<String, Object>();
            	
                Node n = data.item(i);
                if (n.getNodeType() != Node.ELEMENT_NODE)
                    continue;
                Element e = (Element) n;
 
                // get the "title elem" in this item (only one)
                NodeList hour = e.getElementsByTagName("hour");
                Element hourElem = (Element) hour.item(0);
 
                // get the "text node" in the title (only one)
                Node hourNode = hourElem.getChildNodes().item(0);
                
                NodeList day = e.getElementsByTagName("day");
                Element dayElem = (Element) day.item(0);
                Node dayNode = dayElem.getChildNodes().item(0);
                
                NodeList temp = e.getElementsByTagName("temp");
                Element tempElem = (Element) temp.item(0);
                Node tempNode = tempElem.getChildNodes().item(0);
                
                NodeList tmx = e.getElementsByTagName("tmx");
                Element tmxElem = (Element) tmx.item(0);
                Node tmxNode = tmxElem.getChildNodes().item(0);
                
                
                NodeList tmn = e.getElementsByTagName("tmn");
                Element tmnElem = (Element) tmn.item(0);
                Node tmnNode = tmnElem.getChildNodes().item(0);
                
                NodeList wfKor = e.getElementsByTagName("wfKor");
                Element wfKorElem = (Element) wfKor.item(0);
                Node wfKorNode = wfKorElem.getChildNodes().item(0);
                
                
                if(hourNode.getNodeValue().equals("24")) {
                	
                	
                	if(dayNode.getNodeValue().equals("0")){
                		System.out.println(cal.get(Calendar.MONTH) + 1);
                		resultMap.put("month", cal.get(Calendar.MONTH) + 1);
                		resultMap.put("day", cal.get(Calendar.DATE));
                		
                	} else if(dayNode.getNodeValue().equals("1")) {
                		
                		cal.add(Calendar.DATE, 1);
                		System.out.println(cal.get(Calendar.MONTH) + 1);
                		resultMap.put("month", cal.get(Calendar.MONTH) + 1);
                		resultMap.put("day", cal.get(Calendar.DATE));
                		
                	} else if(dayNode.getNodeValue().equals("2")) {
                		
                		cal.add(Calendar.DATE, 1);
                		System.out.println(cal.get(Calendar.MONTH) + 1);
                		resultMap.put("month", cal.get(Calendar.MONTH) + 1);
                		resultMap.put("day", cal.get(Calendar.DATE));
                		
                	}
                	
                	resultMap.put("temp", tempNode.getNodeValue());
                	resultMap.put("tmx", tmxNode.getNodeValue());
                	resultMap.put("tmn", tmnNode.getNodeValue());
                	resultMap.put("wfKor", wfKorNode.getNodeValue());
                	
                	weatherList.add(resultMap);
                	
                }
                
            }
            
            returnMap.put("weatherList", weatherList);
            
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
            e.printStackTrace();
        }
		
		return returnMap;
	}
	
	
	

}
