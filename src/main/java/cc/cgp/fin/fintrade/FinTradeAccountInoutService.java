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
import org.springframework.transaction.annotation.Transactional;

import cc.cgp.fin.FinAccount;
import cc.cgp.fin.FinService;
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
	@Autowired
	private FinTradeAccountService finTradeAccountService;
	@Autowired
	private FinService finService;

	/**
	 * 通过交易账号id获取交易账号实体
	 * 
	 * @author 2018年3月4日 上午2:11:03
	 * @param tradeacioId
	 * @return
	 */
	private FinTradeAccountInout _getFinTradeAccountInout(int tradeacioId) {
		String sql = "select ftradeacio.tradeacio_id,ftradeacio.tradeacio_type" + ",ftradeacio.tradeacio_count,ftradeacio.tradeacio_price" + ",ftradeacio.tradeacio_create_time,ftradeacio.tradeacio_update_time" + ",tradeacio_fee,tradeacio_tax,ftradeacio.tradeacio_remark,ftradeacio.tradeac_id "
				+ " from fin_trade_account_inout ftradeacio" + " where ftradeacio.tradeacio_id = :tradeacio_id and ftradeacio.tradeacio_isdelete = :tradeacio_isdelete ";

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("tradeacio_isdelete", 0);
		paramMap.put("tradeacio_id", tradeacioId);
		return njdt.queryForObject(sql, paramMap, new BeanPropertyRowMapper<FinTradeAccountInout>(FinTradeAccountInout.class));

	}

	/**
	 * 获取交易账号实体列表
	 * 
	 * @author 2018年3月4日 上午2:14:24
	 * @param tradeacId
	 * @return
	 */
	private List<FinTradeAccountInout> _getFinTradeAccountInoutList(int tradeacId) {
		String sql = "select ftradeacio.tradeacio_id,ftradeacio.tradeacio_type" + ",ftradeacio.tradeacio_count,ftradeacio.tradeacio_price" + ",ftradeacio.tradeacio_create_time,ftradeacio.tradeacio_update_time" + ",tradeacio_fee,tradeacio_tax,ftradeacio.tradeacio_remark,ftradeacio.tradeac_id "
				+ " from fin_trade_account_inout ftradeacio" + " where ftradeacio.tradeacio_isdelete = :tradeacio_isdelete ";

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("tradeacio_isdelete", 0);

		if (tradeacId > 0) {
			sql += " and ftradeacio.tradeac_id = :tradeac_id";
			paramMap.put("tradeac_id", tradeacId);
		}

		sql += " order by ftradeacio.tradeacio_type asc, ftradeacio.tradeacio_update_time desc ";
		return njdt.query(sql, paramMap, new BeanPropertyRowMapper<FinTradeAccountInout>(FinTradeAccountInout.class));

	}

	/**
	 * 添加或修改交易账号实体
	 * 
	 * @author 2018年3月4日 上午2:15:31
	 * @return
	 */
	private int _addOrUpdateFinTradeAccountInout(FinTradeAccountInout finTradeAccountInout) {
		boolean isupdate = false;
		if (finTradeAccountInout.getTradeacioId() != -1) {
			isupdate = true;
		}
		String sql = "";
		if (isupdate) {
			sql = "update fin_trade_account_inout set " + "tradeacio_type = :tradeacio_type," + "tradeacio_count = :tradeacio_count," + "tradeacio_price = :tradeacio_price," + "tradeacio_update_time = :tradeacio_update_time," + "tradeacio_fee = :tradeacio_fee," + "tradeacio_tax = :tradeacio_tax,"
					+ "tradeacio_remark = :tradeacio_remark," + "tradeac_id = :tradeac_id " + " where tradeacio_id = :tradeacio_id";
		} else {
			sql = "insert into fin_trade_account_inout(" + "tradeacio_type,tradeacio_count,tradeacio_price," + "tradeacio_create_time,tradeacio_update_time,tradeacio_fee" + ",tradeacio_tax,tradeacio_remark,tradeac_id) " + " values(:tradeacio_type,:tradeacio_count,:tradeacio_price"
					+ ",:tradeacio_create_time,:tradeacio_update_time,:tradeacio_fee" + ",:tradeacio_tax,:tradeacio_remark,:tradeac_id)";

		}
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("tradeacio_type", finTradeAccountInout.getTradeacioType());
		paramMap.put("tradeacio_count", finTradeAccountInout.getTradeacioCount());
		paramMap.put("tradeacio_price", finTradeAccountInout.getTradeacioPrice());
		paramMap.put("tradeacio_update_time", DateTimeUtil.getDateTimeStr());
		paramMap.put("tradeacio_fee", finTradeAccountInout.getTradeacioFee());
		paramMap.put("tradeacio_tax", finTradeAccountInout.getTradeacioTax());
		paramMap.put("tradeacio_remark", finTradeAccountInout.getTradeacioRemark());
		paramMap.put("tradeac_id", finTradeAccountInout.getTradeacId());
		if (isupdate) {
			paramMap.put("tradeacio_id", finTradeAccountInout.getTradeacioId());
		} else {
			paramMap.put("tradeacio_create_time", DateTimeUtil.getDateTimeStr());
		}
		int result = njdt.update(sql, paramMap);
		return result;
	}

	/**
	 * 逻辑删除交易账号实体
	 * 
	 * @author 2018年3月4日 上午2:45:00
	 * @param tradeacioId
	 * @return
	 */
	private int _deleteFinTradeAccountInout(int tradeacioId) {
		String sql = " update fin_trade_account_inout set " + " tradeacio_isdelete = :tradeacio_isdelete " + " where tradeacio_id = :tradeacio_id";
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("tradeacio_isdelete", 1);
		paramMap.put("tradeacio_id", tradeacioId);
		int result = njdt.update(sql, paramMap);
		return result;
	}

	public FinTradeAccountInout getFinTradeAccountInout(int tradeacioId) {
		return _getFinTradeAccountInout(tradeacioId);
	}

	public List<FinTradeAccountInout> getFinTradeAccountInoutList(int tradeacId) {
		return _getFinTradeAccountInoutList(tradeacId);
	}

	public int deleteFinTradeAccountInout(int tradeacioId) {
		FinTradeAccountInout finTradeAccountInout = _getFinTradeAccountInout(tradeacioId);
		finTradeAccountInout.setTradeacioCount(0);
		finTradeAccountInout.setTradeacioFee(0);
		finTradeAccountInout.setTradeacioPrice(0);
		finTradeAccountInout.setTradeacioTax(0);
		_doBeforeAddOrUpdateFinTradeAccountInout(finTradeAccountInout);
		return _deleteFinTradeAccountInout(tradeacioId);
	}

	public void _doBeforeAddOrUpdateFinTradeAccountInout(FinTradeAccountInout finTradeAccountInout) {
		boolean isupdate = false;
		if (finTradeAccountInout.getTradeacioId() != -1) {
			isupdate = true;
		}

		FinTradeAccountInout finTradeAccountInoutOld = new FinTradeAccountInout();
		if (isupdate) {
			// 还原上一次操作的影响；
			finTradeAccountInoutOld = _getFinTradeAccountInout(finTradeAccountInout.getTradeacioId());
		}
		// 买卖数量
		double tradeacioCount = finTradeAccountInout.getTradeacioCount();
		double tradeacioCountOld = finTradeAccountInoutOld.getTradeacioCount();
		// 买卖价格
		double tradeacioPrice = finTradeAccountInout.getTradeacioPrice();
		double tradeacioPriceOld = finTradeAccountInoutOld.getTradeacioPrice();
		// 手续费
		double tradeacioFee = finTradeAccountInout.getTradeacioFee();
		double tradeacioFeeOld = finTradeAccountInoutOld.getTradeacioFee();
		// 税费
		double tradeacioTax = finTradeAccountInout.getTradeacioTax();
		double tradeacioTaxOld = finTradeAccountInoutOld.getTradeacioTax();

		// 获取理财产品账户信息
		int tradeacId = finTradeAccountInout.getTradeacId();
		FinTradeAccount finTradeAccount = finTradeAccountService.getFinTradeAccount(tradeacId);
		// 持有数量
		double tradeacCount = finTradeAccount.getTradeacCount();
		// 持有成本
		double tradeacMoneyCost = finTradeAccount.getTradeacMoneyCost();

		// 获取资金账号
		FinTradeAccount finTradeAccountMoney = finTradeAccountService.getFinTradeAccountByAcId(finTradeAccount.getAcId());
		double tradeacCountMoney = finTradeAccountMoney.getTradeacCount();

		if (finTradeAccountInout.getTradeacioType() == 1) {
			// 买入理财产品持有数量增加，成本增加；
			finTradeAccount.setTradeacCount(tradeacCount + tradeacioCount - tradeacioCountOld);
			finTradeAccount.setTradeacMoneyCost(tradeacMoneyCost + tradeacioCount * tradeacioPrice + tradeacioFee + tradeacioTax - (tradeacioCountOld * tradeacioPriceOld + tradeacioFeeOld + tradeacioTaxOld));
			// 资金账户数量减少，成本字段用于表达资金实际转账情况；即和主账户进行转账时同步变化，在买卖时不发生变化，最终表达的是原始投入资金，和所有市值的差额可以表达浮盈；

			finTradeAccountMoney.setTradeacCount(tradeacCountMoney - tradeacioCount * tradeacioPrice - tradeacioFee - tradeacioTax + (tradeacioCountOld * tradeacioPriceOld + tradeacioFeeOld + tradeacioTaxOld));

		} else if (finTradeAccountInout.getTradeacioType() == -1) {
			// 卖出持有数量减少，持有成本减少；
			finTradeAccount.setTradeacCount(finTradeAccount.getTradeacCount() - finTradeAccountInout.getTradeacioCount());
			finTradeAccount.setTradeacMoneyCost(tradeacMoneyCost - tradeacioCount * tradeacioPrice + tradeacioFee + tradeacioTax + (tradeacioCountOld * tradeacioPriceOld - tradeacioFeeOld - tradeacioTaxOld));
			// 资金账号增加卖出所得，减去手续费和税费
			finTradeAccountMoney.setTradeacCount(tradeacCountMoney + tradeacioCount * tradeacioPrice - tradeacioFee - tradeacioTax - (tradeacioCountOld * tradeacioPriceOld - tradeacioFeeOld - tradeacioTaxOld));
		}
		// 更新时间
		finTradeAccount.setTradeacUpdateTime(DateTimeUtil.getDateTimeStr());
		finTradeAccountMoney.setTradeacUpdateTime(DateTimeUtil.getDateTimeStr());
		finTradeAccountService.addOrUpdateFinTradeAccount(finTradeAccount);
		finTradeAccountService.addOrUpdateFinTradeAccount(finTradeAccountMoney);
	}

	/**
	 * 保存理财产品操作明细
	 * 
	 * @param finTradeAccountInout
	 * @return 2018年4月7日 下午7:13:49 by cgp
	 */
	@Transactional
	public int addOrUpdateFinTradeAccountInout(FinTradeAccountInout finTradeAccountInout) {
		int tradeacId = finTradeAccountInout.getTradeacId();
		FinTradeAccount finTradeAccount = finTradeAccountService.getFinTradeAccount(tradeacId);
		if (finTradeAccount.getTradeacType() == 0) {
			// 资金账户操作
			_doBeforeAddOrUpdateFinTradeAccountMoneyInout(finTradeAccountInout);
		} else if (finTradeAccount.getTradeacType() == 1) {
			// 股票账户操作
			// 1.保存理财产品买卖明细，2.修改对应理财产品的持有数量，总成本等 3.修改对应理财产品资金账号额度
			_doBeforeAddOrUpdateFinTradeAccountInout(finTradeAccountInout);
		}

		int rowcount = _addOrUpdateFinTradeAccountInout(finTradeAccountInout);
		return rowcount;
	}

	/**
	 * @author 2018年4月23日 下午11:34:44
	 * @param finTradeAccountInout
	 */
	private void _doBeforeAddOrUpdateFinTradeAccountMoneyInout(FinTradeAccountInout finTradeAccountInout) {
		int tradeacId = finTradeAccountInout.getTradeacId();
		FinTradeAccount finTradeAccount = finTradeAccountService.getFinTradeAccount(tradeacId);
		int acId = finTradeAccount.getAcId();
		FinAccount finAccount = finService.getAccount(acId);
		// 1.主账户与对应证券账户之间转账：修改主账户和对应证券账户余额；增加转账记录；如果是修改，则修改余额，增加转账记录两条，因为找不到对应转账记录；
		// 2.修改对应证券资金账户余额，增加转账记录一条，如果是修改，删除一条记录，增加一条记录；
		
	}

}
