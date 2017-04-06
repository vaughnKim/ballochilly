package com.ballochilly.res.client.controller.community;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class RuleController {
	
	@RequestMapping(value="rule", method=RequestMethod.GET)
	public ModelAndView rule(
			@RequestParam Map<String, Object> map) {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/community/rule/rule");
		
		return mav;
	}

}
