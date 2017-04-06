package com.ballochilly.res.client.service.stadium;

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

import com.ballochilly.res.client.dao.stadium.StadiumBoardAtchDao;
import com.ballochilly.res.client.dao.stadium.StadiumBoardDao;
import com.ballochilly.res.client.dao.stadium.StadiumBoardReplyDao;
import com.ballochilly.res.common.Util;



@Service
public class StadiumBoardService {
	
	@Autowired
	StadiumBoardDao stadiumboardDao;
	
	@Autowired
	StadiumBoardAtchDao stadiumboardatchDao;

	@Autowired
	StadiumBoardReplyDao stadiumboardreplyDao;
	
//  ADD POST ON DB
	public Map<String, Object> AddStadiumBoard (
			Map<String, Object> map, 
			MultipartHttpServletRequest mRequest,
			HttpServletRequest req) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		Map<String, String> paramMap = Util.parseQueryString(req);
		
		System.out.print("##########");
		System.out.println("AddStadiumBoard Service");
		
		System.out.println("pId와 lvl값을 찾아보자" + map);
		
		// Board_Stadium_Review에 게시물 등록
		stadiumboardDao.AddStadiumBoard(paramMap);
		
//		파일 업로드 디렉토리 생성
//		서버상의 돌고 있던 파일이 저장될 곳의 경로를 지정해 주는 것
		String savePath = "";
		String webAppPath = this.getClass().getClassLoader().getResource("").getPath();

		// web에서 경로를 찾아내 다운로드 가능하다!!
		webAppPath = webAppPath.substring(0, webAppPath.indexOf("WEB-INF/"));
		webAppPath += "StadiumImage/";
		savePath = webAppPath;
		
		System.out.print("savePath : ");
		System.out.println(savePath);
		
		// MAKING NEW FOLDER IF NO EXIST THE NAMED 'TEMP' FOLDER ON DB
		File saveDir = new File(savePath);
		if(!saveDir.isDirectory()) {
			saveDir.mkdirs();
		}
		
		// get lastSeqNo from Board_Stadium_Review for inserting to BOARD_ATCH
		int bsrSeqNo = stadiumboardDao.getLastBoardSeqNo(map);
		map.put("bsrSeqNo", bsrSeqNo);
		
		List<String> saveFiles = new ArrayList<String>();
		String saveFileName = "";
		
//		Extraction the fileInfos & SAVE THE FILE ON DB
		Iterator<String> htmlNames = mRequest.getFileNames();
		while(htmlNames.hasNext()) {
			String htmlName = htmlNames.next();
			
//			// IF mFILEs IS A SINGLE
//			MultipartFile mFile = mRequest.getFile(htmlName); 
//			String oFileName = mFile.getOriginalFilename();
			
			// IF mFILEs ARE MULTIPLE
			List<MultipartFile> mFiles = mRequest.getFiles(htmlName);
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
			map.put("bsrAtchFname", saveFiles.get(i));
			// Board_ATCH 에 게시물 등록					
			stadiumboardatchDao.AddBoardAtch(map);
		}
		returnMap.put("msg", "게시물 등록 완료");
		
		return returnMap;
	}

//	SELECT ALL POSTING
	public Map<String, Object> selectAllStadiumBoard (
			Map<String, Object> map,
			HttpServletRequest req) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		System.out.print("##########");
		System.out.println("selectAllStadiumBoard Service");
		

		String strPage = (String) map.get("page");
		if(strPage == null) {
			strPage = "1";
		}
		int page = Integer.parseInt(strPage);
		
		String strPageSize = (String) map.get("pageSize");
		if(strPageSize == null){
			strPageSize = "20";
		}
		
		int pageSize = Integer.parseInt(strPageSize);
		int pageBlock = 10;
		
		map.put("page", page);
		map.put("pageSize", pageSize);
		
		List<Map<String, Object>> BoardList = stadiumboardDao.selectAllStadiumBoard(map);
		
		System.out.println("BoardList ==========" +BoardList );
		
		int totalCount = stadiumboardDao.getTotalCount(map);
		String paging = Util.getPagination(totalCount, page, pageBlock, pageSize);

		returnMap.put("BoardList", BoardList);
		returnMap.put("totalCount", totalCount);
		returnMap.put("paging", paging);
		returnMap.put("pageBlock", pageBlock);
		
		return returnMap;
	}
	
//	SELECT EACH POSTING INFOS
	public Map<String, Object> selectEachStadiumBoard (
			Map<String, Object> map,
			HttpServletRequest req){
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		Map<String, String> paramMap = new HashMap<String, String>();
		
		String strPage = (String) map.get("page");
		if(strPage == null) {
			strPage = "1";
		}
		int page = Integer.parseInt(strPage);
		int pageSize = 10;
		int pageBlock = 10;
		int totalCount = stadiumboardreplyDao.getCountCommentNo(map);
		map.put("page", page);
		map.put("pageSize", pageSize);
		
		String paging = Util.getPagination(totalCount, page, pageBlock, pageSize);
		returnMap.put("totalCount", totalCount);
		returnMap.put("pageBlock", pageBlock);
		returnMap.put("paging", paging);
		
		
		// Raise up the hit of the clicked posting
		stadiumboardDao.raiseHit(map);
		
		List<Map<String, Object>> theInfos = stadiumboardDao.selectEachStadiumBoard(map);
		
		// Get the Infos of chose posting 
		if(theInfos != null && theInfos.size() > 0) {
			returnMap.put("boardlist", theInfos.get(0));
			System.out.println("theInfos ============ " + theInfos.get(0));
		}
		
		// Get the uploaded Files of chose posting
		List<Map<String, Object>> Images = stadiumboardatchDao.selectAtchFile(map);
		returnMap.put("Images", Images);
		System.out.println("IMAGES ============ "+Images);

		// Get number of comment
		int CountComment = stadiumboardreplyDao.getCountCommentNo(map);
		returnMap.put("CountComment", CountComment);
		
		// Get the comments of chose posting
		List<Map<String, Object>> CommentAll = stadiumboardreplyDao.selectCommentBoard(map);
		returnMap.put("CommentAll", CommentAll);
		System.out.println("CommentAll ============ "+CommentAll);
		
		return returnMap;
	}
	
//	EDIT POSTING INFOS
 	public Map<String, Object> editStadiumBoard (
			Map<String, Object> map,
			MultipartHttpServletRequest mReq,
			HttpServletRequest req) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		Map<String, String> paramMap = Util.parseQueryString(req);
		
		System.out.println("###########");
		System.out.println("editStadiumBoard Service :");
		System.out.println("MAP=================="+map);
		
		System.out.println("===========일반수정 들어가?==================");
		// BOARD_STADIUM_REVIEW 에 게시물 수정들록
		int editBoard = stadiumboardDao.editStadiumBoard(paramMap);
		
		System.out.println("===========이리로 안올꺼야?==================");
		// Board_ATCH 에 있던 기존 게시물 삭제
		int deleteFname = stadiumboardatchDao.deleteStadiumAtchBoard(map);
		
		String savePath = "";
		String webAppPath = this.getClass().getClassLoader().getResource("").getPath();

		//		System.out.println(webAppPath);
		
		webAppPath = webAppPath.substring(1, webAppPath.indexOf("WEB-INF/"));
		webAppPath += "StadiumImage/";
		savePath = webAppPath;
		
//		System.out.print("savePath : ");
//		System.out.println(savePath);
		
		// MAKING NEW FOLDER IF NO EXIST THE NAMED 'TEMP' FOLDER ON DB
		File saveDir = new File(savePath);
		if(!saveDir.isDirectory()) {
			saveDir.mkdirs();
		}
		
		List<String> saveFiles = new ArrayList<String>();
		String saveFileName = "";
		
		int editFname = 0;
		
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
		System.out.println("수정한 사진이름들===============" +saveFiles);
		for(int i = 0; i < saveFiles.size();i++){
			map.put("bsrAtchFname", saveFiles.get(i));
			// Board_ATCH 에 게시물 등록					
			editFname = stadiumboardatchDao.AddBoardAtch(map);
		}
		if(editBoard > 0 || editFname > 0) {
			returnMap.put("msg", "수정 완료");
		}
		return returnMap;
	}

// 	DELETE POSTING 
 	public Map<String, Object> deleteStadiumBoard (Map<String, Object> map) {
 		
 		Map<String, Object> returnMap = new HashMap<String, Object>();
 		
 		// select saved files' infos
 		List<Map<String, Object>> savedFname = stadiumboardDao.selectEachStadiumBoard(map);
 		
 		// delete the saved files
 		String webPath = 
 				this.getClass().getClassLoader().getResource("").getPath();
 		webPath = webPath.substring(0, webPath.indexOf("WEB-INF/"));
 		
 		for(int i = 0; i < savedFname.size(); i++) {
 			String originFname = (String) savedFname.get(i).get("BSR_ATCH_FNAME");
 			File killedFname = new File(webPath + "StadiumIamge/" + originFname);
 			killedFname.delete();
 		}
 		
 		// delete the saved Board infos
 		stadiumboardDao.deleteStadiumBoard(map);
 		stadiumboardatchDao.deleteStadiumAtchBoard(map);
 		returnMap.put("msg", "삭제 되었습니다.");
 		
 		 return returnMap;
 	}
 	
// 	ADD COMMENT ON POSTING
 	public Map<String, Object> addCommentBoard (
 			Map<String, Object> map,
 			HttpServletRequest req) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		Map<String, String> paramMap = Util.parseQueryString(req);
		
		int addComment = stadiumboardreplyDao.AddCommentBoard(paramMap);
		if(addComment > 0) {
			returnMap.put("msg", "댓글등록 완료");
		}
		return returnMap;
	}

// 	EDIT COMMENT ON POSTING
 	public Map<String, Object> editCommentBoard (Map<String, Object> map, HttpServletRequest req) {
 		
 		Map<String, Object> returnMap = new HashMap<String, Object>();
 		Map<String, String> paramMap = Util.parseQueryString(req);
 		
 		int editComment = stadiumboardreplyDao.editCommentBoard(paramMap);
 		if(editComment > 0){
 			returnMap.put("msg", "수정완료!");
 		}
 		return returnMap;
 	}
 	
//  DELETE COMMENT ON POSTING
 	public Map<String, Object> deleteCommentBoard (Map<String, Object> map) {
 		
 		Map<String, Object> returnMap = new HashMap<String, Object>();
 		
 		int deleteComment = stadiumboardreplyDao.deleteCommentBoard(map);
 		if(deleteComment > 0) {
 			returnMap.put("msg", "삭제완료");
 		}
 		return returnMap;
 	}
}
