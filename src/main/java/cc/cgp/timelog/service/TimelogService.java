package cc.cgp.timelog.service;

import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
//import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import cc.cgp.timelog.bean.Timelog;
import cc.cgp.util.DateTimeUtils;

@Service
public class TimelogService {

	@Autowired
	private JdbcTemplate jdt;

	public List<Map<String, Object>> getTimeLogListByDay(Calendar calendar) {
		String dateStr = DateTimeUtils.getDateStr(calendar.getTime());
		List<Map<String, Object>> maplist = jdt.queryForList(
				"select * from timelog where (date(starttime)=? or date(endtime)=? or date(createtime)=?) and isdelete = 0 order by endtime desc",
				dateStr, dateStr, dateStr);
		return maplist;
	}
	
	public int deleteOne(int id){
		return jdt.update("update timelog set isdelete = 1 where id = ?", id);
	}

	public int addOrUpdateOne(Timelog timelog) {
		int result = 0;
		if (timelog.getId() > 0) {
			result = jdt.update("update timelog set content=?,type=?,starttime=?,endtime=?,timecosted=? where id =? ",
					timelog.getContent(), timelog.getType(), timelog.getStartTime(), timelog.getEndTime(),
					timelog.getTimeCosted(),timelog.getId());
		} else if (timelog.getId() == 0) {
			result = jdt.update("insert into timelog(content,type,starttime,endtime,timecosted) values(?,?,?,?,?)",
					timelog.getContent(), timelog.getType(), timelog.getStartTime(), timelog.getEndTime(),
					timelog.getTimeCosted());
		}
		return result;
	}
}
