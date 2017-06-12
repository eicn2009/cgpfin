package cc.cgp.timelog.controller;

import java.io.File;
import java.io.IOException;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.eclipse.jdt.internal.compiler.ast.FalseLiteral;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cc.cgp.timelog.bean.Timelog;
import cc.cgp.timelog.service.TimelogService;
import cc.cgp.util.DateTimeUtils;

@Controller
@RequestMapping("/timelog")
public class TimeLogController {

	@Autowired
	private TimelogService tservice;

	@RequestMapping("/index")
	public String index() throws IOException {
		System.out.println(System.getProperty("user.dir"));
		File directory = new File("");
		System.out.println(directory.getCanonicalPath());// 获取标准的路径
		System.out.println(directory.getAbsolutePath());// 获取绝对路径
		return "/timelog/timelogIndex.jsp";

	}

	/**
	 * 进入列表和添加日志页
	 * 
	 * @param model
	 * @return 2017年6月7日 下午4:09:40 by cgp
	 */
	@RequestMapping("")
	public String loghome(Timelog timelog, Model model) {
		// 获取当日 日志记录信息列表并输出到页面
		List<Map<String, Object>> list = tservice.getTimeLogListByDay(Calendar.getInstance());
		model.addAttribute("list", list);

		// 获取下一步要增加的记录信息输出到页面
		// Timelog timelog = new Timelog();
		if (list != null && list.size() > 0) {
			String endTime = (String) list.get(0).get("endtime");
			timelog.setStartTime(endTime);
		}
		model.addAttribute(timelog);
		return "/timelog/timelogWrite.jsp";
	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	/**
	 * 删除log
	 * @param id
	 * @return 2017年6月12日 下午6:26:45 by cgp
	 */
	public @ResponseBody String deletelog(@RequestParam int id) {
		int result = 0;
		if (id > 0) {
			result = tservice.deleteOne(id);
			if (result > 0) {
				return "success";
			}
			;
		}
		return "error";
	}

	/**
	 * 添加事件
	 * 
	 * @param timelog
	 * @param model
	 * @return 2017年6月7日 下午4:10:05 by cgp
	 */
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String writelog(Timelog timelog, Model model) {
		// 增加一条日志记录
		tservice.addOrUpdateOne(timelog);

		// 获取下一步要增加的记录信息输出到页面
		// timelog.setStartTime(timelog.getEndTime());
		// timelog.setEndTime(DateTimeUtils.getDateTimeStr());
		// model.addAttribute(timelog);
		//
		// 获取当日 日志记录信息列表并输出到页面
		// List list = tservice.getTimeLogListByDay(Calendar.getInstance());
		// model.addAttribute("list", list);
		return "redirect:/timelog";
	}
}
