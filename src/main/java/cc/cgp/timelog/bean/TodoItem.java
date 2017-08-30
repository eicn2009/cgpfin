/**
 * cc.cgp.timelog.bean.TodoItem.java
 * 2017年8月2日 下午3:09:41 by cgp
 */
package cc.cgp.timelog.bean;

import java.util.List;
import java.util.Map;


import cc.cgp.timelog.constant.TimelogConstant;
import cc.cgp.util.DateTimeUtils;

/**
 * cc.cgp.timelog.bean.TodoItem.java
 * 2017年8月2日 下午3:09:41 by cgp
 */
public class TodoItem {
//	开始时间
	private String startTime;
//	结束时间
	private String endTime;
//	消耗时间，小时为单位
	private String timeCosted;
	
//	开始时间
	private String planStartTime;
//	结束时间
	private String planEndTime;
//	消耗时间，小时为单位
	private String planTimeCosted;
	
//	默认日期
	private String defaultDate;
//	内容简述
	private String content;
//	内容详情
	private String remark;

//	类型,默认为0：其他
	private int type;
//	todoitem的id
	private int id;
//	关联事项的id 替换的，前置的等等
	private int relationid;
//	当前事项的状态 
	private int status;
//	是否当日事项
	private String istoday;
//	状态变更时间（编辑时间）
	private String updateTime;
//	事项的优先级 用于排序等
	private int priority;
	
	private String strType;
	private String strStatus;
	
	private List<Map<String, Object>> typeList = TimelogConstant.TodoItemTypeList;
	private List<Map<String, Object>> statusList = TimelogConstant.TodoItemStatusList;

	private String StatusChecked;
	
	/**
	 * 
	 */
	public TodoItem() {
		defaultDate = DateTimeUtils.getDateStr();
		startTime = DateTimeUtils.getDateTimeStr();
		endTime = DateTimeUtils.getDateTimeStr();
		planStartTime = DateTimeUtils.getDateTimeStr();
		planEndTime = DateTimeUtils.getDateTimeStr();
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
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getDefaultDate() {
		return defaultDate;
	}
	public void setDefaultDate(String defaultDate) {
		this.defaultDate = defaultDate;
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
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getRelationid() {
		return relationid;
	}
	public void setRelationid(int relationid) {
		this.relationid = relationid;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	public void setIstoday(String istoday) {
		this.istoday = istoday;
	}

	public String getIstoday() {
		return istoday;
	}

	public List<Map<String, Object>> getTypeList() {
		return typeList;
	}

	public List<Map<String, Object>> getStatusList() {
		return statusList;
	}

	public String getStrType() {
		return strType;
	}

	

	public String getStrStatus() {
		return strStatus;
	}

	public String getStatusChecked() {
		return StatusChecked;
	}

	public void setStatusChecked(String statusChecked) {
		StatusChecked = statusChecked;
	}

	public int getPriority() {
		return priority;
	}

	public void setPriority(int priority) {
		this.priority = priority;
	}

	public String getPlanStartTime() {
		return planStartTime;
	}

	public void setPlanStartTime(String planStartTime) {
		this.planStartTime = planStartTime;
	}

	public String getPlanEndTime() {
		return planEndTime;
	}

	public void setPlanEndTime(String planEndTime) {
		this.planEndTime = planEndTime;
	}

	public String getPlanTimeCosted() {
		return planTimeCosted;
	}

	public void setPlanTimeCosted(String planTimeCosted) {
		this.planTimeCosted = planTimeCosted;
	}

	
	
}

