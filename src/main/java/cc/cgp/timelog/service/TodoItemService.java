/**
 * cc.cgp.timelog.service.TodoItemService.java
 * 2017年8月2日 下午7:33:25 by cgp
 */
package cc.cgp.timelog.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import cc.cgp.timelog.bean.TodoItem;
import cc.cgp.util.DateTimeUtils;

/**
 * cc.cgp.timelog.service.TodoItemService.java
 * 2017年8月2日 下午7:33:25 by cgp
 */
@Service
public class TodoItemService {
	@Autowired
	private JdbcTemplate jdt;

	public List<Map<String, Object>> getTodoItemListByDay(Calendar calendar) {
		String dateStr = DateTimeUtils.getDateStr(calendar.getTime());
		return getTodoItemListByDay(dateStr);
	}
	
	public List<Map<String, Object>> getTodoItemListByDay(String dateStr) {
		List<Map<String, Object>> maplist = jdt.queryForList(
				"select t.*,tc1.content strstatus,tc.content strtype from timelog_constant tc,timelog_constant tc1,todoitem t where tc.keyid = t.type and tc.type = 2 and tc1.keyid = t.status and tc1.type = 3 and t.isdelete = 0  and (date(t.starttime)=? or date(t.endtime)=? or date(t.createtime)=?) order by t.endtime desc",
				dateStr, dateStr, dateStr);
		return maplist;
	}
	
	public List<Map<String, Object>> getTodoItemList(TodoItem todoItem){
		String sql = "select t.*,tc1.content strstatus,tc.content strtype from timelog_constant tc,timelog_constant tc1,todoitem t where tc.keyid = t.type and tc.type = 2 and tc1.keyid = t.status and tc1.type = 3  and t.isdelete = 0 ";
		List <Object> queryList=new  ArrayList<Object>();
		if(!StringUtils.isEmpty(todoItem.getDefaultDate())){
			sql += " and (date(t.starttime)=? or date(t.endtime)=? or date(t.createtime)=?) ";
			queryList.add(todoItem.getDefaultDate());
			queryList.add(todoItem.getDefaultDate());
			queryList.add(todoItem.getDefaultDate());
		}
		if(!StringUtils.isEmpty(todoItem.getIstoday())){
			if("1".equals(todoItem.getIstoday())){
				sql += " and t.istoday = '1' ";
			}else if("0".equals(todoItem.getIstoday())){
				sql += " and t.istoday = '0' ";
			}
		}
		if(todoItem.getType()!=0){
			sql += " and t.type = ? ";
			queryList.add(todoItem.getType());
		}
		if(todoItem.getStatus()!=0){
			sql += " and t.status = ? ";
			queryList.add(todoItem.getStatus());
		}
		if(!StringUtils.isEmpty(todoItem.getContent())){
			sql += " and t.content like ? ";
			queryList.add("%"+todoItem.getContent()+"%");
		}
		
		sql += " order by t.id,t.endtime desc";
		
		List<Map<String, Object>> maplist = jdt.queryForList(sql, queryList.toArray());
		return maplist;
	}
	
	public int deleteOne(int id){
		return jdt.update("update todoItem set isdelete = 1 where id = ?", id);
	}

	public int addOrUpdateOne(TodoItem todoItem) {
		int result = 0;
		if(org.springframework.util.StringUtils.isEmpty(todoItem.getIstoday()))todoItem.setIstoday("0");
		if (todoItem.getId() > 0) {
			result = jdt.update("update todoItem set content=?,type=?,starttime=?,endtime=?,timecosted=?,remark=?,istoday=?,status=?,updatetime=? where id =? ",
					todoItem.getContent(), todoItem.getType(), todoItem.getStartTime(), todoItem.getEndTime(),
					todoItem.getTimeCosted(),todoItem.getRemark(),todoItem.getIstoday(),todoItem.getStatus(),DateTimeUtils.getDateTimeStr(),todoItem.getId());
		} else if (todoItem.getId() == 0) {
			result = jdt.update("insert into todoItem(content,type,starttime,endtime,timecosted,remark,istoday,status) values(?,?,?,?,?,?,?,?)",
					todoItem.getContent(), todoItem.getType(), todoItem.getStartTime(), todoItem.getEndTime(),
					todoItem.getTimeCosted(),todoItem.getRemark(),todoItem.getIstoday(),todoItem.getStatus());
		}
		return result;
	}
}
