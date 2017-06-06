package cc.cgp.timelog.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cc.cgp.timelog.service.TimeLogService;

@Controller
@RequestMapping("/timelog")
public class TimeLogController {
	
	@Autowired
	private TimeLogService tservice;
	
	@RequestMapping("/index")
	public String index(){
		return "/timelog/timelogIndex.jsp";
	}
	@RequestMapping("/")
	public String writelog(){
		
		return "/timelog/timelogWrite.jsp";
	}

}
