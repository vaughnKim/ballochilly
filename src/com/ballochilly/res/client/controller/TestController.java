package com.ballochilly.res.client.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class TestController {
	
	@RequestMapping(value = "maptest2", method=RequestMethod.GET)
	public ModelAndView cookieTest() {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("test/maptest2");
		return mav;
		
	}

}
