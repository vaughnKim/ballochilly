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

import com.ballochilly.res.client.dao.stadium.StadiumDao;
import com.ballochilly.res.client.dao.stadium.StadiumGaleryDao;
import com.ballochilly.res.common.Util;


@Service
public class StadiumService {
	
	@Autowired
	StadiumDao stadiumDao;
	
	@Autowired
	StadiumGaleryDao stadiumGalDao;
	
	// 구장 등록
	public Map<String, Object> AddStadium (
			Map<String, Object> map, 
			MultipartHttpServletRequest mRequest,
			HttpServletRequest req) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		Map<String, String> paramMap = Util.parseQueryString(req);
		
		System.out.print("##########");
		System.out.println("AddStadium Service");
		
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
		
		// TEMP 폴더가 없다면 생성
		File saveDir = new File(savePath);
		if(!saveDir.isDirectory()) {
			saveDir.mkdirs();
		}
		
		// Stadium_Galery  SG_SEQ_NO
		int count = 0;
		
		List<String> saveFiles = new ArrayList<String>();
		String saveFileName = "";
		
//		파일 정보 추출, 데이터베이스 삽입
		Iterator<String> htmlNames = mRequest.getFileNames();
		while(htmlNames.hasNext()) {
			String htmlName = htmlNames.next();
			
//			// 파일이 한 개 일때
//			MultipartFile mFile = mRequest.getFile(htmlName); 
//			String oFileName = mFile.getOriginalFilename();
			
			//파일이 여러 개 일 때
			List<MultipartFile> mFiles = mRequest.getFiles(htmlName);
			for(int i = 0; i < mFiles.size(); i++) {
				String oFileName = mFiles.get(i).getOriginalFilename();

				//			파일이 없거나 공백일 때
				if(oFileName != null && !oFileName.trim().equals("")) {
					saveFileName = oFileName;
					
//					File target = new File(savePath + "/" + oFileName);
//					
////					파일명이 중복될 때
//					if(target.exists()){
//						System.out.println("파일 중복됨");
//						System.out.println("#########올린 원래 파일이름  : "+oFileName);
//						String fName = oFileName.substring(0, oFileName.lastIndexOf("."));
//						String extName = oFileName.substring(oFileName.lastIndexOf("."));
//						saveFileName  = fName + "_" + System.currentTimeMillis() + extName ;
//					}
					
					try {
						mFiles.get(i).transferTo(new File(savePath + "/" + saveFileName));
						System.out.println("#########멀티파트리퀘스트에 담긴 것  : "+mFiles.get(i));
						saveFiles.add(saveFileName);
					} catch (IllegalStateException | IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
		
		System.out.println(saveFiles);
		
		int addStadiuminfo = 0;
		int addStadiumGalery = 0;
		
		for(int i = 0; i < saveFiles.size(); i++) {
			if(i < 1){
				
//				map.put("file1", saveFiles.get(0));
//				map.put("file2", saveFiles.get(1));
//				map.put("file3", saveFiles.get(2));
//				stadiumDao.AddStadium(map);
				paramMap.put("file1", saveFiles.get(0));
				paramMap.put("file2", saveFiles.get(1));
				paramMap.put("file3", saveFiles.get(2));
				addStadiuminfo = stadiumDao.AddStadium(paramMap);
			} 
		}
		for(int j = 3; j < saveFiles.size(); j++) {
			map.put("sgSeqNo", ++count);
			map.put("file4", saveFiles.get(j));

			// 최종등록 게시물 번호
			int siSeqNo = stadiumDao.getLastBoardSeqNo();
			map.put("siSeqNo", siSeqNo);
			addStadiumGalery = stadiumGalDao.AddStadiumGalery(map);  
		}
		
		if(addStadiuminfo > 0 && addStadiumGalery > 0){
			returnMap.put("code", 200);
			returnMap.put("msg", "등록성공!");
		}
		
		return returnMap;
	}

	// 모든 구장 조회
	public Map<String, Object> selectAllStadium (Map<String, Object> map,
			HttpServletRequest req) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		System.out.print("##########");
		System.out.println("selectAllStadium Service");
		
		List<Map<String, Object>> list = stadiumDao.selectAllStadium(map);
		int totalCount = stadiumDao.getTotalStadiumNo(map);
		returnMap.put("AllStadium", list);
		returnMap.put("totalCount", totalCount);
		
		return returnMap;
	}
	
	// 각 구장 정보 조회
	public Map<String, Object> selectEachStadium (Map<String, Object> map) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		System.out.print("##########");
		System.out.println("selectEachStadium Service");
		
		List<Map<String, Object>> stadiumInfo = stadiumDao.selectEachStadium(map); 
		int courtNo = stadiumDao.getEachCourtNo(map);
		List<Map<String, Object>> stadiumGalery = stadiumGalDao.selectEachStadiumGalery(map); 
		
		returnMap.put("stadiumInfo", stadiumInfo);
		returnMap.put("courtNo", courtNo);
		returnMap.put("stadiumGalery", stadiumGalery);
		
		
		System.out.println(stadiumInfo);
		System.out.println(stadiumGalery);
		
		return returnMap;
	}
	
	// 각 구장 정보 수정
	public Map<String, Object> editAddStadium (
			Map<String, Object> map, 
			MultipartHttpServletRequest mRequest,
			HttpServletRequest req) {
				
		Map<String, Object> returnMap = new HashMap<String, Object>();
		Map<String, String> paramMap = Util.parseQueryString(req);
		
		System.out.print("##########");
		System.out.println("editAddStadium Service");
		
		// STADIUM_GALERY에 있던 기존 게시물 삭제
		int deleteGaleryFile = stadiumGalDao.deleteEachStadiumGalery(map);
		
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
		
		// TEMP 폴더가 없다면 생성
		File saveDir = new File(savePath);
		if(!saveDir.isDirectory()) {
			saveDir.mkdirs();
		}
		
		// Stadium_Galery  SG_SEQ_NO
		int count = 0;
		
		List<String> saveFiles = new ArrayList<String>();
		String saveFileName = "";
		
//		파일 정보 추출, 데이터베이스 삽입
		Iterator<String> htmlNames = mRequest.getFileNames();
		while(htmlNames.hasNext()) {
			String htmlName = htmlNames.next();
			
			//파일이 여러 개 일 때
			List<MultipartFile> mFiles = mRequest.getFiles(htmlName);
			for(int i = 0; i < mFiles.size(); i++) {
				String oFileName = mFiles.get(i).getOriginalFilename();

				//			파일이 없거나 공백일 때
				if(oFileName != null && !oFileName.trim().equals("")) {
					saveFileName = oFileName;
					
					try {
						mFiles.get(i).transferTo(new File(savePath + "/" + saveFileName));
						System.out.println("#########멀티파트리퀘스트에 담긴 것  : "+mFiles.get(i));
						saveFiles.add(saveFileName);
					} catch (IllegalStateException | IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
		
		System.out.println(saveFiles);
		
		int editStadiuminfo = 0;
		int editStadiumGalery = 0;
		
		for(int i = 0; i < saveFiles.size(); i++) {
			if(i < 1){
				paramMap.put("file1", saveFiles.get(0));
				paramMap.put("file2", saveFiles.get(1));
				paramMap.put("file3", saveFiles.get(2));
				editStadiuminfo = stadiumDao.editEachStadiumInfo(paramMap);
			} 
		}
		for(int j = 3; j < saveFiles.size(); j++) {
			map.put("sgSeqNo", ++count);
			map.put("file4", saveFiles.get(j));

			// 최종등록 게시물 번호
			int siSeqNo = stadiumDao.getLastBoardSeqNo();
			map.put("siSeqNo", siSeqNo);
			editStadiumGalery = stadiumGalDao.AddStadiumGalery(map);  
		}
		
		if(editStadiuminfo > 0 && editStadiumGalery > 0){
			returnMap.put("code", 200);
			returnMap.put("msg", "수정 성공!");
		}
		
		return returnMap;
		
	}
	
	
	// 구장 정보 삭제
	public Map<String, Object> deleteEachStadium (Map<String, Object> map) {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		// select saved files' infos
 		List<Map<String, Object>> savedFname = stadiumDao.selectEachStadium(map);
 		
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
 		int deleteInfo = stadiumDao.deleteEachStadiumInfo(map);
 		int deleteFile = stadiumGalDao.deleteEachStadiumGalery(map);
 		if(deleteInfo > 0 && deleteFile > 0) {
 			returnMap.put("code", 200);
 			returnMap.put("msg", "삭제 되었습니다.");
 		}
 		
 		 return returnMap;
		
	}
}
