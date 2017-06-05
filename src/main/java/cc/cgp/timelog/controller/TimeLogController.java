package cc.cgp.timelog.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/timelog")
public class TimeLogController {
	
	
	@RequestMapping("/index")
	public String index(){
		return "/timelog/timelogIndex";
	}

}
