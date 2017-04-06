package com.ballochilly.res.client.service.team;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ballochilly.res.client.dao.team.LookForTeamBoardDao;
import com.ballochilly.res.common.Util;

@Service
public class LookForTeamBoardService {
	
	
	@Autowired
	LookForTeamBoardDao lookForTeamBoardDao;

	public Map<String, Object> seletBoard(Map<String, Object> map) {
		
		String strPage = (String) map.get("page");
		if(strPage == null) {
			strPage = "1";
		}
		
		int page = Integer.parseInt(strPage);
		
		String strPageSize = (String) map.get("pageSize");
		if(strPageSize == null) {
			strPageSize = "10";
		}
		
		int pageSize = Integer.parseInt(strPageSize);
		int pageBlock = 10;
		
		map.put("page", page);
		map.put("pageSize", pageSize);
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		List<Map<String, Object>> boardList = lookForTeamBoardDao.selectTeamHireBoard(map);
		
		int count = lookForTeamBoardDao.countTeamHireBoard(map);
		
		String pagination = Util.getPagination(count, page, pageBlock, pageSize);
		
		returnMap.put("pagination", pagination);
		returnMap.put("pageBlock", pageBlock);
		returnMap.put("count", count);
		returnMap.put("boardList", boardList);
		
		return returnMap;
		
	}
	
	public Map<String, Object> insertBoard(Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();

		int result = lookForTeamBoardDao.insertBoard(map);
		
		if(result > 0) {
			returnMap.put("code", 200);
			returnMap.put("msg", "글쓰기에 성공했습니다.");
		} else {
			returnMap.put("code", 201);
			returnMap.put("msg", "실패");
		}
		
		return returnMap;
		
	}
	
	public Map<String, Object> lookForTeamBoardDetail(Map<String, Object> map) {
		
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
		List<Map<String, Object>> boardList = lookForTeamBoardDao.selectTeamHireBoard(map);
		
		
		int count = lookForTeamBoardDao.countTeamHireBoard(map);
		
		String pagination = Util.getPagination(count, page, pageBlock, pageSize);
		
		returnMap.put("pagination", pagination);
		
		if(boardList != null && boardList.size() > 0) { 
			
			returnMap.put("boardList", boardList.get(0));
			System.out.println("returnMap : " + returnMap);
			
		}
		
		return returnMap;
		
	}
	
	public Map<String, Object> lookForTeamBoardModify(Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		int result = lookForTeamBoardDao.updateBoard(map);
		
		if(result > 0) {
			returnMap.put("code", 200);
			returnMap.put("msg", "수정완료");
		} else {
			returnMap.put("code", 201);
			returnMap.put("msg", "수정실패");
		}
		
		return returnMap;
		
	}
	
	public Map<String, Object> selectTeamHireBoardReply(Map<String, Object> map) {
		
		String strPage = (String) map.get("replyPage");
		if(strPage == null) {
			strPage = "1";
		}
		
		int page = Integer.parseInt(strPage);
		int pageSize = 10;
		int pageBlock = 10;
		
		map.put("replyPage", page);
		map.put("replyPageSize", pageSize);
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		List<Map<String, Object>> teamHireBoardReplyList = lookForTeamBoardDao.selectTeamHireBoardReply(map);
		
		int count = lookForTeamBoardDao.countTeamHireBoardReply(map);
		
		String pagination = Util.getPagination(count, page, pageBlock, pageSize);
		
		returnMap.put("replyPagination", pagination);
		returnMap.put("pageBlock", pageBlock);
		returnMap.put("replyCount", count);
		returnMap.put("replyList", teamHireBoardReplyList);
		
		return returnMap;
	}
	
	public Map<String, Object> replyInsert(Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		int result = lookForTeamBoardDao.replyInsert(map);
		
		if(result > 0) {
			returnMap.put("code", 200);
			returnMap.put("msg", "성공적으로 댓글이 작성됐습니다.");
		} else {
			returnMap.put("code", 201);
			returnMap.put("msg", "실패");
		}
		
		return returnMap;
		
	}
	
	public Map<String, Object> replyDelete(Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		int result = lookForTeamBoardDao.replyDelete(map);
		
		if(result > 0) {
			returnMap.put("code", 200);
			returnMap.put("msg", "성공적으로 삭제됐습니다");
		} else {
			returnMap.put("code", 201);
			returnMap.put("msg", "실패");
		}
		
		return returnMap;
		
	}
	
	public Map<String, Object> modiftyReply(Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		int result = lookForTeamBoardDao.updateReply(map);
		
		if(result > 0) {
			returnMap.put("code", 200);
			returnMap.put("msg", "성공적으로 수정됐습니다");
		} else {
			returnMap.put("code", 201);
			returnMap.put("msg", "실패");
		}
		
		return returnMap;
		
	}
	
	public Map<String, Object> updateHit(Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		lookForTeamBoardDao.updateHit(map);
		
		return returnMap;
		
	}
	
	public Map<String, Object> deleteList(Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		int result = lookForTeamBoardDao.deleteList(map);
		
		if(result > 0) {
			lookForTeamBoardDao.deleteListReply(map);
			returnMap.put("code", 200);
			returnMap.put("msg", "성공적으로 삭제됐습니다.");
		} else {
			returnMap.put("code", 201);
			returnMap.put("mgs", "실패");
		}
		return returnMap;
	}
	
	public Map<String, Object> cmtOfCmt(Map<String, Object> map) {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		int result = lookForTeamBoardDao.cmtOfCmt(map);
		
		if(result > 0) {
			returnMap.put("code", 200);
			returnMap.put("msg", "작성완료!!!");
		} else {
			returnMap.put("code", 201);
			returnMap.put("mgs", "실패");
		}
		return returnMap;
	}
	
	
}
