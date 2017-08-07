/**
 * cc.cgp.timelog.controller.TodoItemController.java
 * 2017年8月2日 下午3:53:35 by cgp
 */
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
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cc.cgp.timelog.bean.TodoItem;
import cc.cgp.timelog.constant.TimelogConstant;
import cc.cgp.timelog.service.TodoItemService;
import cc.cgp.util.DateTimeUtils;

/**
 * cc.cgp.timelog.controller.TodoItemController.java
 * 2017年8月2日 下午3:53:35 by cgp
 */
@Controller
@RequestMapping("/todoItem")
public class TodoItemController {
	
	@Autowired
	private TodoItemService tservice;

//	@RequestMapping("/index")
//	public String index() throws IOException {
//		System.out.println(System.getProperty("user.dir"));
//		File directory = new File("");
//		System.out.println(directory.getCanonicalPath());// 获取标准的路径
//		System.out.println(directory.getAbsolutePath());// 获取绝对路径
//		return "/timelog/timelogIndex.jsp";
//
//	}

	/**
	 * 进入列表和添加日志页
	 * 
	 * @param model
	 * @return 2017年6月7日 下午4:09:40 by cgp
	 */
	@RequestMapping("")
	public String loghome(TodoItem todoItem, Model model,@RequestParam(required=false) String defaultDateParam) {
		//获取默认日期		
		if(StringUtils.isEmpty(defaultDateParam)){
			defaultDateParam = DateTimeUtils.getDateStr();
		}else{
			todoItem.setDefaultDate(defaultDateParam);
		}
		// 获取当日 日志记录信息列表并输出到页面
		List<Map<String, Object>> list = tservice.getTodoItemListByDay(defaultDateParam);
		model.addAttribute("list", list);
		// 获取下一步要增加的记录信息输出到页面
		if (list != null && list.size() > 0) {
			String endTime = (String) list.get(0).get("endtime");
			todoItem.setStartTime(endTime);
		}
		model.addAttribute(todoItem);
//		查询数据保持
		model.addAttribute("todoItemSearch",todoItem);
		return "/timelog/todoItem.jsp";
	}

	
	/**
	 * 删除
	 * @param id
	 * @return 2017年6月12日 下午6:26:45 by cgp
	 */
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
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

	@RequestMapping(value = "/getTodoItemListContent", method = RequestMethod.GET)
	public @ResponseBody List<Map<String, Object>> getTodoItemListByContent(@RequestParam String content){
		return tservice.getTodoItemListByContent(content);
	}
	
	/**
	 * 添加事件
	 * 
	 * @param todoItem
	 * @param model
	 * @return 2017年6月7日 下午4:10:05 by cgp
	 */
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String writelog(TodoItem todoItem, Model model) {
		// 增加一条
		tservice.addOrUpdateOne(todoItem);
		return "redirect:/todoItem?defaultDateParam="+todoItem.getDefaultDate();
	}
	
	@RequestMapping(value = "/search", method = RequestMethod.POST)
	public String search(TodoItem todoItemSearch, Model model){
		Calendar searchdate = DateTimeUtils.getDate(todoItemSearch.getDefaultDate());
		// 获取当日 日志记录信息列表并输出到页面
		List<Map<String, Object>> list = tservice.getTodoItemList(todoItemSearch);
		model.addAttribute("list", list);
		// 获取下一步要增加的记录信息输出到页面
		if (list != null && list.size() > 0) {
			String endTime = (String) list.get(0).get("endtime");
			todoItemSearch.setStartTime(endTime);
		}
//		查询数据保持
		model.addAttribute("todoItemSearch",todoItemSearch);
//		编辑区数据保留默认时间TodoItem
		TodoItem todoItemEdit = new TodoItem();
		todoItemEdit.setDefaultDate(todoItemSearch.getDefaultDate());
		model.addAttribute("todoItem",todoItemEdit);
		return "/timelog/todoItem.jsp";
	}
	
	
}

