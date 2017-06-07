package cc.cgp.timelog.controller;

import java.util.Calendar;
import java.util.List;

import org.eclipse.jdt.internal.compiler.ast.FalseLiteral;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import cc.cgp.timelog.bean.Timelog;
import cc.cgp.timelog.service.TimelogService;
import cc.cgp.util.DateTimeUtils;

@Controller
@RequestMapping("/timelog")
public class TimeLogController {
	
	@Autowired
	private TimelogService tservice;
	
	@RequestMapping("/index")
	public String index(){
		return "/timelog/timelogIndex.jsp";
	}
	/**
	 * 进入列表和添加日志页
	 * @param model
	 * @return 2017年6月7日 下午4:09:40 by cgp
	 */
	@RequestMapping("")
	public String loghome(Model model){
		model.addAttribute(new Timelog());
		return "/timelog/timelogWrite.jsp";
	}
	/**
	 * 添加事件
	 * @param timelog
	 * @param model
	 * @return 2017年6月7日 下午4:10:05 by cgp
	 */
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public String writelog(Timelog timelog ,Model model){
		tservice.addOne(timelog);
		model.addAttribute(timelog);
		List list = tservice.getTimeLogListByDay(Calendar.getInstance());
		model.addAttribute("list", list);
		return "/timelog/timelogWrite.jsp";
	}
}
