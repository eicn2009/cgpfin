package cc.cgp.timelog.service;

import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import cc.cgp.timelog.bean.Timelog;

@Service
public class TimelogService {

	@Autowired
	private JdbcTemplate jdt;

	public List<Map<String, Object>> getTimeLogListByDay(Calendar calendar) {
		List<Map<String, Object>> maplist = jdt.queryForList("select * from timelog");
		return maplist;
	}

	public int addOne(Timelog timelog) {
		return jdt.update("insert into timelog(content,type,starttime,endtime,timecosted) values(?,?,?,?,?)",
				timelog.getContent(), timelog.getType(), timelog.getStartTime(), timelog.getEndTime(),
				timelog.getTimeCosted());
	}
}
