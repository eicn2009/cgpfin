/**
 * 
 */
package cc.cgp.fin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;

import cc.cgp.util.DateTimeUtil;

/**
 * @author eicn 2018年3月4日 上午1:54:40
 *
 */
@Service
public class FinTradeAccountInoutService {
	@Autowired
	private NamedParameterJdbcTemplate njdt;
	@Autowired
	private JdbcTemplate jdt;
	
	
	/**
	 * 通过交易账号id获取交易账号实体
	 * @author 2018年3月4日 上午2:11:03
	 * @param tradeacioId
	 * @return
	 */
	private FinTradeAccountInout _getFinTradeAccountInout(int tradeacioId){
		String sql = "select ftradeacio.tradeacio_id,ftradeacio.tradeacio_type"
				+ ",ftradeacio.tradeacio_count,ftradeacio.tradeacio_price"
				+ ",ftradeacio.tradeacio_create_time,ftradeacio.tradeacio_update_time"
				+ ",tradeacio_fee,tradeacio_tax,ftradeacio.tradeacio_remark,ftradeacio.tradeac_id "
				+ " from fin_trade_account_inout ftradeacio"
				+ " where ftradeacio.tradeacio_id = :tradeacio_id and ftradeacio.tradeacio_isdelete = :tradeacio_isdelete ";
		
		Map<String, Object> paramMap = new HashMap<String, Object>(); 
		paramMap.put("tradeacio_isdelete", 0);
		paramMap.put("tradeacio_id", tradeacioId);
		return njdt.queryForObject(sql, paramMap, new BeanPropertyRowMapper<FinTradeAccountInout>(FinTradeAccountInout.class));

	}
	/**
	 * 获取交易账号实体列表
	 * @author 2018年3月4日 上午2:14:24
	 * @return
	 */
	private List<FinTradeAccountInout> _getFinTradeAccountInoutList(){
		String sql =  "select ftradeacio.tradeacio_id,ftradeacio.tradeacio_type"
				+ ",ftradeacio.tradeacio_count,ftradeacio.tradeacio_price"
				+ ",ftradeacio.tradeacio_create_time,ftradeacio.tradeacio_update_time"
				+ ",tradeacio_fee,tradeacio_tax,ftradeacio.tradeacio_remark,ftradeacio.tradeac_id "
				+ " from fin_trade_account_inout ftradeacio"
				+ " where ftradeacio.tradeacio_isdelete = :tradeacio_isdelete ";
		
		Map<String, Object> paramMap = new HashMap<String, Object>(); 
		paramMap.put("tradeacio_isdelete", 0);
		return  njdt.query(sql, paramMap, new BeanPropertyRowMapper<FinTradeAccountInout>(FinTradeAccountInout.class));

	}
	/**
	 * 添加或修改交易账号实体
	 * @author 2018年3月4日 上午2:15:31
	 * @return
	 */
	private int _addOrUpdateFinTradeAccountInout(FinTradeAccountInout FinTradeAccountInout){
		boolean isupdate = false;
		if (FinTradeAccountInout.getTradeacioId() != -1){
			isupdate = true;
		}
		String sql = "";
		if (isupdate) {
			sql = "update fin_trade_account set "
				+ "tradeacio_type = :tradeacio_type,"
				+ "tradeacio_count = :tradeacio_count,"
				+ "tradeacio_price = :tradeacio_price,"
				+ "tradeacio_update_time = :tradeacio_update_time,"
				+ "tradeacio_fee = :tradeacio_fee,"
				+ "tradeacio_tax = :tradeacio_tax,"
				+ "tradeacio_remark = :tradeacio_remark,"
				+ "tradeac_id = :tradeac_id,"
				+ " where tradeacio_id = :tradeacio_id";
		}else {
			sql = "insert into fin_trade_account("
					+ "tradeacio_type,tradeacio_count,tradeacio_price,"
					+ "tradeacio_create_time,tradeacio_update_time,tradeacio_fee"
					+ ",tradeacio_tax,tradeacio_remark,tradeac_id) "
					+ " values(:tradeacio_type,:tradeacio_count,:tradeacio_price"
					+ ",:tradeacio_create_time,:tradeacio_update_time,:tradeacio_fee"
					+ ",:tradeacio_tax,:tradeacio_remark,tradeac_id)";
		
		}
		Map<String, Object> paramMap = new HashMap<String, Object>(); 
		paramMap.put("tradeacio_type", FinTradeAccountInout.getTradeacioType());
		paramMap.put("tradeacio_count", FinTradeAccountInout.getTradeacioCount());
		paramMap.put("tradeacio_price", FinTradeAccountInout.getTradeacioPrice());
		paramMap.put("tradeacio_update_time", DateTimeUtil.getDateTimeStr());
		paramMap.put("tradeacio_fee", FinTradeAccountInout.getTradeacioFee());
		paramMap.put("tradeacio_tax", FinTradeAccountInout.getTradeacioTax());
		paramMap.put("tradeacio_remark", FinTradeAccountInout.getTradeacioRemark());
		paramMap.put("tradeac_id", FinTradeAccountInout.getTradeacId());
		if (isupdate) {
			paramMap.put("tradeacio_id", FinTradeAccountInout.getTradeacioId());
		}else {
			paramMap.put("tradeacio_create_time", DateTimeUtil.getDateTimeStr());
		}
		int result = njdt.update(sql, paramMap);
		return result;
	}
	/**
	 * 逻辑删除交易账号实体
	 * @author 2018年3月4日 上午2:45:00
	 * @param tradeacioId
	 * @return
	 */
	private int _deleteFinTradeAccountInout(int tradeacioId){
		String sql  = " update fin_trade_account set "
				+ " tradeacio_isdelete = :tradeacio_isdelete "
				+ " where tradeacio_id = :tradeacio_id";
		Map<String, Object> paramMap = new HashMap<String, Object>(); 
		paramMap.put("tradeacio_isdelete", 1);
		paramMap.put("tradeacio_id", tradeacioId);
		int result = njdt.update(sql, paramMap);
		return result;
	}
	
	public FinTradeAccountInout getFinTradeAccountInout(int tradeacioId){
		return _getFinTradeAccountInout(tradeacioId);
	}
	
	public List<FinTradeAccountInout> getFinTradeAccountInoutList(){
		return _getFinTradeAccountInoutList();
	}
	
	public int deleteFinTradeAccountInout(int tradeacioId){
		return _deleteFinTradeAccountInout(tradeacioId);
	}
	public int addOrUpdateFinTradeAccountInout(FinTradeAccountInout finTradeAccountInout){
		return _addOrUpdateFinTradeAccountInout(finTradeAccountInout);
	}
	
	
	
	
}
