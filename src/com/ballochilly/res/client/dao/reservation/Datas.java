package com.ballochilly.res.client.dao.reservation;

import java.util.Arrays;

public class Datas {
	String[] year, month, day, startTime, endTime, court, id, stadiumName;

	public String[] getYear() {
		return year;
	}

	public void setYear(String[] year) {
		this.year = year;
	}

	public String[] getMonth() {
		return month;
	}

	public void setMonth(String[] month) {
		this.month = month;
	}

	public String[] getDay() {
		return day;
	}

	public void setDay(String[] day) {
		this.day = day;
	}

	public String[] getStartTime() {
		return startTime;
	}

	public void setStartTime(String[] startTime) {
		this.startTime = startTime;
	}

	public String[] getEndTime() {
		return endTime;
	}

	public void setEndTime(String[] endTime) {
		this.endTime = endTime;
	}

	public String[] getCourt() {
		return court;
	}

	public void setCourt(String[] court) {
		this.court = court;
	}

	public String[] getId() {
		return id;
	}

	public void setId(String[] id) {
		this.id = id;
	}

	public String[] getStadiumName() {
		return stadiumName;
	}

	public void setStadiumName(String[] stadiumName) {
		this.stadiumName = stadiumName;
	}

	@Override
	public String toString() {
		return "Datas [year=" + Arrays.toString(year) + ", month="
				+ Arrays.toString(month) + ", day=" + Arrays.toString(day)
				+ ", startTime=" + Arrays.toString(startTime) + ", endTime="
				+ Arrays.toString(endTime) + ", court="
				+ Arrays.toString(court) + ", id=" + Arrays.toString(id)
				+ ", stadiumName=" + Arrays.toString(stadiumName) + "]";
	}
}