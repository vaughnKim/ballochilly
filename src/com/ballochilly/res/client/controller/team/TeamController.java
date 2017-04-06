package com.ballochilly.res.client.controller.team;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.ballochilly.res.client.service.team.TeamService;

@Controller
public class TeamController {
	
	@Autowired
	TeamService teamService;
	
	/*
	 * 팀 등록 폼
	 */
	@RequestMapping(value = "teamRegister", method = RequestMethod.GET)
	public ModelAndView teamRegisterForm(
			@RequestParam Map<String, Object> map, 
			HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		
		if (session.getAttribute("id") != null
				&& !session.getAttribute("id").equals("")) {
			mav.setViewName("/team/teamRegister");
		} else {
			mav.setViewName("/user/login");
		}
		return mav;
		
	}
	/*
	 * 팀 등록 ajax
	 */
	@RequestMapping(value = "teamRegister", method = RequestMethod.POST)
	public ModelAndView teamRegister(
			MultipartHttpServletRequest mRequest,
			@RequestParam Map<String, Object> map) {
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(teamService.insertTeam(map, mRequest));
		mav.setViewName("JSON");
		return mav;
		
	}
	/*
	 * 팀 이름 중복체크
	 */
	@RequestMapping(value = "isExistTeamName", method = RequestMethod.POST)
	public ModelAndView isExistTeamName(
			@RequestParam Map<String, Object> map) {
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(teamService.isExistTeamName(map));
		mav.setViewName("JSON");
		return mav;
		
	}
	
	/*
	 * 팀 정보 폼
	 */
	@RequestMapping(value = "teamInfo", method = RequestMethod.GET)
	public ModelAndView teamInfoForm(
			@RequestParam Map<String, Object> map){
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(teamService.teamList(map));
		mav.setViewName("/team/teamInfo");
		return mav;
		
	}
	/*
	 * 팀 상세보기 페이지 폼
	 */
	@RequestMapping(value = "teamDetail", method = RequestMethod.GET)
	public ModelAndView teamDetailForm(
			@RequestParam Map<String, Object> map){
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(teamService.teamDetail(map));
		mav.addAllObjects(teamService.countTeamMember(map));
		mav.setViewName("/team/teamDetail");
		return mav;
	}
	/*
	 * 팀 정보 수정
	 */
	@RequestMapping(value = "teamModify", method = RequestMethod.GET)
	public ModelAndView teamModifyForm(
			@RequestParam Map<String, Object> map){
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(teamService.teamModify(map));
		mav.addAllObjects(teamService.countTeamMember(map));
		mav.setViewName("/team/teamModify");
		return mav;
	}
	
	@RequestMapping(value = "teamModify", method = RequestMethod.POST)
	public ModelAndView teamModify(@RequestParam Map<String, Object> map){
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(teamService.updateTeam(map));
		mav.setViewName("JSON");
		return mav;
	}
	
	@RequestMapping(value = "updateEmblemTeam", method = RequestMethod.POST)
	public ModelAndView updateEmblemTeam(
			MultipartHttpServletRequest mRequest,
			@RequestParam Map<String, Object> map){
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(teamService.updateEmblemTeam(map, mRequest));
		mav.setViewName("JSON");
		return mav;
	}
	
	/*
	 * 팀 가입신청 메시지 보내기
	 */
	@RequestMapping(value = "joinTeamMessage", method = RequestMethod.POST)
	public ModelAndView joinTeamMessage(
			@RequestParam Map<String, Object> map){
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(teamService.joinTeamMessage(map));
		mav.setViewName("JSON");
		return mav;
	}
	
	/*
	 *  팀 가입신청 할 때 이미 가입한 팀일 경우
	 */
	@RequestMapping(value = "alreadyJoinTeam", method = RequestMethod.POST)
	public ModelAndView alreadyJoinTeam(
			@RequestParam Map<String, Object> map){
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(teamService.alreadyJoinTeam(map));
		mav.setViewName("JSON");
		return mav;
		
	}
	
	
	/*
	 * 팀 멤버 가입 완료
	 */
	@RequestMapping(value = "approveTeam", method = RequestMethod.POST)
	public ModelAndView approveTeamForm(
			@RequestParam Map<String, Object> map) {
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(teamService.insertTeamMember(map));
		mav.setViewName("JSON");
		return mav;
		
	}
	
	/*
	 * 팀 멤버 거절
	 */
	@RequestMapping(value = "rejectTeam", method = RequestMethod.POST)
	public ModelAndView rejectTeamForm(
			@RequestParam Map<String, Object> map) {
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(teamService.rejectMsg(map));
		mav.setViewName("JSON");
		return mav;
		
	}
	
	/*
	 * 팀 승인 여부 확인하기 위해서
	 */
	@RequestMapping(value = "isExistTeamMember", method = RequestMethod.POST)
	public ModelAndView msgDetailPop(
			@RequestParam Map<String, Object> map){
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(teamService.isExistTeamMember(map));
		mav.setViewName("JSON");
		return mav;
		
	}
	
	@RequestMapping(value = "updateMsgYnState", method = RequestMethod.POST)
	public ModelAndView updateMsgYnState(
			@RequestParam Map<String, Object> map){
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(teamService.updateMsgYnState(map));
		mav.setViewName("JSON");
		return mav;
		
	}
	
	@RequestMapping(value="fileUpload.do", method=RequestMethod.POST)
	public ModelAndView fileUpload(
			MultipartHttpServletRequest mRequest) {
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(teamService.fileUpload(mRequest));
		mav.setViewName("JSON");
		
		return mav;
		
	}	
	
}




