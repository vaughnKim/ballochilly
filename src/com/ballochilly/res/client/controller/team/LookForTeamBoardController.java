package com.ballochilly.res.client.controller.team;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ballochilly.res.client.dao.team.LookForTeamBoardDao;
import com.ballochilly.res.client.service.team.LookForTeamBoardService;

@Controller
public class LookForTeamBoardController {
	
	@Autowired
	LookForTeamBoardService lookForTeamBoardService; 
	
	@RequestMapping(value = "lookForTeamBoard", method = RequestMethod.GET)
	public ModelAndView lookForTeamBoard(
			@RequestParam Map<String, Object> map) {
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(lookForTeamBoardService.seletBoard(map));
		mav.setViewName("/team/lookForTeamBoard");
		return mav;
		
	}
	
	@RequestMapping(value = "lookForTeamBoardWrite", method = RequestMethod.GET)
	public ModelAndView lookForTeamBoardWriteForm(
			@RequestParam Map<String, Object> map,
			HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		if (session.getAttribute("id") != null
				&& !session.getAttribute("id").equals("")) {
			mav.setViewName("/team/board/lookForTeamBoardWrite");
		} else {
			mav.setViewName("/user/login");
		}
		return mav;
		
	}
	@RequestMapping(value = "lookForTeamBoardDetail", method = RequestMethod.GET)
	public ModelAndView lookForTeamBoardDetail(
			@RequestParam Map<String, Object> map) {
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(lookForTeamBoardService.lookForTeamBoardDetail(map));
		mav.addAllObjects(lookForTeamBoardService.selectTeamHireBoardReply(map));
		mav.setViewName("/team/board/lookForTeamBoardDetail");
		return mav;
		
	}
	
	@RequestMapping(value = "lookForTeamBoardWrite", method = RequestMethod.POST)
	public ModelAndView lookForTeamBoardWrite(
			@RequestParam Map<String, Object> map,
			HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(lookForTeamBoardService.insertBoard(map));
		mav.setViewName("JSON");
		return mav;
		
	}
	
	@RequestMapping(value = "lookForTeamModify", method = RequestMethod.GET)
	public ModelAndView lookForTeamModifyForm(
			@RequestParam Map<String, Object> map,
			HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(lookForTeamBoardService.lookForTeamBoardDetail(map));
		mav.setViewName("/team/board/lookForTeamBoardModify");
		return mav;
		
	}
	
	@RequestMapping(value = "lookForTeamModify", method = RequestMethod.POST)
	public ModelAndView lookForTeamModify(
			@RequestParam Map<String, Object> map,
			HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(lookForTeamBoardService.lookForTeamBoardModify(map));
		mav.setViewName("JSON");
		return mav;
		
	}
	
	@RequestMapping(value = "replyInsert", method = RequestMethod.POST)
	public ModelAndView replyInsert(
			@RequestParam Map<String, Object> map,
			HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(lookForTeamBoardService.replyInsert(map));
		mav.setViewName("JSON");
		return mav;
		
	}
	
	@RequestMapping(value = "deleteReply", method = RequestMethod.POST)
	public ModelAndView replyDelete(
			@RequestParam Map<String, Object> map,
			HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(lookForTeamBoardService.replyDelete(map));
		mav.setViewName("JSON");
		return mav;
		
	}
	
	@RequestMapping(value = "modiftyReply", method = RequestMethod.POST)
	public ModelAndView modiftyReply(
			@RequestParam Map<String, Object> map,
			HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(lookForTeamBoardService.modiftyReply(map));
		mav.setViewName("JSON");
		return mav;
		
	}
	
	@RequestMapping(value = "updateHit", method = RequestMethod.POST)
	public ModelAndView updateHit(
			@RequestParam Map<String, Object> map,
			HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(lookForTeamBoardService.updateHit(map));
		mav.setViewName("JSON");
		return mav;
		
	}
	
	
	@RequestMapping(value = "deleteList", method = RequestMethod.POST)
	public ModelAndView deleteList(
			@RequestParam Map<String, Object> map,
			HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(lookForTeamBoardService.deleteList(map));
		mav.setViewName("JSON");
		return mav;
		
	}
	
	@RequestMapping(value = "cmtOfCmt", method = RequestMethod.POST)
	public ModelAndView cmtOfCmt(
			@RequestParam Map<String, Object> map,
			HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(lookForTeamBoardService.cmtOfCmt(map));
		mav.setViewName("JSON");
		return mav;
		
	}
	
	
	

}
