package com.ballochilly.res.client.service.community;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ballochilly.res.client.dao.community.VideoBoardAtchDao;
import com.ballochilly.res.client.dao.community.VideoBoardDao;
import com.ballochilly.res.client.dao.community.VideoBoardReplyDao;
import com.ballochilly.res.common.Util;


@Service
public class VideoService {
	
	@Autowired
	VideoBoardDao videoDao;
	
	@Autowired
	VideoBoardReplyDao videoReplyDao;
	
	@Autowired
	VideoBoardAtchDao vbAtchDao;

//  ADD POST ON DB
	public Map<String, Object> addVideoBoard (
			Map<String, Object> map,
			HttpServletRequest req,
			MultipartHttpServletRequest mReq) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		Map<String, String> paramMap = Util.parseQueryString(req);
		
		System.out.print("##########");
		System.out.println("paramMap : " +paramMap);
		System.out.print("##########");
		System.out.println("addVideoBoard Service");
		
		// Board_Stadium_Review에 게시물 등록
		videoDao.AddVideoBoard(paramMap);
		
		// get lastSeqNo from Board_Stadium_Review for inserting to BOARD_ATCH
		int bvSeqNo = videoDao.getLastVideoBoardSeqNo(map);
		map.put("bvSeqNo", bvSeqNo);
		
//		파일 업로드 디렉토리 생성
//		서버상의 돌고 있던 파일이 저장될 곳의 경로를 지정해 주는 것
		String savePath = "";
		String webAppPath = this.getClass().getClassLoader().getResource("").getPath();

		// web에서 경로를 찾아내 다운로드 가능하다!!
		webAppPath = webAppPath.substring(0, webAppPath.indexOf("WEB-INF/"));
		webAppPath += "video/";
		savePath = webAppPath;
		
		System.out.print("savePath : ");
		System.out.println(savePath);
		
		// MAKING NEW FOLDER IF NO EXIST THE NAMED 'video' FOLDER ON DB
		File saveDir = new File(savePath);
		if(!saveDir.isDirectory()) {
			saveDir.mkdirs();
		}
		
		List<String> saveFiles = new ArrayList<String>();
		String saveFileName = "";
		
//		Extraction the fileInfos & SAVE THE FILE ON DB
		Iterator<String> htmlNames = mReq.getFileNames();
		while(htmlNames.hasNext()) {
			String htmlName = htmlNames.next();
			// IF mFILEs ARE MULTIPLE
			List<MultipartFile> mFiles = mReq.getFiles(htmlName);
			for(int i = 0; i < mFiles.size(); i++) {
				String oFileName = mFiles.get(i).getOriginalFilename();

				//			파일이 없거나 공백일 때
				if(oFileName != null && !oFileName.trim().equals("")) {
					saveFileName = oFileName;
					
					try {
						mFiles.get(i).transferTo(new File(savePath + "/" + saveFileName));
						saveFiles.add(saveFileName);
					} catch (IllegalStateException | IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
		
		System.out.println("saveFiles=========================== : "+saveFiles);
		for(int i = 0; i < saveFiles.size();i++){
			map.put("bvAtchVname", saveFiles.get(i));
			// Board_ATCH 에 게시물 등록					
			vbAtchDao.AddBoardAtch(map);
		}
		returnMap.put("msg", "게시물 등록 완료");
//		
		return returnMap;
	}

//	SELECT ALL POSTING
	public Map<String, Object> selectAllVideoBoard (
			Map<String, Object> map,
			HttpServletRequest req) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		System.out.print("##########");
		System.out.println("selectAllVideoBoard Service");
		

		String strPage = (String) map.get("page");
		if(strPage == null) {
			strPage = "1";
		}
		int page = Integer.parseInt(strPage);
		
		String strPageSize = (String) map.get("pageSize");
		if(strPageSize == null){
			strPageSize = "10";
		}
		
		int pageSize = Integer.parseInt(strPageSize);
		int pageBlock = 10;
		
		map.put("page", page);
		map.put("pageSize", pageSize);
		
		List<Map<String, Object>> BoardList = videoDao.selectAllVideoBoard(map);
		
		System.out.println("동영상게시판 모든 파일가져오기 ==========" +BoardList );
		
		int totalCount = videoDao.getTotalCountVideoBoard(map);
		String paging = Util.getPagination(totalCount, page, pageBlock, pageSize);

		returnMap.put("BoardList", BoardList);
		returnMap.put("totalCount", totalCount);
		returnMap.put("paging", paging);
		returnMap.put("pageBlock", pageBlock);
		
		return returnMap;
	}
	
//	SELECT EACH POSTING INFOS
	public Map<String, Object> selectEachVideoBoard (
			Map<String, Object> map){
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		String strPage = (String) map.get("page");
		if(strPage == null) {
			strPage = "1";
		}
		int page = Integer.parseInt(strPage);
		int pageSize = 10;
		int pageBlock = 10;
		int totalCount = videoReplyDao.getCountNoVideoComment(map);
		map.put("page", page);
		map.put("pageSize", pageSize);
		
		String paging = Util.getPagination(totalCount, page, pageBlock, pageSize);
		returnMap.put("totalCount", totalCount);
		returnMap.put("pageBlock", pageBlock);
		returnMap.put("paging", paging);
		
		
		// Raise up the hit of the clicked posting
		videoDao.raiseVideoBoardHit(map);
		
		List<Map<String, Object>> theInfos = videoDao.selectEachVideoBoard(map);
		
		// Get the Infos of chose posting 
		if(theInfos != null && theInfos.size() > 0) {
			returnMap.put("boardlist", theInfos.get(0));
			System.out.println("theInfos ============ " + theInfos.get(0));
		}

		// Get the VIDEO FILE
		List<Map<String, Object>> video = vbAtchDao.selectAtchFile(map);
		returnMap.put("video", video);

		// Get number of comment
		int CountComment = videoReplyDao.getCountNoVideoComment(map);
		returnMap.put("CountComment", CountComment);
		
		// Get the comments of chose posting
		List<Map<String, Object>> CommentAll = videoReplyDao.selectCommentVideoBoard(map);
		returnMap.put("CommentAll", CommentAll);
		System.out.println("CommentAll ============ "+CommentAll);
		
		return returnMap;
	}
	
//	EDIT POSTING INFOS
 	public Map<String, Object> editVideoBoard (
			Map<String, Object> map,
			HttpServletRequest req,
			MultipartHttpServletRequest mReq) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		Map<String, String> paramMap = Util.parseQueryString(req);
		
		System.out.println("###########");
		System.out.println("editVideoBoard Service :");
		System.out.println("MAP=================="+map);
		System.out.println("paramMap=================="+paramMap);
		
		System.out.println("===========일반수정 들어가?==================");
		
		// BOARD_STADIUM_REVIEW 에 게시물 수정들록
		int editVideoBoard = videoDao.editVideoBoard(paramMap);
		
		// Delete recent VideoFile
		int deleteVideoFile = vbAtchDao.deleteVideoAtchBoard(map); 
		
//		파일 업로드 디렉토리 생성
//		서버상의 돌고 있던 파일이 저장될 곳의 경로를 지정해 주는 것
		String savePath = "";
		String webAppPath = this.getClass().getClassLoader().getResource("").getPath();

		// web에서 경로를 찾아내 다운로드 가능하다!!
		webAppPath = webAppPath.substring(0, webAppPath.indexOf("WEB-INF/"));
		webAppPath += "video/";
		savePath = webAppPath;
		
		System.out.print("savePath : ");
		System.out.println(savePath);
		
		// MAKING NEW FOLDER IF NO EXIST THE NAMED 'video' FOLDER ON DB
		File saveDir = new File(savePath);
		if(!saveDir.isDirectory()) {
			saveDir.mkdirs();
		}
		
		List<String> saveFiles = new ArrayList<String>();
		String saveFileName = "";
		
//		Extraction the fileInfos & SAVE THE FILE ON DB
		Iterator<String> htmlNames = mReq.getFileNames();
		while(htmlNames.hasNext()) {
			String htmlName = htmlNames.next();
			// IF mFILEs ARE MULTIPLE
			List<MultipartFile> mFiles = mReq.getFiles(htmlName);
			for(int i = 0; i < mFiles.size(); i++) {
				String oFileName = mFiles.get(i).getOriginalFilename();
		//	파일이 없거나 공백일 때
				if(oFileName != null && !oFileName.trim().equals("")) {
					saveFileName = oFileName;
					
					try {
						mFiles.get(i).transferTo(new File(savePath + "/" + saveFileName));
						saveFiles.add(saveFileName);
					} catch (IllegalStateException | IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
		
		System.out.println("saveFiles=========================== : "+saveFiles);
		
		int addVideoFile = 0;
		for(int i = 0; i < saveFiles.size();i++){
			map.put("bvAtchVname", saveFiles.get(i));
			// Board_ATCH 에 게시물 등록					
			addVideoFile = vbAtchDao.AddBoardAtch(map);
		}
		
		if(editVideoBoard > 0 || deleteVideoFile > 0 || addVideoFile > 0) {
			returnMap.put("msg", "수정 완료");
		}
		return returnMap;
	}

// 	DELETE POSTING 
 	public Map<String, Object> deleteVideoBoard (Map<String, Object> map) {
 		
 		Map<String, Object> returnMap = new HashMap<String, Object>();
 		
 		int deleteBoard = videoDao.deleteVideoBoard(map);

 		// select saved files' infos
 		List<Map<String, Object>> saveFname = videoDao.selectEachVideoBoard(map);
 		
 		// delete the saved files
 		String webPath = 
 				this.getClass().getClassLoader().getResource("").getPath();
 		webPath = webPath.substring(0, webPath.indexOf("WEB-INF/"));
 		
 		for(int i = 0; i < saveFname.size(); i++) {
 			String originFname = (String) saveFname.get(i).get("BV_ATCH_VNAME");
 			File killedFname = new File(webPath + "video/" + originFname);
 			killedFname.delete();
 		}
 		
 		// delete the saved Board infos
 		System.out.println("############### deleteVideoBoard service 로 전달된 값들" + map);
 		int deleteVideoBoard = vbAtchDao.deleteVideoAtchBoard(map);
 		if(deleteBoard > 0 || deleteVideoBoard > 0) {
 			returnMap.put("msg", "삭제 되었습니다.");
 		}
 		 return returnMap;
 	}
 	
// 	ADD COMMENT ON POSTING
 	public Map<String, Object> addCommentVideoBoard (
 			Map<String, Object> map,
 			HttpServletRequest req) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		Map<String, String> paramMap = Util.parseQueryString(req);
		
		int addVideoComment = videoReplyDao.AddCommentVideoBoard(paramMap);
		if(addVideoComment > 0) {
			returnMap.put("msg", "댓글등록 완료");
		}
		return returnMap;
	}

// 	EDIT COMMENT ON POSTING
 	public Map<String, Object> editCommentVideoBoard (
 			Map<String, Object> map,
 			HttpServletRequest req) {
 		
 		Map<String, Object> returnMap = new HashMap<String, Object>();
 		Map<String, String> paramMap = Util.parseQueryString(req);
 		
 		int editVideoComment = videoReplyDao.editCommentVideoBoard(paramMap);
 		if(editVideoComment > 0){
 			returnMap.put("msg", "수정완료!");
 		}
 		return returnMap;
 	}
 	
//  DELETE COMMENT ON POSTING
 	public Map<String, Object> deleteCommentVideoBoard (Map<String, Object> map) {
 		
 		Map<String, Object> returnMap = new HashMap<String, Object>();
 		
 		int deleteVideoComment = videoReplyDao.deleteCommentVideoBoard(map);
 		if(deleteVideoComment > 0) {
 			returnMap.put("msg", "삭제완료");
 		}
 		return returnMap;
 	}
}
