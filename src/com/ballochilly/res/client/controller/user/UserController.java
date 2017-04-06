package com.ballochilly.res.client.controller.user;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ballochilly.res.client.service.team.TeamService;
import com.ballochilly.res.client.service.user.UserService;

@Controller
public class UserController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	TeamService teamService; 
	
	/*
	 * 회원가입 폼
	 */
	@RequestMapping(value = "joinMember", method = RequestMethod.GET)
	public ModelAndView joinMemberForm(
			@RequestParam Map<String, Object> map) {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/user/joinMember");
		return mav;
		
	}
	
	/*
	 * 팝업
	 */
	@RequestMapping(value = "popPage", method = RequestMethod.GET)
	public ModelAndView popPage(
			@RequestParam Map<String, Object> map) {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/sub/popPage");
		return mav;
		
	}
	
	/*
	 * 회원가입
	 * 실제로 회원가입이 되는 로직이 들어 있는 메소드
	 */
	@RequestMapping(value = "joinMember", method = RequestMethod.POST)
	public ModelAndView joinMember(
			@RequestParam Map<String, Object> map) {
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(userService.addUser(map));
		mav.setViewName("JSON");
		return mav;
		
	}
	/*
	 * 아이디 중복체크
	 */
	@RequestMapping(value = "isExistId", method = RequestMethod.POST)
	public ModelAndView isExistId(
			@RequestParam Map<String, Object> map) {
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(userService.isExistId(map));
		mav.setViewName("JSON");
		return mav;
	}
	
	/*
	 * ID / 비번 찾기 폼
	 */
	@RequestMapping(value = "serachForInfo", method = RequestMethod.GET)
	public ModelAndView serachForInfo(
			@RequestParam Map<String, Object> map) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/user/serachForInfo");
		return mav;
	}
	
	/*
	 * 아이디 찾기
	 */
	@RequestMapping(value = "searchId", method = RequestMethod.POST)
	public ModelAndView searchId(
			@RequestParam Map<String, Object> map) {
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(userService.searchId(map));
		mav.setViewName("JSON");
		return mav;
	}
	/*
	 * 임시비번전송을 위한 이멜찾기
	 */
	@RequestMapping(value = "searchEmail", method = RequestMethod.POST)
	public ModelAndView searchEmail(
			@RequestParam Map<String, Object> map) {
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(userService.searchEmail(map));
		mav.setViewName("JSON");
		return mav;
	}
	/*
	 * 이메일 전송
	 */
	@RequestMapping(value = "sendMail.do", method = RequestMethod.POST)
	public ModelAndView sendMail(
			@RequestParam(value="email", required=false) String email
										, Map<String, Object> resMap){
		
		ModelAndView mav = new ModelAndView();
		// 1. 받을사람의 이메일 주소를 생성한다.
		String[] receivers = new String[]{
				email 
		};
		
		userService.tempPassword(receivers, email, resMap) ;
		mav.setViewName("JSON");
		return mav;
	}
	/*
	 * 로그인폼
	 */
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public ModelAndView loginForm(
			@RequestParam Map<String, Object> map,
			HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		if (session.getAttribute("id") != null
				&& !session.getAttribute("id").equals("")) {
			mav.setViewName("redirect:main.do");
		} else {
			mav.setViewName("/user/login");
		}
		return mav;
	}
	/*
	 * 실제 로그인이 되는 로직이 들어 있는 메소드
	 */
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public ModelAndView login(
			@RequestParam Map<String, Object> map,
			HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		System.out.println("session : " + session.getAttribute("user"));
		
		Map<String, Object> resultMap = userService.login(map);
		if (resultMap.get("user") != null) {
			
			session.setAttribute("user", resultMap.get("user"));
			session.setAttribute("id", map.get("id"));
			session.setMaxInactiveInterval(60*60); //세션한시간유지
		}
		mav.addAllObjects(resultMap);
		mav.setViewName("JSON");
		return mav;
	}
	
	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public ModelAndView logout(HttpSession session
			, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView();
		session.removeAttribute("user");
		session.removeAttribute("id");
		
		String backPage = request.getHeader("referer");
		mav.setViewName("redirect:" + backPage);
		return mav;

	}
	
	@RequestMapping(value = "modifyInfo", method = RequestMethod.GET)
	public ModelAndView modifyInfoForm(
			@RequestParam Map<String, Object> map,
			HttpSession session) {
		
//		System.out.println("map : " + map);
		ModelAndView mav = new ModelAndView();
		
		if (session.getAttribute("user") != null
				&& !session.getAttribute("user").equals("")) {
//			System.out.println("map : " + map);
//			Map<String, Object> resultMap = userService.getUser(map);
//			mav.addAllObjects(resultMap);
			mav.setViewName("/user/modifyInfo");
			
		} else {
			
			mav.setViewName("/user/login");
			
		}
		return mav;
	}
	
	@RequestMapping(value = "modifyPw", method = RequestMethod.GET)
	public ModelAndView modifyPwForm(
			@RequestParam Map<String, Object> map,
			HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		
		if (session.getAttribute("user") != null
				&& !session.getAttribute("user").equals("")) {
			mav.setViewName("/user/modifyPw");
		} else {
			mav.setViewName("/user/login");
		}
		
		return mav;
	}
	
//	@RequestMapping(value = "modifyPwPage", method = RequestMethod.GET)
//	public ModelAndView modifyPwPage(
//			@RequestParam Map<String, Object> map) {
//		
//		ModelAndView mav = new ModelAndView();
//		mav.addAllObjects(userService.selectPw(map));
//		mav.setViewName("JSON");
//		return mav;
//	}
	@RequestMapping(value = "modifyPwPage", method = RequestMethod.POST)
	public ModelAndView modifyPwPage(
			@RequestParam Map<String, Object> map) {
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(userService.selectPw(map));
		mav.setViewName("JSON");
		return mav;
	}
	
	@RequestMapping(value = "modifyPw", method = RequestMethod.POST)
	public ModelAndView modifyPw(
			@RequestParam Map<String, Object> map) {
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(userService.modifyPw(map));
		mav.addAllObjects(userService.getUser(map));
		mav.setViewName("JSON");
		return mav;
	}
	
	@RequestMapping(value = "modifyInfo", method = RequestMethod.POST)
	public ModelAndView modifyInfo(
			@RequestParam Map<String, Object> map,
			HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(userService.modifyUserInfo(map));
		mav.setViewName("JSON");
		return mav;
	}
	
	/*
	 * 메시지함 보기(신청받은 경우)
	 */
	@RequestMapping(value = "message", method = RequestMethod.GET)
	public ModelAndView message(
			@RequestParam Map<String, Object> map,
			HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		map.put("id", session.getAttribute("id"));
		if (session.getAttribute("id") != null
				&& !session.getAttribute("id").equals("")) {
			mav.addAllObjects(userService.myNote(map));
			mav.addAllObjects(userService.sendNote(map));
			mav.addAllObjects(userService.message(map));
			mav.setViewName("/user/message");
		} else {
			
			mav.setViewName("/user/login");
			
		}
		return mav;
		
	}
	
	/*
	 * 메시지 디테일
	 */
	@RequestMapping(value = "msgDetailPop", method = RequestMethod.GET)
	public ModelAndView msgDetailPopForm(
			@RequestParam Map<String, Object> map,
			HttpSession session){
		
		ModelAndView mav = new ModelAndView();
		map.put("id", session.getAttribute("id"));
		mav.addAllObjects(userService.msgDetail(map));
		mav.addAllObjects(teamService.selectTeam(map));
		mav.setViewName("/user/msgDetailPop");
		return mav;
		
	}
	
	@RequestMapping(value = "userTeam", method = RequestMethod.GET)
	public ModelAndView userTeamForm(
			@RequestParam Map<String, Object> map, 
			HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		
		if (session.getAttribute("id") != null
				&& !session.getAttribute("id").equals("")) {
			map.put("id", session.getAttribute("id"));
			mav.addAllObjects(userService.myTeamList(map));
			mav.setViewName("/user/userTeam");
		} else {
			mav.setViewName("/user/login");
		}
		return mav;
		
	}
	
	@RequestMapping(value = "deleteMsg", method = RequestMethod.POST)
	public ModelAndView deleteMsg(
			@RequestParam Map<String, Object> map){
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(userService.deleteMsg(map));
		mav.setViewName("JSON");
		return mav;
	}
	
	@RequestMapping(value = "dropOut", method = RequestMethod.POST)
	public ModelAndView dropOut(
			@RequestParam Map<String, Object> map){
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(userService.dropOut(map));
		mav.setViewName("JSON");
		return mav;
	}
	
	@RequestMapping(value = "teamDelete", method = RequestMethod.POST)
	public ModelAndView teamDelete(
			@RequestParam Map<String, Object> map){
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(userService.teamDelete(map));
		mav.setViewName("JSON");
		return mav;
	}
	
	@RequestMapping(value = "insertNote", method = RequestMethod.POST)
	public ModelAndView insertNote(
			@RequestParam Map<String, Object> map){
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(userService.insertNote(map));
		mav.setViewName("JSON");
		return mav;
	}
	
	/*
	 * 메시지 디테일
	 */
	@RequestMapping(value = "myNoteDetail", method = RequestMethod.GET)
	public ModelAndView myNoteDetailForm(
			@RequestParam Map<String, Object> map,
			HttpSession session){
		
		ModelAndView mav = new ModelAndView();
		map.put("id", session.getAttribute("id"));
		mav.addAllObjects(userService.myNoteDetail(map));
		mav.setViewName("/user/myNoteDetail");
		return mav;
		
	}
	
	@RequestMapping(value = "returnMsg", method = RequestMethod.GET)
	public ModelAndView returnMsg(
			@RequestParam Map<String, Object> map,
			HttpSession session){
		
		ModelAndView mav = new ModelAndView();
		map.put("id", session.getAttribute("id"));
		mav.setViewName("/user/returnMsg");
		return mav;
		
	}
	
	@RequestMapping(value = "returnNote", method = RequestMethod.POST)
	public ModelAndView returnNote(
			@RequestParam Map<String, Object> map){
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(userService.insertNote(map));
		mav.setViewName("JSON");
		return mav;
		
	}
	
	@RequestMapping(value = "deleteNote", method = RequestMethod.POST)
	public ModelAndView deleteNote(
			@RequestParam Map<String, Object> map){
		
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(userService.deleteNote(map));
		mav.setViewName("JSON");
		return mav;
	}
	
	@RequestMapping(value = "weather", method = RequestMethod.GET)
	public ModelAndView weather(
			@RequestParam Map<String, Object> map){
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/main/weather");
		return mav;
	}
	
}





