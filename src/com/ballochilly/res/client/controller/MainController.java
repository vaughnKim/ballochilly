package com.ballochilly.res.client.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ballochilly.res.client.service.reservation.CalService;
import com.ballochilly.res.client.service.reservation.ReservationService;
import com.ballochilly.res.client.service.sub.SubService;
import com.ballochilly.res.client.service.user.UserService;
import com.ballochilly.res.common.Cal;
import com.ballochilly.res.common.WeatherInfo;

@Controller
public class MainController {
	
	@Autowired
	ReservationService rService;
	
	@Autowired
	UserService userService;
	
	@Autowired
	CalService cService;
	
	@Autowired
	SubService subService;
	
	@RequestMapping(value = "main", method=RequestMethod.GET)
	public ModelAndView main(
			@RequestParam Map<String, Object> map,
			HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		map.put("id", session.getAttribute("id"));
		// 날씨 가져오기
		mav.addAllObjects(WeatherInfo.weatherAndDay());
		mav.addAllObjects(WeatherInfo.weekWeather());
		mav.addObject("dateList",Cal.getCalendar(map));
		mav.addObject("mainReservation", rService.getMainReservation(map));
		
		if (session.getAttribute("user") != null
				&& !session.getAttribute("user").equals("")) {
			
			mav.addAllObjects(userService.newNote(map));
			mav.addAllObjects(userService.newMsg(map));
			
		} else if(session.getAttribute("master") != null
				&& !session.getAttribute("master").equals("")) {
			
			map.put("masterName", ((Map) session.getAttribute("master")).get("MASTER_ID"));
			mav.addAllObjects(subService.allReservaionForName(map));
		}
		
		mav.setViewName("main");
		return mav;
		
	}
	
	@RequestMapping(value = "maptest", method=RequestMethod.GET)
	public ModelAndView maptest() {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("test/maptest");
		return mav;
		
	}
	
	@RequestMapping(value = "cookieTest", method=RequestMethod.GET)
	public ModelAndView cookieTest() {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("test/cookieTest");
		return mav;
		
	}
	
	@RequestMapping(value = "caltest", method=RequestMethod.GET)
	public ModelAndView caltest(@RequestParam Map<String, Object> map) {
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(WeatherInfo.weatherAndDay());
		mav.addObject("dateList", cService.getCalendar(map));
		mav.setViewName("test/caltest");
		return mav;
		
	}
	
}
