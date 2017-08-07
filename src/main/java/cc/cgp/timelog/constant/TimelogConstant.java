/**
 * cc.cgp.timelog.constant.TimelogConstant.java
 * 2017年8月3日 上午11:49:48 by cgp
 */
package cc.cgp.timelog.constant;

import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

/**
 * cc.cgp.timelog.constant.TimelogConstant.java
 * 2017年8月3日 上午11:49:48 by cgp
 */
@Component
public class TimelogConstant {
	
	@Autowired
	private JdbcTemplate jdt;
	
	public static List<Map<String, Object>> TodoItemTypeList = null;
	public static List<Map<String, Object>> TodoItemStatusList = null;
	public static int a = 0;
	
	@PostConstruct  
    public void  init(){  
        a = 1;
        TimelogConstant.TodoItemTypeList = getTodoItemTypeList();
        TimelogConstant.TodoItemStatusList = getTodoItemStatusList();
        
    }  
	private List<Map<String, Object>> getTodoItemTypeList(){
		List<Map<String, Object>> maplist = jdt.queryForList(
				"select keyid,key,value,content from timelog_constant where type = 2 and status = 1 order by keyid");
		return maplist;
	}
	private List<Map<String, Object>> getTodoItemStatusList(){
		List<Map<String, Object>> maplist = jdt.queryForList(
				"select keyid,key,value,content from timelog_constant where type = 3 and status = 1 order by keyid");
		return maplist;
	}
	public static String parsetype(List<Map<String, Object>> list ,int value){
		String rtn = null;
		for (Map<String, Object> map : list) {
			if(value == Integer.parseInt((String)map.get("keyid"))){
				rtn = (String)map.get("content");
				break;
			}
		}
		return rtn;
	}
}

