package com.ballochilly.res.client.dao.reservation;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface ReservationDao {
	public List<Map<String, Object>> selectReservationStadium(Map<String, Object> map);
	
	public int insertReservationStadium(Map<String, Object> map);
	
	public int insertReservationFinal(Map<String, Object> map);
	
	public List<Map<String, Object>> selectReservationList(Map<String, Object> map);
	
	public List<Map<String, Object>> selectSiSeqNo(Map<String, Object> map);
	
	public List<Map<String, Object>> selectMyReservation(Map<String, Object>map);
	
	public int getTotalCount (Map<String, Object> map);
	
	public int reservationDelete(Map<String, Object> map);
	
	public List<Map<String, Object>> mainReservation(Map<String, Object>map);
	
	public List<Map<String, Object>> SimplelocationReservation(Map<String, Object>map);
	
	public int getEachCourtNo (Map<String, Object> map);
	
	public List<Map<String, Object>> SimPlelocationCourt(Map<String, Object>map);

}
