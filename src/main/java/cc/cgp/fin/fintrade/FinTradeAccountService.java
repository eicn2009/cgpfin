/**
 * 
 */
package cc.cgp.fin.fintrade;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;

import cc.cgp.fin.FinService;
import cc.cgp.util.DateTimeUtil;

/**
 * @author eicn 2018年3月4日 上午1:54:06
 *
 */
@Service
public class FinTradeAccountService {
	@Autowired
	private NamedParameterJdbcTemplate njdt;
	@Autowired
	private JdbcTemplate jdt;
	
	@Autowired
	private FinService finService;
	
	/**
	 * 通过交易账号id获取交易账号实体
	 * @author 2018年3月4日 上午2:11:03
	 * @param tradeacId
	 * @return
	 */
	private FinTradeAccount _getFinTradeAccount(int tradeacId){
		String sql = "select ftradeac.tradeac_id,ftradeac.tradeac_name,ftradeac.tradeac_code"
				+ ",ftradeac.tradeac_count,ftradeac.tradeac_price_now,ftradeac.tradeac_money_cost"
				+ ",ftradeac.tradeac_create_time,ftradeac.tradeac_update_time,ftradeac.ac_id "
				+ " from fin_trade_account ftradeac"
				+ " where ftradeac.tradeac_id = :tradeac_id and ftradeac.tradeac_isdelete = :tradeac_isdelete ";
		
		Map<String, Object> paramMap = new HashMap<String, Object>(); 
		paramMap.put("tradeac_isdelete", 0);
		paramMap.put("tradeac_id", tradeacId);
		return njdt.queryForObject(sql, paramMap, new BeanPropertyRowMapper<FinTradeAccount>(FinTradeAccount.class));

	}
	/**
	 * 获取交易账号实体列表
	 * @author 2018年3月4日 上午2:14:24
	 * @return
	 */
	private List<FinTradeAccount> _getFinTradeAccountList(){
		String sql = "select ftradeac.tradeac_id,ftradeac.tradeac_name,ftradeac.tradeac_code"
				+ ",ftradeac.tradeac_count,ftradeac.tradeac_price_now,ftradeac.tradeac_money_cost"
				+ ",ftradeac.tradeac_create_time,ftradeac.tradeac_update_time,ftradeac.ac_id "
				+ " from fin_trade_account ftradeac "
				+ " where ftradeac.tradeac_isdelete = :tradeac_isdelete order by ftradeac.tradeac_update_time desc";
		
		Map<String, Object> paramMap = new HashMap<String, Object>(); 
		paramMap.put("tradeac_isdelete", 0);
		return  njdt.query(sql, paramMap, new BeanPropertyRowMapper<FinTradeAccount>(FinTradeAccount.class));

	}
	/**
	 * 添加或修改交易账号实体
	 * @author 2018年3月4日 上午2:15:31
	 * @return
	 */
	private int _addOrUpdateFinTradeAccount(FinTradeAccount finTradeAccount){
		boolean isupdate = false;
		if (finTradeAccount.getTradeacId() != -1){
			isupdate = true;
		}
		String sql = "";
		if (isupdate) {
			sql = "update fin_trade_account set "
				+ "tradeac_name = :tradeac_name,"
				+ "tradeac_code = :tradeac_code,"
				+ "tradeac_count = :tradeac_count,"
				+ "tradeac_price_now = :tradeac_price_now,"
				+ "tradeac_money_cost = :tradeac_money_cost,"
				+ "tradeac_update_time = :tradeac_update_time,"
				+ "ac_id = :ac_id "
				+ " where tradeac_id = :tradeac_id";
		}else {
			sql = "insert into fin_trade_account("
					+ "tradeac_name,tradeac_code,tradeac_count,"
					+ "tradeac_price_now,tradeac_money_cost,tradeac_create_time"
					+ ",tradeac_update_time,ac_id) "
					+ " values(:tradeac_name,:tradeac_code,:tradeac_count"
					+ ",:tradeac_price_now,:tradeac_money_cost,:tradeac_create_time"
					+ ",:tradeac_update_time,:ac_id)";
		
		}
		Map<String, Object> paramMap = new HashMap<String, Object>(); 
		paramMap.put("tradeac_name", finTradeAccount.getTradeacName());
		paramMap.put("tradeac_code", finTradeAccount.getTradeacCode());
		paramMap.put("tradeac_count", finTradeAccount.getTradeacCount());
		paramMap.put("tradeac_price_now", finTradeAccount.getTradeacPriceNow());
		paramMap.put("tradeac_money_cost", finTradeAccount.getTradeacMoneyCost());
		paramMap.put("tradeac_update_time", DateTimeUtil.getDateTimeStr());
		paramMap.put("ac_id", finTradeAccount.getAcId());
		if (isupdate) {
			paramMap.put("tradeac_id", finTradeAccount.getTradeacId());
		}else {
			paramMap.put("tradeac_create_time", DateTimeUtil.getDateTimeStr());
		}
		int result = njdt.update(sql, paramMap);
		return result;
	}
	/**
	 * 逻辑删除交易账号实体
	 * @author 2018年3月4日 上午2:45:00
	 * @param tradeacId
	 * @return
	 */
	private int _deleteFinTradeAccount(int tradeacId){
		String sql  = " update fin_trade_account set "
				+ " tradeac_isdelete = :tradeac_isdelete "
				+ " where tradeac_id = :tradeac_id";
		Map<String, Object> paramMap = new HashMap<String, Object>(); 
		paramMap.put("tradeac_isdelete", 1);
		paramMap.put("tradeac_id", tradeacId);
		int result = njdt.update(sql, paramMap);
		return result;
	}
	
	public FinTradeAccount getFinTradeAccount(int tradeacId){
		FinTradeAccount finTradeAccount = _getFinTradeAccount(tradeacId);
		finTradeAccount.setFinAccount(finService.getAccount(finTradeAccount.getAcId()));
		return finTradeAccount;
	}
	
	public List<FinTradeAccount> getFinTradeAccountList(){
		List<FinTradeAccount> finTradeAccountList = _getFinTradeAccountList();
		for (FinTradeAccount finTradeAccount : finTradeAccountList) {
			finTradeAccount.setFinAccount(finService.getAccount(finTradeAccount.getAcId()));
		} 
		return finTradeAccountList;
	}
	
	public int deleteFinTradeAccount(int tradeacId){
		return _deleteFinTradeAccount(tradeacId);
	}
	public int addOrUpdateFinTradeAccount(FinTradeAccount finTradeAccount){
		return _addOrUpdateFinTradeAccount(finTradeAccount);
	}
}
