/**
 * 
 */
package cc.cgp.timelog.bean;

import org.springframework.stereotype.Component;

import cc.cgp.util.DateTimeUtils;
import ch.qos.logback.core.subst.Token.Type;

/**
 * @author eicn 2017年6月6日 下午11:39:56
 *
 */
public class Timelog {

	//	开始时间
	private String startTime;
//	结束时间
	private String endTime;
//	默认日期
	private String defaultDate;
//	具体内容
	private String content;
//	消耗时间，分钟为单位
	private String timeCosted;
//	类型,默认为0：其他
	private int type;
//	timelog的id
	private int id;
	
	private int todoItemId;
	private String todoItemContent;
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	
	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getTimeCosted() {
		return timeCosted;
	}

	public void setTimeCosted(String timeCosted) {
		this.timeCosted = timeCosted;
	}

	public Timelog(){
		defaultDate = DateTimeUtils.getDateStr();
		startTime = DateTimeUtils.getDateTimeStr();
		endTime = DateTimeUtils.getDateTimeStr();
	}
	
	public String getDefaultDate() {
		return defaultDate;
	}
	public void setDefaultDate(String defaultDate) {
		this.defaultDate = defaultDate;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void timelog(String endTime) {
		this.endTime = endTime;
	}

	public int getTodoItemId() {
		return todoItemId;
	}

	public void setTodoItemId(int todoItemId) {
		this.todoItemId = todoItemId;
	}

	public String getTodoItemContent() {
		return todoItemContent;
	}

	public void setTodoItemContent(String todoItemContent) {
		this.todoItemContent = todoItemContent;
	}
}
