package com.ballochilly.res.client.controller.stadium;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.ballochilly.res.client.service.stadium.StadiumService;




@Controller
public class StadiumController {
	
	@Autowired
	StadiumService stadiumService;

	
	@RequestMapping(value="add", method=RequestMethod.GET)
	public ModelAndView AddStadiumForm(){
		
		ModelAndView mav = new ModelAndView();
		
		System.out.print("##########");
		System.out.println("AddStadiumForm GET");
		
		mav.setViewName("/stadium/add");
		return mav; 
	}
	
	@RequestMapping(value="add", method=RequestMethod.POST)
	public ModelAndView AddStadium(
			@RequestParam Map<String, Object> map,
			MultipartHttpServletRequest mRequest,
			HttpServletRequest req){
		
		ModelAndView mav = new ModelAndView();
		
		System.out.print("##########");
		System.out.println("AddStadium POST");
		
		mav.addAllObjects(stadiumService.AddStadium(map, mRequest, req));
		mav.setViewName("JSON");
		return mav; 
	}
	
	
	@RequestMapping(value="editAdd", method=RequestMethod.GET)
	public ModelAndView editAddStadiumForm(
			@RequestParam Map<String, Object> map){
		
		ModelAndView mav = new ModelAndView();
		
		System.out.print("##########");
		System.out.println("editAddStadiumForm GET");
		mav.addAllObjects(stadiumService.selectEachStadium(map));
		
		mav.setViewName("/stadium/editAdd");
		return mav; 
	}
	
	@RequestMapping(value="editAdd", method=RequestMethod.POST)
	public ModelAndView editAddStadium(
			@RequestParam Map<String, Object> map,
			MultipartHttpServletRequest mRequest,
			HttpServletRequest req){
		
		ModelAndView mav = new ModelAndView();
		
		System.out.print("##########");
		System.out.println("editAddStadium POST");
		
		mav.addAllObjects(stadiumService.editAddStadium(map, mRequest, req));
		mav.setViewName("JSON");
		return mav; 
	}
	
	@RequestMapping(value="deleteAdd", method=RequestMethod.POST)
	public ModelAndView deleteAddStadium(
			@RequestParam Map<String, Object> map){
		
		ModelAndView mav = new ModelAndView();
		
		System.out.print("##########");
		System.out.println("deleteAddStadium POST");
		
		mav.addAllObjects(stadiumService.deleteEachStadium(map));
		mav.setViewName("JSON");
		return mav; 
	}
	
	@RequestMapping(value="allStadiumList", method=RequestMethod.GET)
	public ModelAndView AllStadiumForm(
			@RequestParam Map<String, Object> map,
			HttpServletRequest req){
		
		ModelAndView mav = new ModelAndView();
		
		System.out.print("##########");
		System.out.println("AllStadiumList GET");
		
		mav.addAllObjects(stadiumService.selectAllStadium(map, req));
		mav.setViewName("/stadium/allStadiumList");
		return mav; 
	}
	
	@RequestMapping(value="eachStadiumInfo", method=RequestMethod.GET)
	public ModelAndView EachStadiumInfoForm(
			@RequestParam Map<String, Object> map,
			HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		
//		System.out.print("##########");
//		System.out.println("EachStadiumInfoForm GET");
//		System.out.println("^^^^^^^^^^^^^" + session.getAttribute("master"));
		mav.addAllObjects(stadiumService.selectEachStadium(map));
		mav.setViewName("/stadium/eachStadiumInfo");
		
		return mav;
	}
	
	@RequestMapping(value="eachStadiumInfo", method=RequestMethod.POST)
	public ModelAndView EachStadiumInfo(
			@RequestParam Map<String, Object> map) {
		
		ModelAndView mav = new ModelAndView();
		
		System.out.print("##########");
		System.out.println("EachStadiumInfo POST");
		
		mav.addAllObjects(stadiumService.selectEachStadium(map));
		mav.setViewName("JSON");
		
		return mav;
	}
	
	
}
