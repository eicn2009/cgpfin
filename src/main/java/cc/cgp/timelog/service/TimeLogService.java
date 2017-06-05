package cc.cgp.timelog.service;

import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

public class TimeLogService {
	
	@Autowired
	private JdbcTemplate jdt;
	
	public List<Map<String, Object>> getTimeLogListByDay(Calendar calendar){
		List<Map<String, Object>> maplist = jdt.queryForList("select * from timelog");
		return maplist;
	}
	
}
