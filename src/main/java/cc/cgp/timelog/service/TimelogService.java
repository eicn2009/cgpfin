package cc.cgp.timelog.service;

import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
//import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import cc.cgp.timelog.bean.Timelog;
import cc.cgp.util.DateTimeUtils;

@Service
public class TimelogService {

	@Autowired
	private JdbcTemplate jdt;

	public List<Map<String, Object>> getTimeLogListByDay(Calendar calendar) {
		String dateStr = DateTimeUtils.getDateStr(calendar.getTime());
		return getTimeLogListByDay(dateStr);
	}
	
	public List<Map<String, Object>> getTimeLogListByDay(String dateStr) {
		List<Map<String, Object>> maplist = jdt.queryForList(
				"select ti.*,todo.id todoItemId,todo.content todoItemContent from timelog ti,todoitem todo where ti.todoitemid = todo.id and  (date(ti.starttime)=? or date(ti.endtime)=? or date(ti.createtime)=?) and ti.isdelete = 0 order by ti.endtime desc",
				dateStr, dateStr, dateStr);
		return maplist;
	}
	
	public int deleteOne(int id){
		return jdt.update("update timelog set isdelete = 1 where id = ?", id);
	}

	public int addOrUpdateOne(Timelog timelog) {
		int result = 0;
		if (timelog.getId() > 0) {
			result = jdt.update("update timelog set content=?,type=?,starttime=?,endtime=?,timecosted=?,todoitemid=? where id =? ",
					timelog.getContent(), timelog.getType(), timelog.getStartTime(), timelog.getEndTime(),
					timelog.getTimeCosted(),timelog.getTodoItemId(),timelog.getId());
		} else if (timelog.getId() == 0) {
			result = jdt.update("insert into timelog(content,type,starttime,endtime,timecosted,todoitemid) values(?,?,?,?,?,?)",
					timelog.getContent(), timelog.getType(), timelog.getStartTime(), timelog.getEndTime(),
					timelog.getTimeCosted(),timelog.getTodoItemId());
		}
		return result;
	}

	/**
	 * @param timelogSearch
	 * @return 2017年8月8日 上午11:34:19 by cgp
	 */
	public List<Map<String, Object>> getTimelogList(Timelog timelogSearch) {
		return getTimeLogListByDay(timelogSearch.getDefaultDate());
	}
}
