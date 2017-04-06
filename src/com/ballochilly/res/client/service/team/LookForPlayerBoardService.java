package com.ballochilly.res.client.service.team;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ballochilly.res.client.dao.team.LookForPlayerBoardDao;
import com.ballochilly.res.common.Util;

@Service
public class LookForPlayerBoardService {
	
	
	@Autowired
	LookForPlayerBoardDao lookForPlayerBoardDao;

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
		List<Map<String, Object>> boardList = lookForPlayerBoardDao.selectPlayerHireBoard(map);
		
		int count = lookForPlayerBoardDao.countPlayerHireBoard(map);
		
		String pagination = Util.getPagination(count, page, pageBlock, pageSize);
		
		returnMap.put("pagination", pagination);
		returnMap.put("pageBlock", pageBlock);
		returnMap.put("count", count);
		returnMap.put("boardList", boardList);
		
		return returnMap;
		
	}
	
	public Map<String, Object> insertBoard(Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();

		int result = lookForPlayerBoardDao.insertPlayerBoard(map);
		
		if(result > 0) {
			returnMap.put("code", 200);
			returnMap.put("msg", "글쓰기에 성공했습니다.");
		} else {
			returnMap.put("code", 201);
			returnMap.put("msg", "실패");
		}
		
		return returnMap;
		
	}
	
	
	public Map<String, Object> lookForPlayerBoardDetail(Map<String, Object> map) {
		
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
		List<Map<String, Object>> boardList = lookForPlayerBoardDao.selectPlayerHireBoard(map);
		
		
		int count = lookForPlayerBoardDao.countPlayerHireBoard(map);
		
		String pagination = Util.getPagination(count, page, pageBlock, pageSize);
		
		returnMap.put("pagination", pagination);
		
		if(boardList != null && boardList.size() > 0) { 
			
			returnMap.put("boardList", boardList.get(0));
			System.out.println("returnMap : " + returnMap);
			
		}
		
		return returnMap;
		
	}
	
	public Map<String, Object> lookForPlayerBoardModify(Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		int result = lookForPlayerBoardDao.updatePlayerBoard(map);
		
		if(result > 0) {
			returnMap.put("code", 200);
			returnMap.put("msg", "수정완료");
		} else {
			returnMap.put("code", 201);
			returnMap.put("msg", "수정실패");
		}
		
		return returnMap;
		
	}
	
	public Map<String, Object> selectPlayerHireBoardReply(Map<String, Object> map) {
		
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
		List<Map<String, Object>> playerHireBoardReplyList = lookForPlayerBoardDao.selectPlayerHireBoardReply(map);
		
		int count = lookForPlayerBoardDao.countPlayerHireBoardReply(map);
		
		String pagination = Util.getPagination(count, page, pageBlock, pageSize);
		
		returnMap.put("replyPagination", pagination);
		returnMap.put("pageBlock", pageBlock);
		returnMap.put("replyCount", count);
		returnMap.put("replyList", playerHireBoardReplyList);
		
		return returnMap;
	}
	
	public Map<String, Object> replyInsert(Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		int result = lookForPlayerBoardDao.replyPlayerInsert(map);
		
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
		
		int result = lookForPlayerBoardDao.replyPlayerDelete(map);
		
		if(result > 0) {
			returnMap.put("code", 200);
			returnMap.put("msg", "성공적으로 삭제됐습니다");
		} else {
			returnMap.put("code", 201);
			returnMap.put("code", "실패");
		}
		
		return returnMap;
		
	}
	
	public Map<String, Object> modiftyReply(Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		int result = lookForPlayerBoardDao.updatePlayerReply(map);
		
		if(result > 0) {
			returnMap.put("code", 200);
			returnMap.put("msg", "성공적으로 수정됐습니다");
		} else {
			returnMap.put("code", 201);
			returnMap.put("code", "실패");
		}
		
		return returnMap;
		
	}
	
	public Map<String, Object> updateHit(Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		lookForPlayerBoardDao.updatePlayerHit(map);
		
		return returnMap;
		
	}
	
	
}
