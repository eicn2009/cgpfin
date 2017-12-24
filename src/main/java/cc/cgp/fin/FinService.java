/**
 * cc.cgp.fin.FinService.java
 * 2017年12月2日 下午8:01:08 by cgp
 */
package cc.cgp.fin;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.tomcat.jdbc.pool.interceptor.SlowQueryReport;
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
			if(finAccountInoutOld.getAcId()==finAccountInout.getAcId()){
//				调整余额 为收入则增加余额，支出则减少余额
				changeAccountBalance(changeMoney, finAccountInout.getAcId());
			}else{
				changeAccountBalance(-oldAcioMoney, finAccountInoutOld.getAcId());
				changeAccountBalance(acioMoney, finAccountInout.getAcId());
			}
			
		}else{
//			调整余额 为收入则增加余额，支出则减少余额
			changeAccountBalance(changeMoney, finAccountInout.getAcId());
		}
		

		
		
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
				+ " where facio.acio_isdelete = :isdelete and facio.aciotype_id = faciotype.aciotype_id and facio.user_id = fuser.user_id and facio.ac_id = fac.ac_id ";
		Map<String, Object> paramMap = new HashMap<String, Object>(); 
		paramMap.put("isdelete", 0);
		if(finAccountInout!=null){
			if(finAccountInout.getAcId()>-1){
				sql += " and facio.ac_id = :acId";
				paramMap.put("acId", finAccountInout.getAcId());
			}
			if(finAccountInout.getAciotypeInorout()>-1){
				sql += " and faciotype.aciotype_inorout = :aciotypeInorout";
				paramMap.put("aciotypeInorout", finAccountInout.getAciotypeInorout());
			}
			if(finAccountInout.getAcioHappenedTime()!=null){
				sql += " and facio.acio_happened_time like :acioHappenedTime";
				paramMap.put("acioHappenedTime", finAccountInout.getAcioHappenedTime()+"%");
			}
		}
		sql += " order by facio.acio_happened_time desc,facio.acio_id desc";

		return  CamelUtil.getCamelMapList (njdt.queryForList(sql, paramMap));
		
	}
	/**
	 * @param finAccountTransfer
	 * @return 2017年12月17日 下午5:13:23 by cgp
	 */
	public List<FinAccountTransfer> getAccountTransferList(FinAccountTransfer finAccountTransfer) {
		String sql =  "select acf.ac_id as acIdFrom,acf.ac_name as acNameFrom,act.ac_id as acIdTo,act.ac_name as acNameTo,user.user_id,user.user_name, "
				+ " actr.actr_id,actr.actr_desc,actr.actr_money,actr.actr_happened_time,actr.actr_create_time "
				+ " from fin_account_transfer actr,fin_account acf,fin_account act,fin_user user "
				+ " where actr.actr_isdelete = :actrIsdelete and actr.ac_id_from = acf.ac_id "
				+ " and actr.ac_id_to = act.ac_id and actr.user_id = user.user_id "
				+ " order by actr.actr_happened_time DESC,actr.ac_id_from DESC,actr.actr_id DESC";
		
		Map<String, Object> paramMap = new HashMap<String, Object>(); 
		paramMap.put("actrIsdelete", 0);
		return  njdt.query(sql, paramMap,new BeanPropertyRowMapper<FinAccountTransfer>(FinAccountTransfer.class));
	}
	/**
	 * @param finAccountTransfer
	 * @return 2017年12月17日 下午7:49:33 by cgp
	 */
	public int addOrUpdateFinAccountTransfer(FinAccountTransfer finAccountTransfer) {
		
		boolean isupdate = false;
		if (finAccountTransfer.getActrId() != -1){
			isupdate = true;
		}
		
		

		
//		如果为更新数据，需要调整更新后账户余额		
		float changeMoney = finAccountTransfer.getActrMoney();
		if(isupdate){
			FinAccountTransfer finAccountTransferOld = getFinAccountTransfer(finAccountTransfer.getActrId());
			float oldMoney = finAccountTransferOld.getActrMoney();
			
			if(finAccountTransferOld.getAcIdFrom() == finAccountTransfer.getAcIdFrom()){
				changeMoney = changeMoney - oldMoney;
				changeAccountBalance(-changeMoney, finAccountTransfer.getAcIdFrom());
			}else{
				changeAccountBalance(oldMoney, finAccountTransferOld.getAcIdFrom());
				changeAccountBalance(-changeMoney, finAccountTransfer.getAcIdFrom());
			}
			
			if(finAccountTransferOld.getAcIdTo() == finAccountTransfer.getAcIdTo()){
				changeMoney = changeMoney - oldMoney;
				changeAccountBalance(changeMoney, finAccountTransfer.getAcIdTo());
			}else{
				changeAccountBalance(-oldMoney, finAccountTransferOld.getAcIdTo());
				changeAccountBalance(changeMoney, finAccountTransfer.getAcIdTo());
			}
			
			
		}else{
//			调整余额 转出账户减少，转入账户增加
			changeAccountBalance(-changeMoney, finAccountTransfer.getAcIdFrom());
			changeAccountBalance(changeMoney, finAccountTransfer.getAcIdTo());
		}
		

		
		
		int result = 0;
		String sql = "";
		if (isupdate) {
			sql = "update fin_account_transfer set actr_desc=:actrDesc,actr_money=:actrMoney,user_id=:userId,"
					+ "ac_id_from=:acIdFrom,ac_id_to=:acIdTo,actr_happened_time=:actrHappenedTime,actr_isdelete=:actrIsdelete where actr_id = :actrId";
		} else {
			sql = "insert into fin_account_transfer(actr_desc,actr_money,user_id,ac_id_from,ac_id_to,actr_happened_time,actr_isdelete) "
					+ "values(:actrDesc,:actrMoney,:userId,:acIdFrom,:acIdTo,:actrHappenedTime,:actrIsdelete)";
		}
		Map<String, Object> paramMap = new HashMap<String, Object>(); 
		paramMap.put("actrDesc", finAccountTransfer.getActrDesc());
		paramMap.put("actrMoney", finAccountTransfer.getActrMoney()+"");
		paramMap.put("userId", finAccountTransfer.getUserId()+"");
		paramMap.put("acIdFrom", finAccountTransfer.getAcIdFrom());
		paramMap.put("acIdTo", finAccountTransfer.getAcIdTo());
		paramMap.put("actrHappenedTime", finAccountTransfer.getActrHappenedTime());
		paramMap.put("actrIsdelete", 0);
		if(isupdate){
			paramMap.put("actrId", finAccountTransfer.getActrId());
		}
		result = njdt.update(sql, paramMap);
		return result;
	}
	/**
	 * @param actrId
	 * @return 2017年12月17日 下午9:48:48 by cgp
	 */
	private FinAccountTransfer getFinAccountTransfer(int actrId) {
		String sql =  "select acf.ac_id as acIdFrom,acf.ac_name as acNameFrom,act.ac_id as acIdTo,act.ac_name as acNameTo,user.user_id,user.user_name, "
				+ " actr.actr_id,actr.actr_desc,actr.actr_money,actr.actr_happened_time,actr.actr_create_time "
				+ " from fin_account_transfer actr,fin_account acf,fin_account act,fin_user user "
				+ " where actr.actr_isdelete = :actrIsdelete and actr.ac_id_from = acf.ac_id "
				+ " and actr.ac_id_to = act.ac_id and actr.user_id = user.user_id and actr.actr_id = :actrId"
				+ " order by actr.actr_happened_time DESC,actr.ac_id_from DESC,actr.actr_id DESC";
		
		Map<String, Object> paramMap = new HashMap<String, Object>(); 
		paramMap.put("actrIsdelete", 0);
		paramMap.put("actrId", actrId);
		return  njdt.queryForObject(sql, paramMap,new BeanPropertyRowMapper<FinAccountTransfer>(FinAccountTransfer.class));
	
	}
	/**
	 * @param actrId
	 * @return 2017年12月17日 下午10:27:27 by cgp
	 */
	public int deleteFinAccountTransfer(int actrId) {
		FinAccountTransfer accountTransfer = getFinAccountTransfer(actrId);
		
		changeAccountBalance(accountTransfer.getActrMoney(), accountTransfer.getAcIdFrom());
		changeAccountBalance(-accountTransfer.getActrMoney(), accountTransfer.getAcIdTo());
		
		int result = 0;
		String sql =  "update fin_account_transfer set actr_isdelete=1 where actr_id = :actrId";
			Map<String, Object> paramMap = new HashMap<String, Object>(); 
			paramMap.put("actrId", actrId);
		result = njdt.update(sql, paramMap);
		return result;
	}
	/**
	 * @param finAccountInout
	 * @param acioStatisticsKeyList
	 * @return 2017年12月24日 下午6:01:35 by cgp
	 */
	public List<Map<String, Object>> getAccountInoutStatistics(FinAccountInout finAccountInout,
			String sacioStatisticsKeyList) {
		String sqlSelect = "SELECT sum(facio.acio_money) sum,";
		String sql = " from fin_account_inout facio,fin_account_inout_type faciotype,fin_user fuser,fin_account fac"
				+ ",fin_account_type factype,fin_org forg,fin_user faciouser"
				+ " where facio.acio_isdelete = :isdelete and facio.aciotype_id = faciotype.aciotype_id and fac.actype_id = factype.actype_id "
				+ " and fac.user_id = fuser.user_id and facio.ac_id = fac.ac_id and fac.org_id = forg.org_id and facio.user_id = faciouser.user_id";
		String sqlgroup = "";
		String sqlorder = "";
		Map<String, Object> paramMap = new HashMap<String, Object>(); 
		paramMap.put("isdelete", 0);
		if(finAccountInout!=null){
			if(finAccountInout.getAcId()>-1){
				sql += " and facio.ac_id = :acId";
				paramMap.put("acId", finAccountInout.getAcId());
			}
			if(finAccountInout.getAciotypeInorout()>-1){
				sql += " and faciotype.aciotype_inorout = :aciotypeInorout";
				paramMap.put("aciotypeInorout", finAccountInout.getAciotypeInorout());
			}
			if(finAccountInout.getAcioHappenedTime()!=null){
				sql += " and facio.acio_happened_time like :acioHappenedTime";
				paramMap.put("acioHappenedTime", finAccountInout.getAcioHappenedTime()+"%");
			}
			
			List<String> acioStatisticsKeyList = finAccountInout.getAcioStatisticsKeyList();
//			acId:0,//账号
//	   		acUserId:0,//账户归属人
//	   		actypeId:0//账户类别
//	   		orgId:0,//归属机构
//	   		aciotypeInorout:0,//收入或支出
//	   		aciotypeId:0,//收支细分类
//	   		acioYear:0,//年
//	   		acioMonth:0,//月
//	   		acioUserId:0,//经办人
			if(acioStatisticsKeyList!=null){
				sqlgroup += " group by ";
				for (String key : acioStatisticsKeyList) {
					if(key.equals("acId")){
						sqlgroup += "fac.ac_id,";
						sqlSelect += "fac.ac_name as ac_id,";
					}else if(key.equals("acUserId")){
						sqlgroup += "fac.user_id,";
						sqlSelect += "fuser.user_name as ac_user_id,";
					}else if(key.equals("actypeId")){
						sqlgroup += "fac.actype_id,";
						sqlSelect += "factype.actype_name as actype_id,";
					}else if(key.equals("orgId")){
						sqlgroup += "fac.org_id,";
						sqlSelect += "forg.org_name as org_id,";
					}else if(key.equals("aciotypeInorout")){
						sqlgroup += "faciotype.aciotype_inorout,";
						sqlSelect += "faciotype.aciotype_inorout,";
					}else if(key.equals("aciotypeId")){
						sqlgroup += "faciotype.aciotype_id,";
						sqlSelect += "faciotype.aciotype_name as aciotype_id,";
					}else if(key.equals("acioUserId")){
						sqlgroup += "facio.user_id,";
						sqlSelect += "faciouser.user_name as acio_user_id,";
					}
				}
				if(sqlgroup.endsWith(","))sqlgroup = sqlgroup.substring(0,sqlgroup.length()-1);
				if(sqlSelect.endsWith(","))sqlSelect = sqlSelect.substring(0,sqlSelect.length()-1);
		
			}
			
		}
		
		
		
		
		
//		sqlorder += " order by facio.acio_happened_time desc,facio.acio_id desc";

		return  CamelUtil.getCamelMapList (njdt.queryForList(sqlSelect+sql+sqlgroup, paramMap));
	}

	
	
	
	 
	
	
	
}

