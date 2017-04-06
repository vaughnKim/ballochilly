package com.ballochilly.res.client.controller.reservation;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ballochilly.res.client.dao.reservation.Datas;
import com.ballochilly.res.client.service.reservation.ReservationService;
import com.ballochilly.res.common.WeatherInfo;

@Controller
public class ReservationController {
	@Autowired
	ReservationService rService;
	
	@RequestMapping(value="Reservation-date-search", method=RequestMethod.GET)//날짜예약
	public ModelAndView getReservationAvailableList(@RequestParam Map<String, Object> map, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if (session.getAttribute("user") != null
				&& !session.getAttribute("user").equals("")) {
			
//			if(map.get("year") != null){
//				List<Map<String, Object>> list = rService.getReservationAvailableList(map);
//				mav.addObject("Reservation", list);
//			}
			
			mav.setViewName("reservation/Reservation-date-search");
		} else {
			mav.setViewName("/user/login");
		}
		return mav;
	}
	@RequestMapping(value="Reservation-date-search", method=RequestMethod.POST)//날짜예약
	public ModelAndView postReservationAvailableList(@RequestParam Map<String, Object> map, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		List<Map<String, Object>> list = rService.getReservationAvailableList(map);
		mav.addObject("Reservation", list);
		System.out.println("con : "  + list);
//		System.out.println("Reservation");
		if (session.getAttribute("user") != null
				&& !session.getAttribute("user").equals("")) {
			mav.setViewName("reservation/Reservation-date-search");
		} else {
			mav.setViewName("/user/login");
		}
		return mav;
	}
	@RequestMapping(value="FinalReservation")//최종예약 아직 미완성
	public ModelAndView fReservationForm(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if (session.getAttribute("user") != null
				&& !session.getAttribute("user").equals("")) {
			mav.setViewName("reservation/FinalReservation");
		} else {
			mav.setViewName("/user/login");
		}
		return mav;
	}
	
	@RequestMapping(value="addReservation", method=RequestMethod.POST)
	public ModelAndView fReservation(@RequestParam Map<String, Object> map) {
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(rService.addReservation(map));
		mav.setViewName("JSON");
		
		return mav;
	}
	@RequestMapping(value="addFinalReservation", method=RequestMethod.POST)
	public ModelAndView FinalReservation(@ModelAttribute Datas datas) {
		System.out.println(datas);
		ModelAndView mav = new ModelAndView();
		
		mav.addAllObjects(rService.addFinalReservation(datas));
		mav.setViewName("JSON");
		
		return mav;
	}
	
	@RequestMapping(value="Reservation-location-search")//지역예약 시작
	public ModelAndView test(HttpSession session) {
	ModelAndView mav = new ModelAndView();
	if (session.getAttribute("user") != null
			&& !session.getAttribute("user").equals("")) {
		mav.setViewName("reservation/Reservation-location-search");
	} else {
		mav.setViewName("/user/login");
	}
	return mav;
	}
	@RequestMapping(value="calendar") // 지역 예약 달력 & 예약 리스트 조회
	public ModelAndView calendar(@RequestParam Map<String, Object> map, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("reservation/calendar");
		if (session.getAttribute("user") != null
				&& !session.getAttribute("user").equals("")) {
			mav.addObject("dateList", rService.getCalendar(map));
			mav.addAllObjects(WeatherInfo.weatherAndDay());
			mav.addAllObjects(WeatherInfo.weekWeather());
			mav.addAllObjects(rService.getReservationList(map));
			mav.addAllObjects(rService.getSiSeqNo(map));
		} else {
			mav.setViewName("/user/login");
		}
		return mav;
	}
	
	@RequestMapping(value="myReservation", method=RequestMethod.GET)
	public ModelAndView MyReservation(@RequestParam Map<String, Object> map, HttpSession session){
		ModelAndView mav = new ModelAndView();
		if (session.getAttribute("user") != null
				&& !session.getAttribute("user").equals("")) {
			
			map.put("id", session.getAttribute("id"));
			mav.addAllObjects(rService.getMyReservation(map));
			mav.setViewName("user/myReservation");
		} else {
			mav.setViewName("/user/login");
		}
//		mav.addObject("reservation", rService.getMyReservation(map, session));
		return mav;
	}
	
	@RequestMapping(value = "myReservation", method = RequestMethod.POST)
	public ModelAndView reservationDelete(
			@RequestParam Map<String, Object> map, HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(rService.reservationDelete(map));
		mav.setViewName("JSON");
		return mav;
		
	}
	
	@RequestMapping(value="MainSimpleReservation", method=RequestMethod.GET)
	public ModelAndView MainSimpleReservationForm(@RequestParam Map<String, Object> map, HttpSession session) {
		ModelAndView mav = new ModelAndView();
//		if (session.getAttribute("user") != null
//				&& !session.getAttribute("user").equals("")) {
//			
//			map.put("id", session.getAttribute("id"));
//			mav.addAllObjects(rService.getSimplelocationReservation(map));
//			mav.setViewName("reservation/MainSimpleReservation");
//		} else {
//			mav.setViewName("/user/login");
//		}
//		mav.addAllObjects(rService.getSimplelocationReservation(map));
		mav.setViewName("reservation/MainSimpleReservation");
		return mav;
	}
	
	@RequestMapping(value="MainSimpleReservation", method=RequestMethod.POST)
	public ModelAndView MainSimpleReservation(@RequestParam Map<String, Object> map) {
		
		ModelAndView mav = new ModelAndView();
		System.out.println(map.get("district"));
		if(map.get("district")!= null){
			mav.addAllObjects(rService.getSimplelocationReservation(map));
		}else if(map.get("stadiumName") != null){
			mav.addAllObjects(rService.getEachCourtNo(map));
			mav.addAllObjects(rService.getSimplelocationCourt(map));
		}
		mav.setViewName("JSON");
		return mav;
		
	}
	
	
}


