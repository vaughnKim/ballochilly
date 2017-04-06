package com.ballochilly.res.client.controller.community;

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

import com.ballochilly.res.client.service.community.VideoService;

@Controller
public class VideoController {
	
	@Autowired
	VideoService videoService;
	
	@RequestMapping(value="videoBoard", method=RequestMethod.GET)
	public ModelAndView videoBoard(
			@RequestParam Map<String, Object> map,
			HttpServletRequest req) {
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(videoService.selectAllVideoBoard(map, req));
		mav.setViewName("/community/videoBoard");
		
		return mav;
	}
	
	@RequestMapping(value="videoAddBoard", method=RequestMethod.GET)
//	public String videoAddBoardForm() {
	public ModelAndView videoAddBoardForm(
			@RequestParam Map<String, Object> map,
			HttpSession session) {
		
		System.out.println("###########################");
		System.out.println("videoAddBoardForm GET ");
		
		ModelAndView mav = new ModelAndView();
		if(session.getAttribute("id") != null &&
				! session.getAttribute("id").equals("")) {
			mav.setViewName("/community/videoAddBoard");
		} else {
			mav.setViewName("/user/login");
		}
		return mav;
//		return "/community/videoAddBoard.do";
	}
	
	@RequestMapping(value="videoAddBoard", method=RequestMethod.POST)
	public ModelAndView videoAddBoard(
			@RequestParam Map<String, Object> map,
			HttpServletRequest req,
			MultipartHttpServletRequest mReq) {
		
		System.out.println("###########################");
		System.out.println("videoAddBoard POST ");
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(videoService.addVideoBoard(map, req, mReq));
		mav.setViewName("JSON");
		
		return mav;
	}
	
	@RequestMapping(value="videoDetailBoard")
	public ModelAndView videoDetailBoard(
			@RequestParam Map<String, Object> map,
			HttpServletRequest req){
		
		ModelAndView mav = new ModelAndView();
		
		System.out.print("##########");
		System.out.println("getEachStadiumBoardForm GET");
		
		mav.addAllObjects(videoService.selectEachVideoBoard(map));
		mav.setViewName("/community/videoDetailBoard");
		return mav; 
	}
	
	@RequestMapping(value="editVideoBoard", method=RequestMethod.POST)
	public ModelAndView editVideoBoard(
			@RequestParam Map<String, Object> map,
			HttpServletRequest req,
			MultipartHttpServletRequest mReq){
		
		ModelAndView mav = new ModelAndView();
		
		System.out.print("##########");
		System.out.println("editVideoBoard POST");
		
		mav.addAllObjects(videoService.editVideoBoard(map, req, mReq));
		mav.setViewName("JSON");
		return mav; 
	}
	
	@RequestMapping(value="deleteVideoBoard", method=RequestMethod.POST)
	public ModelAndView deleteVideoBoard(
			@RequestParam Map<String, Object> map){
		
		ModelAndView mav = new ModelAndView();
		
		System.out.print("##########");
		System.out.println("deleteVideoBoard POST");
		
		mav.addAllObjects(videoService.deleteVideoBoard(map));
		mav.setViewName("JSON");
		return mav; 
	}

	@RequestMapping(value="addCommentVideoBoard", method=RequestMethod.POST)
	public ModelAndView addCommentVideoBoard (
			@RequestParam Map<String, Object> map,
			HttpServletRequest req){
		
		ModelAndView mav = new ModelAndView();
		
		System.out.println("##############");
		System.out.println("addCommentVideoBoard POST");
		
		mav.addAllObjects(videoService.addCommentVideoBoard(map, req));
		mav.setViewName("JSON");
		return mav;
	}
	
	@RequestMapping(value="editCommentVideoBoard", method=RequestMethod.POST)
	public ModelAndView editCommentVideoBoard(
			@RequestParam Map<String, Object> map,
			HttpServletRequest req) {
		
		ModelAndView mav = new ModelAndView();
		
		System.out.println("##############");
		System.out.println("editCommentVideoBoard POST");
		
		mav.addAllObjects(videoService.editCommentVideoBoard(map, req));
		mav.setViewName("JSON");
		return mav;
	}
	
	
	@RequestMapping(value="deleteCommentVideoBoard", method=RequestMethod.POST)
	public ModelAndView deleteCommentVideoBoard(
			@RequestParam Map<String, Object> map) {
		
		ModelAndView mav = new ModelAndView();
		
		System.out.println("##############");
		System.out.println("deleteCommentVideoBoard POST");
		
		mav.addAllObjects(videoService.deleteCommentVideoBoard(map));
		mav.setViewName("JSON");
		return mav;
	}
}
