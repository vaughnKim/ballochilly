package com.ballochilly.res.client.service.team;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ballochilly.res.client.dao.team.TeamDao;
import com.ballochilly.res.common.Util;

@Service
public class TeamService {
	
	@Autowired
	TeamDao teamDao;
	
	public Map<String, Object> fileUpload(
			MultipartHttpServletRequest mRequest) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		String savePath = "/spring/upload";
		String webAppPath = this.getClass().getClassLoader().getResource("").getPath();
		System.out.println(webAppPath);
		webAppPath = webAppPath.substring(0, webAppPath.indexOf("WEB-INF/"));
		webAppPath += "temp/";
		savePath = webAppPath;
		
		String fileImage = "";
		
		File saveDir = new File(savePath);
		
		if(!saveDir.isDirectory()) {
			
			saveDir.mkdirs();
			
		}	//end if
		
		Iterator<String> htmlNames= mRequest.getFileNames();
		
		while(htmlNames.hasNext()) {
			
			String htmlName = htmlNames.next();
			
			List<MultipartFile> mFiles = mRequest.getFiles(htmlName);
			
			for(int i = 0 ; i < mFiles.size() ; i++) {
				
				String oFileName = mFiles.get(i).getOriginalFilename();
				
				if(oFileName != null && !oFileName.trim().equals("")) {
					
					long size = mFiles.get(i).getSize();
					String saveFileName = oFileName;
					
					File f = new File(savePath + "/" + oFileName);
					if(f.exists()) {
						
						String fName = oFileName.substring(0, oFileName.lastIndexOf("."));
						String extName = oFileName.substring(oFileName.lastIndexOf("."));
						saveFileName = fName + "_" + System.currentTimeMillis() + extName;
						
					}
					
					try {
						mFiles.get(i).transferTo(new File(savePath + "/" + saveFileName));
					} catch (IllegalStateException | IOException e) {
						e.printStackTrace();
					}
					
					fileImage = "/temp/" + saveFileName;
					
				}	//end if
				
			}	//end for
			
		}	//end while
		
		returnMap.put("fileImage", fileImage);
		return returnMap;
		
	}
	
	
	
	public Map<String, Object> insertTeam(
			Map<String, Object> map,
			MultipartHttpServletRequest mRequest) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		int result = 0;
		
		String savePath = "";
		String webAppPath = this.getClass().getClassLoader().getResource("").getPath();
//		
		webAppPath = webAppPath.substring(0, webAppPath.indexOf("WEB-INF/"));
		webAppPath += "emblem/";
		savePath = webAppPath;
		
		File saveDir = new File(savePath);
		if(!saveDir.isDirectory()) {
			saveDir.mkdirs();
		}
		
		String saveFileName = "";
		
		Iterator<String> htmlNames = mRequest.getFileNames();
		
		while(htmlNames.hasNext()) {
			
			String htmlName = htmlNames.next();
			
			List<MultipartFile> mFiles = 
					mRequest.getFiles(htmlName);
			
			for(int i = 0; i < mFiles.size(); i++) {
				
				String oFileName = mFiles.get(i).getOriginalFilename();
				
				if(oFileName != null && !oFileName.trim().equals("")) {
					
					saveFileName = oFileName;
					
					map.put("teamEmblem", saveFileName);
					
					try {
						mFiles.get(i).transferTo(new File(savePath + "/" + saveFileName));
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
		
		result = teamDao.insertTeam(map);
		if(result > 0) {
			returnMap.put("msg", "팀 등록 완료");
			returnMap.put("code", 200);
		} else {
			returnMap.put("msg", "실패");
			returnMap.put("code", 201);
		}
		
		return returnMap;
		
	}
	
	public Map<String, Object> isExistTeamName(Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		int result = teamDao.isExistTeamName(map);
		
		if(result > 0) {
			returnMap.put("msg", "이미 등록된 팀입니다.");
			returnMap.put("code", 200);
		} else {
			returnMap.put("msg", "등록 가능합니다.");
			returnMap.put("code", 201);
		}
		
		return returnMap;
	}
	
	public Map<String, Object> teamList(Map<String, Object> map) {
		
		String strPage = (String) map.get("page");
		if(strPage == null) {
			strPage = "1";
		}
		
		int page = Integer.parseInt(strPage);
		int pageSize = 30;
		int pageBlock = 10;
		
		map.put("page", page);
		map.put("pageSize", pageSize);
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		List<Map<String, Object>> teamList = teamDao.teamList(map);
		
		int count = teamDao.countTeam(map);
		
		String pagination = Util.getPagination(count, page, pageBlock, pageSize);
		
		returnMap.put("pagination", pagination);
		returnMap.put("count", count);
		returnMap.put("pageBlock", pageBlock);
		returnMap.put("teamList", teamList);
		
		return returnMap;
	}
	
	public Map<String, Object> teamDetail(Map<String, Object> map) {
		
		String strPage = (String) map.get("page");
		if(strPage == null) {
			strPage = "1";
		}
		
		int page = Integer.parseInt(strPage);
		int pageSize = 30;
		int pageBlock = 10;
		
		map.put("page", page);
		map.put("pageSize", pageSize);
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		List<Map<String, Object>> teamList = teamDao.teamList(map);
		
		int count = teamDao.countTeam(map);
		System.out.println("teamList : " + teamList);
		
		String pagination = Util.getPagination(count, page, pageBlock, pageSize);
		
		returnMap.put("pagination", pagination);
		
		if(teamList != null && teamList.size() > 0) {
			returnMap.put("teamList", teamList.get(0));
			System.out.println("returnMap : " + returnMap);
		}
		
		return returnMap;
		
	}
	/*
	 * 팀 정보수정
	 */
	public Map<String, Object> teamModify(Map<String, Object> map) {
		
		String strPage = (String) map.get("page");
		if(strPage == null) {
			strPage = "1";
		}
		
		int page = Integer.parseInt(strPage);
		int pageSize = 30;
		int pageBlock = 10;
		
		map.put("page", page);
		map.put("pageSize", pageSize);
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		List<Map<String, Object>> teamList = teamDao.teamList(map);
		
		int count = teamDao.countTeam(map);
		System.out.println("teamList : " + teamList);
		
		String pagination = Util.getPagination(count, page, pageBlock, pageSize);
		
		returnMap.put("pagination", pagination);
		
		if(teamList != null && teamList.size() > 0) {
			returnMap.put("teamList", teamList.get(0));
			System.out.println("returnMap : " + returnMap);
		}
		
		return returnMap;
		
	}
	
	/*
	 * 팀 가입 신청할 때 메시지 보내기
	 */
	public Map<String, Object> joinTeamMessage(
			Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
//		map.put("content", "가입신청합니다");
		int result = teamDao.joinTeamMessage(map);
		if(result > 0) {
			returnMap.put("msg", "가입신청이 완료됐습니다.");
			returnMap.put("code", 200);
		} else {
			returnMap.put("msg", "가입신청에 오류가 발생했습니다.");
			returnMap.put("code", 201);
		}
		return returnMap;
		
	}
	
	/*
	 * 팀 등록한 놈 아이디 받아서 검색 받기
	 */
	public Map<String, Object> selectTeam(
			Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		List<Map<String, Object>> selectTeam = teamDao.selectTeam(map);
		
		if(selectTeam != null && selectTeam.size() != 0) {
			
			returnMap.put("selectTeam", selectTeam.get(0));
			returnMap.put("code", 200);
			returnMap.put("msg", "팀정보들");
			
		} else {
			returnMap.put("code", 201);
			returnMap.put("msg", "등록한 팀이 없습니다.");
		}
		
		return returnMap;
		
	}
	/*
	 * 팀 가입신청을 누르면 회원관리 테이블에 쌓기
	 */
	public Map<String, Object> insertTeamMember(
			Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		int result = teamDao.insertTeamMember(map);
		
		if(result > 0) {
			returnMap.put("msg", "팀 가입 완료");
			returnMap.put("code", 200);
		} else {
			returnMap.put("msg", "실패");
			returnMap.put("code", 201);
		}
		
		
		return returnMap;
		
	}
	
	/*
	 * 이미 팀 가입 했는지 확인
	 */
	public Map<String, Object> isExistTeamMember(
			Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		int result = teamDao.isExistTeamMember(map);
		
		if(result > 0) {
			
			returnMap.put("msg", "이미 승인했습니다.");
			returnMap.put("code", 201);
			
		} else {
			
			returnMap.put("msg", "가능");
			returnMap.put("code", 200);
		}
		
		return returnMap;
		
	}
	
	/*
	 * 팀 만든사람이 거절하면 메시지 보내기
	 */
	public Map<String, Object> rejectMsg(
			Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		map.put("content", "거절하셨습니다");
		int result = teamDao.rejectMsg(map);
		if(result > 0) {
			returnMap.put("msg", "성공적");
			returnMap.put("code", 200);
		} else {
			returnMap.put("msg", "오류가 발생했습니다.");
			returnMap.put("code", 201);
		}
		return returnMap;
		
	}
	
	public Map<String, Object> updateMsgYnState(Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		int result = teamDao.updateMsgYnState(map);
		
		if(result > 0) {
			returnMap.put("code", 200);
			returnMap.put("msg", "성공적으로 변경되었습니다.");
		} else {
			returnMap.put("code", 201);
			returnMap.put("msg", "정보수정에 실패하였습니다.");
		}
		return returnMap;
		
	}
	
	/*
	 * 이미 가입했으면 다시 신청못하게 하기 위한 메소드
	 */
	public Map<String, Object> alreadyJoinTeam(Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		int result = teamDao.alreadyJoinTeam(map);		
		if(result > 0) {
			returnMap.put("code", 201);
			returnMap.put("msg", "이미 가입한 팀입니다.");
		} else {
			returnMap.put("code", 200);
			returnMap.put("msg", "가입하지 않은 팀입니다.");
		}
		return returnMap;
		
	}
	
	/*
	 * 이 사이트를 이용하는 사람들 중에서 팀 회원수
	 */
	public Map<String, Object> countTeamMember(Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		int result = teamDao.countTeamMember(map);
		returnMap.put("countTeamMember", result);
		return returnMap;
	}
	
	/*
	 * 팀 수정
	 */
	public Map<String, Object> updateTeam(
			Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		int result = 0 ;
		
//		String savePath = "";
//		String webAppPath = this.getClass().getClassLoader().getResource("").getPath();
////		
//		webAppPath = webAppPath.substring(0, webAppPath.indexOf("WEB-INF/"));
//		webAppPath += "emblem/";
//		savePath = webAppPath;
//		
//		File saveDir = new File(savePath);
//		if(!saveDir.isDirectory()) {
//			saveDir.mkdirs();
//		}
//		
//		String saveFileName = "";
//		
//		Iterator<String> htmlNames = mRequest.getFileNames();
//		
//		while(htmlNames.hasNext()) {
//			
//			String htmlName = htmlNames.next();
//			
//			List<MultipartFile> mFiles = 
//					mRequest.getFiles(htmlName);
//			
//			for(int i = 0; i < mFiles.size(); i++) {
//				
//				String oFileName = mFiles.get(i).getOriginalFilename();
//				
//				if(oFileName != null && !oFileName.trim().equals("")) {
//					
//					saveFileName = oFileName;
//					
//					map.put("teamEmblem", saveFileName);
//					
//					try {
//						mFiles.get(i).transferTo(new File(savePath + "/" + saveFileName));
//					} catch (IllegalStateException e) {
//						e.printStackTrace();
//					} catch (IOException e) {
//						e.printStackTrace();
//					}
//				}
//			}
//		}
		
		result = teamDao.updateTeam(map);
		
		if(result > 0) {
			returnMap.put("code", 200);
			returnMap.put("msg", "수정완료");
		} else {
			returnMap.put("code", 201);
			returnMap.put("msg", "실패");
		}
		return returnMap;
	}
	
	/*
	 * 엠블럼 수정
	 */
	public Map<String, Object> updateEmblemTeam(
			Map<String, Object> map,
			MultipartHttpServletRequest mRequest) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		int result = 0 ;
		
		String savePath = "";
		String webAppPath = this.getClass().getClassLoader().getResource("").getPath();
//		
		webAppPath = webAppPath.substring(0, webAppPath.indexOf("WEB-INF/"));
		webAppPath += "emblem/";
		savePath = webAppPath;
		
		File saveDir = new File(savePath);
		if(!saveDir.isDirectory()) {
			saveDir.mkdirs();
		}
		
		String saveFileName = "";
		
		Iterator<String> htmlNames = mRequest.getFileNames();
		
		while(htmlNames.hasNext()) {
			
			String htmlName = htmlNames.next();
			
			List<MultipartFile> mFiles = 
					mRequest.getFiles(htmlName);
			
			for(int i = 0; i < mFiles.size(); i++) {
				
				String oFileName = mFiles.get(i).getOriginalFilename();
				
				if(oFileName != null && !oFileName.trim().equals("")) {
					
					saveFileName = oFileName;
					
					map.put("teamEmblem", saveFileName);
					
					try {
						mFiles.get(i).transferTo(new File(savePath + "/" + saveFileName));
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
		
		result = teamDao.updateEmblemTeam(map);
		
		if(result > 0) {
			returnMap.put("code", 200);
			returnMap.put("msg", "수정완료");
		} else {
			returnMap.put("code", 201);
			returnMap.put("msg", "실패");
		}
		return returnMap;
	}
		
		
}








