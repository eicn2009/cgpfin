/**
 * cc.cgp.fin.FinService.java
 * 2017年12月2日 下午8:01:08 by cgp
 */
package cc.cgp.fin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cc.cgp.util.CamelUtil;
import cc.cgp.util.DateTimeUtil;

/**
 * cc.cgp.fin.FinService.java
 * 2017年12月2日 下午8:01:08 by cgp
 */
@Service
public class FinService {
	@Autowired
	private NamedParameterJdbcTemplate njdt;
	@Autowired
	private JdbcTemplate jdt;
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
	public List<FinAccount> getAccountList(FinAccount finAccount) {
		
		String sql = "select fac.ac_id,fac.ac_name,fac.ac_balance,fac.ac_update_time,fac.ac_canused, forg.org_name,fuser.user_name ,factype.actype_name"
				+ " from fin_account fac,fin_org forg,fin_account_type factype,fin_user fuser"
				+ " where fac.org_id = forg.org_id and fac.user_id = fuser.user_id and fac.actype_id = factype.actype_id and fac.ac_isdelete = :isdelete ";
		Map<String, Object> paramMap = new HashMap<String, Object>(); 
		paramMap.put("isdelete", 0);
		
		if(finAccount!=null){
			if(finAccount.getAcCanused()>-1){
				sql += " and fac.ac_canused = :canused";
				paramMap.put("canused", finAccount.getAcCanused());
			}
			if(finAccount.getUserId()>-1){
				sql += " and fac.user_id = :userId";
				paramMap.put("userId", finAccount.getUserId());
			}
			if(finAccount.getOrgId()>-1){
				sql += " and fac.org_id = :orgId";
				paramMap.put("orgId", finAccount.getOrgId());
			}
			if(finAccount.getActypeId()>-1){
				sql += " and fac.actype_id = :type";
				paramMap.put("type", finAccount.getActypeId());
			}
		}
		return njdt.query(sql, paramMap, new BeanPropertyRowMapper<FinAccount>(FinAccount.class));
	}
		/**
		 * 通过acId获取account实体
		 * @param acId
		 * @return 2017年12月16日 下午3:13:05 by cgp
		 */
		public FinAccount getAccount(int acId){
			String sql = "select fac.ac_id,fac.ac_name,fac.ac_balance,fac.ac_update_time,fac.ac_canused, forg.org_name,fuser.user_name ,factype.actype_name"
					+ " from fin_account fac,fin_org forg,fin_account_type factype,fin_user fuser"
					+ " where fac.org_id = forg.org_id and fac.user_id = fuser.user_id and fac.actype_id = factype.actype_id"
					+ " and fac.ac_isdelete = :isdelete and fac.ac_id = :acId";
			Map<String, Object> paramMap = new HashMap<String, Object>(); 
			paramMap.put("isdelete", 0);
			paramMap.put("acId", acId);
			return njdt.queryForObject(sql, paramMap, new BeanPropertyRowMapper<FinAccount>(FinAccount.class));
		}

		
		/**
		 * 根据收支数据调整余额后返回调整后的余额数据
		 * @param acioMoney
		 * @param acId
		 * @return 2017年12月16日 下午3:38:02 by cgp
		 */
		public float changeAccountBalance(float acioMoney,int acId){
			float acBlance = 0f;
			String sql = "update fin_account set ac_balance = ac_balance + :acioMoney,ac_update_time = :acUpdateTime where ac_id = :acId";
			Map<String, Object> paramMap = new HashMap<String, Object>(); 
			paramMap.put("acioMoney", acioMoney);
			paramMap.put("acId", acId);
			paramMap.put("acUpdateTime", DateTimeUtil.getDateTimeStr());
			int result = njdt.update(sql, paramMap);
			if(result>0){
				FinAccount finAccount = getAccount(acId);
				acBlance = finAccount.getAcBalance();
			}
			return acBlance;
		}
	
	/**
	 * 获取账户余额总数
	 * @param finAccount
	 * @return 2017年12月6日 下午12:22:27 by cgp
	 */
	public float getAccountBalanceSum(FinAccount finAccount) {
		String sql = "select ifnull( sum(fac.ac_balance),0) as sum from fin_account fac where fac.ac_isdelete = :isdelete ";
		Map<String, Object> paramMap = new HashMap<String, Object>(); 
		paramMap.put("isdelete", 0);
		
		if(finAccount!=null){
			if(finAccount.getAcCanused()>-1){
				sql += " and fac.ac_canused = :canused";
				paramMap.put("canused", finAccount.getAcCanused());
			}
			if(finAccount.getUserId()>-1){
				sql += " and fac.user_id = :userid";
				paramMap.put("userid", finAccount.getUserId());
			}
			if(finAccount.getOrgId()>-1){
				sql += " and fac.org_id = :orgid";
				paramMap.put("orgid", finAccount.getOrgId());
			}
			if(finAccount.getActypeId()>-1){
				sql += " and fac.actype_id = :type";
				paramMap.put("type", finAccount.getActypeId());
			}
		}
		
		
		return njdt.queryForObject(sql, paramMap, Float.class).floatValue();
	}
	
	/**
	 * 获取金融机构列表
	 * @return 2017年12月6日 上午11:06:59 by cgp
	 */
	public List<Map<String,Object>> getOrgList(){
		String sql = "select org_id,org_name from fin_org where org_isdelete = 0";
		return CamelUtil.getCamelMapList (jdt.queryForList(sql));
	}
	/**
	 * 获取用户列表
	 * @return 2017年12月6日 上午11:07:26 by cgp
	 */
	public List<Map<String,Object>> getUserList(){
		String sql = "select user_id,user_name from fin_user where user_isdelete = 0";
		return CamelUtil.getCamelMapList (jdt.queryForList(sql));
	}
	
	/**
	 * 获取用户账户类型
	 * @return 2017年12月6日 上午11:07:26 by cgp
	 */
	public List<Map<String,Object>> getAccountTypeList(){
		String sql = "select actype_id,actype_name from fin_account_type where actype_isdelete = 0";
		return CamelUtil.getCamelMapList (jdt.queryForList(sql));
	}
	
	/**
	 * 
	 * @param inorout 1：收入 2:支出 
	 * @return 2017年12月9日 下午5:33:54 by cgp
	 */
	public List<Map<String,Object>> getAccountInoutTypeList(int inorout){
		String sql = "select aciotypea.aciotype_id,aciotypea.aciotype_name,aciotypea.aciotype_inorout,aciotypeb.aciotype_name as parentname "
				+ " from fin_account_inout_type aciotypea,fin_account_inout_type aciotypeb "
				+ " where aciotypea.aciotype_level = 2 and aciotypea.aciotype_isdelete = :isdelete and aciotypeb.aciotype_level = 1 and aciotypea.aciotype_parent_id = aciotypeb.aciotype_id ";
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("isdelete", 0);
		if(inorout>0){
			sql += " and aciotypea.aciotype_inorout = :inorout ";
			paramMap.put("inorout", inorout);
		}
		sql +=  " order by aciotypeb.aciotype_seq,aciotypeb.aciotype_id,aciotypea.aciotype_seq,aciotypea.aciotype_id";
		
		return  CamelUtil.getCamelMapList(njdt.queryForList(sql, paramMap));
	}
	
	
	/**
	 * @param acioId
	 * @return 2017年12月15日 下午10:20:06 by cgp
	 */
//	TODO:添加事务处理
	public int deleteFinAccountInout(int acioId) {
		FinAccountInout accountInout = getFinAccountInout(acioId);
		
		float acBalance = changeAccountBalance(-accountInout.getAcioMoney(), accountInout.getAcId());
		
		int result = 0;
		String sql =  "update fin_account_inout set acio_isdelete=1 where acio_id = :acioId";
			Map<String, Object> paramMap = new HashMap<String, Object>(); 
			paramMap.put("acioId", acioId);
		result = njdt.update(sql, paramMap);
		return result;
	}
	
	public FinAccountInout getFinAccountInout(int acioId){
		String sql = "SELECT facio.acio_id,facio.ac_id,fac.ac_name,facio.aciotype_id,faciotype.aciotype_name,faciotype.aciotype_inorout, facio.acio_desc,fuser.user_id,fuser.user_name,"
				+ " facio.acio_money,facio.acio_balance,facio.acio_happened_time,facio.acio_create_time "
				+ " from fin_account_inout facio,fin_account_inout_type faciotype,fin_user fuser,fin_account fac "
				+ " where facio.acio_isdelete = :isdelete and facio.aciotype_id = faciotype.aciotype_id and facio.user_id = fuser.user_id and facio.ac_id = fac.ac_id "
				+ " and facio.acio_id = :acioId";
		
		Map<String, Object> paramMap = new HashMap<String, Object>(); 
		paramMap.put("isdelete", 0);
		paramMap.put("acioId", acioId);
		return njdt.queryForObject(sql, paramMap, new BeanPropertyRowMapper<FinAccountInout>(FinAccountInout.class));
	}

	/**
	 * @param finAccountInout
	 * @return 2017年12月10日 下午4:54:52 by cgp
	 */
//	@Transactional TODO:添加事务处理
	public int addOrUpdateFinAccountInout(FinAccountInout finAccountInout) {
		
		boolean isupdate = false;
		if (finAccountInout.getAcioId() != -1){
			isupdate = true;
		}
		
		
//		客户端传入的支出数据为正值，需要处理为负值
		float acioMoney = 0f;
		int aciotypeInorout = finAccountInout.getAciotypeInorout();
		if(aciotypeInorout == 2){
			acioMoney = -finAccountInout.getAcioMoney();
		}else if(aciotypeInorout == 1){
			acioMoney = finAccountInout.getAcioMoney();
		}
		
//		如果为更新数据，需要调整更新后账户余额		
		float changeMoney = acioMoney;
		if(isupdate){
			FinAccountInout finAccountInoutOld = getFinAccountInout(finAccountInout.getAcioId());
			float oldAcioMoney = finAccountInoutOld.getAcioMoney();
			changeMoney = acioMoney - oldAcioMoney;
		}
		
//		调整余额 为收入则增加余额，支出则减少余额
		changeAccountBalance(changeMoney, finAccountInout.getAcId());
		
		
		int result = 0;
		String sql = "";
		if (isupdate) {
			sql = "update fin_account_inout set aciotype_id=:type,acio_desc=:desc,acio_money=:money,user_id=:userid,acio_balance=:balance,"
					+ "ac_id=:accountid,acio_happened_time=:happenedtime,acio_isdelete=:isdelete where acio_id = :id";
		} else {
			sql = "insert into fin_account_inout(aciotype_id,acio_desc,acio_money,user_id,acio_balance,ac_id,acio_happened_time,acio_isdelete) "
					+ "values(:type,:desc,:money,:userid,:balance,:accountid,:happenedtime,:isdelete)";
		}
		Map<String, Object> paramMap = new HashMap<String, Object>(); 
		paramMap.put("type", finAccountInout.getAciotypeId());
		paramMap.put("desc", finAccountInout.getAcioDesc());
		
		
		//支出money记录为负值
		paramMap.put("money", acioMoney+"");
		paramMap.put("userid", finAccountInout.getUserId());
		paramMap.put("balance", finAccountInout.getAcioBalance());
		paramMap.put("accountid", finAccountInout.getAcId());
		paramMap.put("happenedtime", finAccountInout.getAcioHappenedTime());
		paramMap.put("isdelete", 0);
		if(isupdate){
			paramMap.put("id", finAccountInout.getAcioId());
		}
//		SqlParameterSource ps=new BeanPropertySqlParameterSource(stu);
//	    KeyHolder keyholder=new GeneratedKeyHolder();
		//加上KeyHolder这个参数可以得到添加后主键的值
//		int m=keyholder.getKey().intValue();
		result = njdt.update(sql, paramMap);
		
		
		
		return result;
	}

	/**
	 * @param finAccountInOut
	 * @return 2017年12月10日 下午6:10:54 by cgp
	 */
	public List<Map<String, Object>> getAccountInoutList(FinAccountInout finAccountInout) {
		
		String sql = "SELECT facio.acio_id,facio.ac_id,fac.ac_name,facio.aciotype_id,faciotype.aciotype_name,faciotype.aciotype_inorout, facio.acio_desc,fuser.user_id,fuser.user_name,"
				+ " facio.acio_money,facio.acio_balance,facio.acio_happened_time,facio.acio_create_time "
				+ " from fin_account_inout facio,fin_account_inout_type faciotype,fin_user fuser,fin_account fac "
				+ " where facio.acio_isdelete = :isdelete and facio.aciotype_id = faciotype.aciotype_id and facio.user_id = fuser.user_id and facio.ac_id = fac.ac_id "
				+ " order by facio.acio_happened_time desc,facio.acio_id desc";
		
		Map<String, Object> paramMap = new HashMap<String, Object>(); 
		paramMap.put("isdelete", 0);

		return  CamelUtil.getCamelMapList (njdt.queryForList(sql, paramMap));
		
	}

	
	
	
	 
	
	
	
}

