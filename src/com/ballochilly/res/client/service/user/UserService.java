package com.ballochilly.res.client.service.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ballochilly.res.client.dao.user.UserDao;
import com.ballochilly.res.common.BallochillyMailer;
import com.ballochilly.res.common.Util;

@Service
public class UserService {
	
	@Autowired
	UserDao userDao;
	
	@Autowired
	VelocityEngine velocityEngine;	
	
	/*
	 * 회원가입
	 */
	public Map<String, Object> addUser(Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		int result = userDao.insertUser(map);
		
		if(result > 0) {
			returnMap.put("msg", "회원가입 완료");
			returnMap.put("code", 200);
		} else {
			returnMap.put("msg", "실패");
			returnMap.put("code", 201);
		}

		return returnMap;
		
	}
	
	public Map<String, Object> isExistId(Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		int result = userDao.isExistId(map);
		
		if(result > 0) {
			returnMap.put("msg", "중복된 아이디가 있습니다.");
			returnMap.put("code", 200);
		} else {
			returnMap.put("msg", "사용가능한 아이디입니다.");
			returnMap.put("code", 201);
		}
		return returnMap;
	}
	
	public Map<String, Object> searchId(Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		List<Map<String, Object>> list = userDao.searchId(map);
		
		if (list.size() > 0) {

			returnMap.put("returnId", list);
			returnMap.put("code", 200);
			
		}else {
			
			returnMap.put("msg", "해당 ID가 없습니다.");
			returnMap.put("code", 201);
		}
		
		return returnMap;
		
	}
	
	/*
	 * 비번찾기위한 email 찾기
	 */
	public Map<String, Object> searchEmail(Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		List<Map<String, Object>> list = userDao.searchEmail(map);
		
		if (list.size() > 0) {

			Map<String, Object> resultMap = list.get(0);
			returnMap.put("email", resultMap);
			returnMap.put("code", 200);
			
		}else {
			returnMap.put("msg", "해당 Email이 없습니다.");
			returnMap.put("code", 201);
		}
		
		return returnMap;
		
	}
	
	public Map<String, Object> tempPassword(String[] receivers, String email,
			Map<String, Object> resMap) {
		
		int result = (int) (Math.floor(Math.random() * 1000000)+100000);
		if(result > 1000000){
		   result = result - 100000;
		}
		Map map = new HashMap();
		map.put("tempPassword", result) ;
		map.put("email", email) ;
		
		userDao.tempPassword(map) ;
		sendMail(receivers, map) ;
		return resMap;
		
	}
	
	public Map<String, Object> sendMail(String[] receivers,
			Map<String, Object> messageMap) {

		// 메일 보내기
		BallochillyMailer.getInstance().sendMail(velocityEngine, receivers, messageMap);
		return null;
		
	}
	
	public Map<String, Object> getUser(Map<String, Object> map) {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("user", userDao.selectUser(map));
		System.out.println("returnMap : " + returnMap);
		return returnMap;
	}
	
	public Map<String, Object> login(Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
//		System.out.println("map : " + map);
		List<Map<String, Object>> list = userDao.selectUser(map);
//		System.out.println("list : " + list);
		if (list.size() > 0) {

			Map<String, Object> resultMap = list.get(0);

			if (map.get("pw").equals(list.get(0).get("PW"))) {

				returnMap.put("user", resultMap);
				returnMap.put("code", 200);
//				System.out.println("returnMap : " + returnMap);

			} else {
				returnMap.put("msg", "비밀번호가 틀렸습니다.");
				returnMap.put("code", 201);
			}
			
		} else {
			returnMap.put("msg", "해당 ID가 없습니다.");
			returnMap.put("code", 202);
		}

		return returnMap;
	}
	
	public Map<String, Object> modifyUserInfo(Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		int result = userDao.updateUserInfo(map);
		
		if(result > 0) {
			returnMap.put("code", 200);
			returnMap.put("msg", "성공적으로 변경되었습니다.");
		} else {
			returnMap.put("code", 201);
			returnMap.put("msg", "정보수정에 실패하였습니다.");
		}
		return returnMap;
	}
	
	public Map<String, Object> selectPw(Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		String getPw = userDao.selectPw(map);
		if(map.get("pw").equals(getPw)) {
			returnMap.put("code", 200);
			returnMap.put("msg", "비번이 같습니다");
		} else {
			returnMap.put("code", 201);
			returnMap.put("msg", "비번이 다릅니다");
		}
		
		return returnMap;
		
	}
	
	public Map<String, Object> modifyPw(Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		int result = userDao.updateUserPw(map);
		
		if(result > 0) {
			returnMap.put("code", 200);
			returnMap.put("msg", "성공적으로 변경되었습니다.");
		} else {
			returnMap.put("code", 201);
			returnMap.put("msg", "정보수정에 실패하였습니다.");
		}
		
		return returnMap;
		
	}
	
	public Map<String, Object> message(Map<String, Object> map) {
		
		String strPage = (String) map.get("page");
		if(strPage == null) {
			strPage = "1";
		}
		
		int page = Integer.parseInt(strPage);
		int pageSize = 10;
		int pageBlock = 10;
		
		map.put("page", page);
		map.put("pageSize", pageSize);
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		List<Map<String, Object>> resultMap = userDao.message(map);
		
		int count = userDao.countMsg(map);
		
		String pagination = Util.getPagination(count, page, pageBlock, pageSize);
		
		returnMap.put("pagination", pagination);
		
		if(resultMap != null && resultMap.size() > 0) {
			
			returnMap.put("code", 200);
			returnMap.put("msgList", resultMap);
			
		} else {
			
			returnMap.put("code", 201);
			returnMap.put("msg", "신청메시지가 없습니다");
			
		}
		
		return returnMap;
		
	}
	
	public Map<String, Object> msgDetail(Map<String, Object> map) {
		
		String strPage = (String) map.get("page");
		if(strPage == null) {
			strPage = "1";
		}
		
		int page = Integer.parseInt(strPage);
		int pageSize = 10;
		int pageBlock = 10;
		
		map.put("page", page);
		map.put("pageSize", pageSize);
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		List<Map<String, Object>> msgList = userDao.message(map);
		
		if(!map.get("msgYn").equals("YY")){
			
			userDao.updateMsgStatus(map);
			
		}
		
		
		int count = userDao.countMsg(map);
		System.out.println("msgList : " + msgList);
		String pagination = Util.getPagination(count, page, pageBlock, pageSize);
		
		returnMap.put("pagination", pagination);
		
		if(msgList != null && msgList.size() > 0) {
			returnMap.put("msgList", msgList.get(0));
			System.out.println("returnMap : " + returnMap);
		}
		
		return returnMap;
		
	}
	
	
	/*
	 * 내팀 목록 보기
	 */
	public Map<String, Object> myTeamList(Map<String, Object> map) {
		
		String strPage = (String) map.get("page");
		if(strPage == null) {
			strPage = "1";
		}
		
		int page = Integer.parseInt(strPage);
		int pageSize = 10;
		int pageBlock = 10;
		
		map.put("page", page);
		map.put("pageSize", pageSize);
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		List<Map<String, Object>> myTeamList = userDao.myTeamList(map);
		
		int count = userDao.myTeamCnt(map);
		
		String pagination = Util.getPagination(count, page, pageBlock, pageSize);
		
		returnMap.put("pagination", pagination);
		returnMap.put("count", count);
		returnMap.put("pageBlock", pageBlock);
		returnMap.put("myTeamList", myTeamList);
		
		return returnMap;
		
	}
	
	
	/*
	 * 메시지 삭제
	 */
	public Map<String, Object> deleteMsg(Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		int result = userDao.deleteMsg(map);
		
		if(result > 0) {
			returnMap.put("code", 200);
			returnMap.put("msg", "성공적으로 삭제됐습니다");
		} else {
			returnMap.put("code", 201);
			returnMap.put("code", "실패");
			
		}
		
		return returnMap;
		
	}
	
	/*
	 * 팀 탈퇴
	 */
	public Map<String, Object> dropOut(Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		int result = userDao.dropOut(map);
		
		if(result > 0) {
			returnMap.put("code", 200);
			returnMap.put("msg", "성공적으로 탈퇴했습니다.");
		} else {
			returnMap.put("code", 201);
			returnMap.put("code", "실패");
			
		}
		
		return returnMap;
		
	}
	
	/*
	 * 팀 삭제 하면 가입한 사람들도 자동으로 db에서 지워줌
	 */
	public Map<String, Object> teamDelete(Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		int result = userDao.teamDelete(map);
		
		if(result > 0) {
			returnMap.put("code", 200);
			returnMap.put("msg", "성공적으로 삭제 했습니다.");
		} else {
			returnMap.put("code", 201);
			returnMap.put("code", "실패");
			
		}
		
		return returnMap;
		
	}
	
	/*
	 * 팀 구하기에서 쪽지 보내기
	 */
	public Map<String, Object> insertNote(Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String,Object>();
		
		int result = userDao.insertNote(map);
		
		if(result > 0) {
			returnMap.put("code", 200);
			returnMap.put("msg", "성공적으로 보냈습니다");
		} else {
			returnMap.put("code", 201);
			returnMap.put("msg", "실패");
		}
		return returnMap;
	}
	/*
	 * 내쪽지함 읽기
	 */
	public Map<String, Object> myNote(Map<String, Object> map) {
		
		String strPage = (String) map.get("notePage");
		if(strPage == null) {
			strPage = "1";
		}
		
		int page = Integer.parseInt(strPage);
		int pageSize = 10;
		int pageBlock = 10;
		
		map.put("notePage", page);
		map.put("notePageSize", pageSize);
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		List<Map<String, Object>> resultMap = userDao.myNote(map);
		
		int count = userDao.myNoteCount(map);
		
		String pagination = Util.getPagination(count, page, pageBlock, pageSize);
		
		returnMap.put("notePagination", pagination);
		
		if(resultMap != null && resultMap.size() > 0) {
			
			returnMap.put("code2", 300);
			returnMap.put("myNoteList", resultMap);
			System.out.println("returnMap : " + returnMap);
			
		} else {
			
			returnMap.put("code2", 301);
			returnMap.put("msg2", "메시지가 없습니다.");
			
		}
		
		return returnMap;
		
	}
	
	public Map<String, Object> myNoteDetail(Map<String, Object> map) {
		
		String strPage = (String) map.get("notePage");
		if(strPage == null) {
			strPage = "1";
		}
		
		int page = Integer.parseInt(strPage);
		int pageSize = 10;
		int pageBlock = 10;
		
		map.put("notePage", page);
		map.put("notePageSize", pageSize);
		
		userDao.updateNoteStatus(map);
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		List<Map<String, Object>> myNoteList = userDao.myNote(map);
		
		int count = userDao.myNoteCount(map);
		System.out.println("myNoteList : " + myNoteList);
		String pagination = Util.getPagination(count, page, pageBlock, pageSize);
		
		returnMap.put("notePagination", pagination);
		
		if(myNoteList != null && myNoteList.size() > 0) {
			returnMap.put("myNoteList", myNoteList.get(0));
			System.out.println("returnMap : " + returnMap);
		}
		
		return returnMap;
		
	}
	
	public Map<String, Object> deleteNote(Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		int result = userDao.deleteNote(map);
		
		if(result > 0) {
			returnMap.put("code", 200);
			returnMap.put("msg", "성공적으로 삭제됐습니다");
		} else {
			returnMap.put("code", 201);
			returnMap.put("code", "실패");
			
		}
		
		return returnMap;
		
	}
	
	/*
	 * 보낸 편지함
	 */
	public Map<String, Object> sendNote(Map<String, Object> map) {
		
		String strPage = (String) map.get("sendPage");
		if(strPage == null) {
			strPage = "1";
		}
		
		int page = Integer.parseInt(strPage);
		int pageSize = 10;
		int pageBlock = 10;
		
		map.put("sendPage", page);
		map.put("sendPageSize", pageSize);
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		List<Map<String, Object>> sendList = userDao.sendNote(map);
		
		int count = userDao.sendCount(map);
		System.out.println("sendList : " + sendList);
		String pagination = Util.getPagination(count, page, pageBlock, pageSize);
		
		returnMap.put("sendPagination", pagination);
		
		if(sendList != null && sendList.size() > 0) {
			
			returnMap.put("sendList", sendList);
			returnMap.put("code3", 400);
			
		} else {
			
			returnMap.put("code3", 401);
			returnMap.put("msg3", "메시지가 없습니다.");
			
		}
		
		return returnMap;
	}
	
	
	/*
	 * 새 메시지
	 */
	public Map<String, Object> newNote(Map<String, Object> map ) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		int result = userDao.newNote(map);
		
		if(result > 0 ) {
			returnMap.put("newNote", result);
			returnMap.put("code", 200);
		} else {
			returnMap.put("msg", "새 쪽지가 없습니다.");
			returnMap.put("code", 201);
		}
		
		return returnMap;
		
	}
	
	/*
	 * 새 팀 신청 메시지
	 */
	public Map<String, Object> newMsg(Map<String, Object> map ) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		int result = userDao.newMsg(map);
		
		if(result > 0 ) {
			returnMap.put("newMsg", result);
			returnMap.put("code", 200);
		} else {
			returnMap.put("msg", "새 쪽지가 없습니다.");
			returnMap.put("code", 201);
		}
		
		return returnMap;
		
	}
	
}






