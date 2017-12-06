/**
 * cc.cgp.fin.FinService.java
 * 2017年12月2日 下午8:01:08 by cgp
 */
package cc.cgp.fin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;

/**
 * cc.cgp.fin.FinService.java
 * 2017年12月2日 下午8:01:08 by cgp
 */
@Service
public class FinService {
	@Autowired
	private NamedParameterJdbcTemplate njdt;
//	String insertSql = "insert into test(name) values(:name)";  
//  String selectSql = "select * from test where name=:name";  
//  String deleteSql = "delete from test where name=:name";  
//  Map<String, Object> paramMap = new HashMap<String, Object>();  
//  paramMap.put("name", "name5");  
//  namedParameterJdbcTemplate.update(insertSql, paramMap);  
	/**
	 * 获取账户信息列表
	 * @param finAccount 
	 * @return 2017年12月5日 下午5:11:46 by cgp
	 */
	public List<Map<String,Object>> getAccountList(FinAccount finAccount) {
		
		String sql = "select cfa.id,cfa.name,cfa.balance,cfa.updatetime,cfa.canused, cfo.name as orgname,cfu.name as username,cfat.name as typename"
				+ " from cgp_fin_account cfa,cgp_fin_org cfo,cgp_fin_account_type cfat,cgp_fin_user cfu"
				+ " where cfa.orgid = cfo.id and cfa.userid = cfu.id and cfa.type = cfat.id and cfa.isdelete = :isdelete ";
		Map<String, Object> paramMap = new HashMap<String, Object>(); 
		paramMap.put("isdelete", 0);
		
		if(finAccount!=null){
			if(finAccount.getCanused()>-1){
				sql += " and cfa.canused = :canused";
				paramMap.put("canused", finAccount.getCanused());
			}
			if(finAccount.getUserid()>-1){
				sql += " and cfa.userid = :userid";
				paramMap.put("userid", finAccount.getUserid());
			}
			if(finAccount.getOrgid()>-1){
				sql += " and cfa.orgid = :orgid";
				paramMap.put("orgid", finAccount.getOrgid());
			}
			if(finAccount.getType()>-1){
				sql += " and cfa.type = :type";
				paramMap.put("type", finAccount.getType());
			}
		}
		
		
		return njdt.queryForList(sql, paramMap);
	}
	
	/**
	 * 获取账户余额总数
	 * @param finAccount
	 * @return 2017年12月6日 下午12:22:27 by cgp
	 */
	public float getAccountBalanceSum(FinAccount finAccount) {
		String sql = "select sum(cfa.balance) as sum from cgp_fin_account cfa where cfa.isdelete = :isdelete ";
		Map<String, Object> paramMap = new HashMap<String, Object>(); 
		paramMap.put("isdelete", 0);
		
		if(finAccount!=null){
			if(finAccount.getCanused()>-1){
				sql += " and cfa.canused = :canused";
				paramMap.put("canused", finAccount.getCanused());
			}
			if(finAccount.getUserid()>-1){
				sql += " and cfa.userid = :userid";
				paramMap.put("userid", finAccount.getUserid());
			}
			if(finAccount.getOrgid()>-1){
				sql += " and cfa.orgid = :orgid";
				paramMap.put("orgid", finAccount.getOrgid());
			}
			if(finAccount.getType()>-1){
				sql += " and cfa.type = :type";
				paramMap.put("type", finAccount.getType());
			}
		}
		
		
		return Float.parseFloat(njdt.queryForMap(sql, paramMap).get("sum").toString());
	}
	
	/**
	 * 获取金融机构列表
	 * @return 2017年12月6日 上午11:06:59 by cgp
	 */
	public List<Map<String,Object>> getOrgList(){
		String sql = "select id,name from cgp_fin_org where isdelete = :isdelete";
		Map<String, Object> paramMap = new HashMap<String, Object>(); 
		paramMap.put("isdelete", 0);
		return njdt.queryForList(sql, paramMap);
	}
	/**
	 * 获取用户列表
	 * @return 2017年12月6日 上午11:07:26 by cgp
	 */
	public List<Map<String,Object>> getUserList(){
		String sql = "select id,name from cgp_fin_user where isdelete = :isdelete";
		Map<String, Object> paramMap = new HashMap<String, Object>(); 
		paramMap.put("isdelete", 0);
		return njdt.queryForList(sql, paramMap);
	}
	
	/**
	 * 获取用户账户类型
	 * @return 2017年12月6日 上午11:07:26 by cgp
	 */
	public List<Map<String,Object>> getAccountTypeList(){
		String sql = "select id,name from cgp_fin_account_type where isdelete = :isdelete";
		Map<String, Object> paramMap = new HashMap<String, Object>(); 
		paramMap.put("isdelete", 0);
		return njdt.queryForList(sql, paramMap);
	}
}

