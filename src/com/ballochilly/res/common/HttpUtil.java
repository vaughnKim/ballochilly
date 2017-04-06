package com.ballochilly.res.common;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;

public class HttpUtil {
	public static String sendGet(String url) {
		StringBuffer data = new StringBuffer();
		HttpGet httpGet = new HttpGet(url);
		HttpClient client = new DefaultHttpClient();
		HttpResponse response = null;
		BufferedReader br = null;
		try {
			response = client.execute(httpGet);
			br = new BufferedReader(
					new InputStreamReader(
							response.getEntity().getContent()));
			String line = null;
			while ((line = br.readLine()) != null) {
				data.append(line + "\n");
			}
			br.close();
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return data.toString();

	}
	
}
