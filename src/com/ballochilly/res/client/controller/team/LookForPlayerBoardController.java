package com.ballochilly.res.client.controller.team;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ballochilly.res.client.service.team.LookForPlayerBoardService;

@Controller
public class LookForPlayerBoardController {
	
	@Autowired
	LookForPlayerBoardService lookForPlayerBoardService; 
	
	@RequestMapping(value = "lookForPlayerBoard", method = RequestMethod.GET)
	public ModelAndView lookForPlayerBoard(
			@RequestParam Map<String, Object> map) {
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(lookForPlayerBoardService.seletBoard(map));
		mav.setViewName("/team/lookForPlayerBoard");
		return mav;
		
	}
	
	@RequestMapping(value = "lookForPlayerBoardWrite", method = RequestMethod.GET)
	public ModelAndView lookForPlayerBoardWriteForm(
			@RequestParam Map<String, Object> map,
			HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		if (session.getAttribute("id") != null
				&& !session.getAttribute("id").equals("")) {
			mav.setViewName("/team/board/lookForPlayerBoardWrite");
		} else {
			mav.setViewName("/user/login");
		}
		return mav;
		
	}
	@RequestMapping(value = "lookForPlayerBoardDetail", method = RequestMethod.GET)
	public ModelAndView lookForPlayerBoardDetail(
			@RequestParam Map<String, Object> map) {
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(lookForPlayerBoardService.lookForPlayerBoardDetail(map));
		mav.addAllObjects(lookForPlayerBoardService.selectPlayerHireBoardReply(map));
		mav.setViewName("/team/board/lookForPlayerBoardDetail");
		return mav;
		
	}
	
	@RequestMapping(value = "lookForPlayerBoardWrite", method = RequestMethod.POST)
	public ModelAndView lookForPlayerBoardWrite(
			@RequestParam Map<String, Object> map,
			HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(lookForPlayerBoardService.insertBoard(map));
		mav.setViewName("JSON");
		return mav;
		
	}
	
	@RequestMapping(value = "lookForPlayerModify", method = RequestMethod.GET)
	public ModelAndView lookForPlayerModifyForm(
			@RequestParam Map<String, Object> map,
			HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(lookForPlayerBoardService.lookForPlayerBoardDetail(map));
		mav.setViewName("/team/board/lookForPlayerBoardModify");
		return mav;
		
	}
	
	@RequestMapping(value = "lookForPlayerModify", method = RequestMethod.POST)
	public ModelAndView lookForPlayerModify(
			@RequestParam Map<String, Object> map,
			HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(lookForPlayerBoardService.lookForPlayerBoardModify(map));
		mav.setViewName("JSON");
		return mav;
		
	}
	
	@RequestMapping(value = "replyInsert2", method = RequestMethod.POST)
	public ModelAndView replyInsert(
			@RequestParam Map<String, Object> map,
			HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(lookForPlayerBoardService.replyInsert(map));
		mav.setViewName("JSON");
		return mav;
		
	}
	
	@RequestMapping(value = "deleteReply2", method = RequestMethod.POST)
	public ModelAndView replyDelete(
			@RequestParam Map<String, Object> map,
			HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(lookForPlayerBoardService.replyDelete(map));
		mav.setViewName("JSON");
		return mav;
		
	}
	
	@RequestMapping(value = "modiftyReply2", method = RequestMethod.POST)
	public ModelAndView modiftyReply(
			@RequestParam Map<String, Object> map,
			HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(lookForPlayerBoardService.modiftyReply(map));
		mav.setViewName("JSON");
		return mav;
		
	}
	
	@RequestMapping(value = "updateHit2", method = RequestMethod.POST)
	public ModelAndView updateHit(
			@RequestParam Map<String, Object> map,
			HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(lookForPlayerBoardService.updateHit(map));
		mav.setViewName("JSON");
		return mav;
		
	}

}
