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

import com.ballochilly.res.client.dao.stadium.StadiumBoardDao;
import com.ballochilly.res.client.service.stadium.StadiumBoardService;



@Controller
public class StadiumBoardController {
	
	@Autowired
	StadiumBoardService stadiumboardService;
	
	@Autowired
	StadiumBoardDao stadiumboardDao;
	
	@RequestMapping(value="addBoard", method=RequestMethod.GET)
	public ModelAndView AddStadiumBoardForm(HttpSession session){
		
		ModelAndView mav = new ModelAndView();
		
		System.out.print("##########");
		System.out.println("AddStadiumBoardForm GET");
		System.out.println(session.getAttribute("id"));
		if(session.getAttribute("id") != null && !session.getAttribute("id").equals("")) {
			mav.setViewName("/stadiumBoard/addBoard");
		} else {
			mav.setViewName("/user/login");
		}
		
		return mav; 
	}
	
	@RequestMapping(value="addBoard", method=RequestMethod.POST)
	public ModelAndView AddStadiumBoard(
			@RequestParam Map<String, Object> map,
			MultipartHttpServletRequest mRequest,
			HttpServletRequest req){
		
		ModelAndView mav = new ModelAndView();
		
		System.out.print("##########");
		System.out.println("AddStadiumBoardForm POST");
		
		mav.addAllObjects(stadiumboardService.AddStadiumBoard(map, mRequest, req));
		mav.setViewName("JSON");
		return mav; 
	}
	
	@RequestMapping(value="listBoard", method=RequestMethod.GET)
	public ModelAndView AllStadiumBoardForm(
			@RequestParam Map<String, Object> map,
			HttpServletRequest req){
		
		ModelAndView mav = new ModelAndView();
		
		System.out.print("##########");
		System.out.println("AllStadiumBoardForm GET");
		
		mav.addAllObjects(stadiumboardService.selectAllStadiumBoard(map,req));
		mav.setViewName("/stadiumBoard/listBoard");
		return mav; 
	}
	
	@RequestMapping(value="viewBoard")
	public ModelAndView getEachStadiumBoardForm(
			@RequestParam Map<String, Object> map,
			HttpServletRequest req){
		
		ModelAndView mav = new ModelAndView();
		
//		System.out.println("test : " + req.getSession().getAttribute("master"));
		
		System.out.print("##########");
		System.out.println("getEachStadiumBoardForm GET");
		
		mav.addAllObjects(stadiumboardService.selectEachStadiumBoard(map, req));
		mav.setViewName("/stadiumBoard/viewBoard");
		return mav; 
	}
	
	@RequestMapping(value="editBoard", method=RequestMethod.POST)
	public ModelAndView editStadiumBoard (
			@RequestParam Map<String, Object> map,
			MultipartHttpServletRequest mReq,
			HttpServletRequest req){
		
		ModelAndView mav = new ModelAndView();
		
		System.out.println("##############");
		System.out.println("editStadiumBoard POST");
		System.out.println("map : " + map);
		System.out.println(mReq);
		
		mav.addAllObjects(stadiumboardService.editStadiumBoard(map, mReq, req));
		mav.setViewName("JSON");
		return mav;
	}
	
	@RequestMapping(value="deleteBoard", method=RequestMethod.POST)
	public ModelAndView deleteStadiumBoard (
			@RequestParam Map<String, Object> map){
		
		ModelAndView mav = new ModelAndView();
		
		System.out.println("##############");
		System.out.println("deleteStadiumBoard POST");
		
		mav.addAllObjects(stadiumboardService.deleteStadiumBoard(map));
		mav.setViewName("JSON");
		return mav;
	}
	
	@RequestMapping(value="addCommentBoard", method=RequestMethod.POST)
	public ModelAndView addCommentBoard (
			@RequestParam Map<String, Object> map, HttpServletRequest req){
		
		ModelAndView mav = new ModelAndView();
		
		System.out.println("##############");
		System.out.println("addCommentBoard POST");
		
		mav.addAllObjects(stadiumboardService.addCommentBoard(map, req));
		mav.setViewName("JSON");
		return mav;
	}
	
	@RequestMapping(value="editComment", method=RequestMethod.POST)
	public ModelAndView editComment(
			@RequestParam Map<String, Object> map, HttpServletRequest req) {
		
		ModelAndView mav = new ModelAndView();
		
		System.out.println("##############");
		System.out.println("editComment POST");
		
		mav.addAllObjects(stadiumboardService.editCommentBoard(map, req));
		mav.setViewName("JSON");
		return mav;
	}
	
	
	@RequestMapping(value="deleteComment", method=RequestMethod.POST)
	public ModelAndView deleteComment(
			@RequestParam Map<String, Object> map) {
		
		ModelAndView mav = new ModelAndView();
		
		System.out.println("##############");
		System.out.println("deleteComment POST");
		
		mav.addAllObjects(stadiumboardService.deleteCommentBoard(map));
		mav.setViewName("JSON");
		return mav;
	}
	
}
