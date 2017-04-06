package com.ballochilly.res.admin.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ballochilly.res.admin.service.MasterService;
import com.ballochilly.res.common.Cal;

@Controller
public class MasterController {
	
	@Autowired
	MasterService mService;
	
	@RequestMapping(value = "masterLogin", method = RequestMethod.POST)
	public ModelAndView masterLogin(
			@RequestParam Map<String, Object> map,
			HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		
		System.out.println("session : " + session.getAttribute("master"));
		
		Map<String, Object> resultMap = mService.masterLogin(map);
		if (resultMap.get("master") != null) {
			
			session.setAttribute("master", resultMap.get("master"));
			map.put("masterName", ((Map) session.getAttribute("master")).get("MASTER_ID"));
			System.out.println(resultMap.get("master"));
		}
		mav.addAllObjects(resultMap);
		mav.setViewName("JSON");
		return mav;
	}
	
	@RequestMapping(value = "masterLogout", method = RequestMethod.GET)
	public ModelAndView masterLogout(
			HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		session.removeAttribute("master");
		mav.setViewName("redirect:main.do");
		return mav;
	}
	
	@RequestMapping(value = "reservationDetailPop", method = RequestMethod.GET)
	public ModelAndView reservationDetailPop(
			@RequestParam Map<String, Object> map,
			HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(mService.myReservation(map));
		mav.addAllObjects(mService.cntCourt(map));
		mav.setViewName("/master/reservationDetailPop");
		return mav;
	}
	
	@RequestMapping(value = "selectSiSeqNo", method = RequestMethod.POST)
	public ModelAndView selectSiSeqNo(@RequestParam Map<String, Object> map) {
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(mService.selectSiNumber(map));
		mav.setViewName("JSON");
		return mav;
	}
	
	@RequestMapping(value = "masterReservation", method = RequestMethod.POST)
	public ModelAndView masterReservation(@RequestParam Map<String, Object> map) {
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(mService.masterReservation(map));
		mav.setViewName("JSON");
		return mav;
	}
	
	@RequestMapping(value = "masterDelete", method = RequestMethod.POST)
	public ModelAndView masterDelete(@RequestParam Map<String, Object> map) {
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(mService.masterDelete(map));
		mav.setViewName("JSON");
		return mav;
	}
	
	@RequestMapping(value = "userInfo", method = RequestMethod.POST)
	public ModelAndView selectReservationUserInfo(@RequestParam Map<String, Object> map) {
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(mService.selectReservationUserInfo(map));
		mav.setViewName("JSON");
		return mav;
		
	}

}
