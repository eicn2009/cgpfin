/**
 * 
 */
package cc.cgp.fin;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @author eicn 2018年3月4日 上午10:17:28
 *
 */
@Controller
@RequestMapping("/fin/fintradeaccount")
public class FinTradeAccountController {
	@Autowired
	 FinTradeAccountService finTradeAccountService;
	
	/**
	 * 进入账户列表页
	 * @author 2018年3月4日 上午10:26:25
	 * @return
	 * @throws IOException
	 */
	@RequestMapping("")
	public String index() throws IOException {
		return "/fin/fin_trade_account.jsp";
	}
	
	@RequestMapping(value="/fintradeaccount/{tradeacId}",method = RequestMethod.GET)
	public @ResponseBody FinTradeAccount  getFinTradeAccount(@PathVariable("tradeacId") int tradeacId){
		FinTradeAccount finTradeAccount = finTradeAccountService.getFinTradeAccount(tradeacId);
		return finTradeAccount;
		
	}
	
	
	@RequestMapping(value="/fintradeaccountlist",method = RequestMethod.GET)
	public @ResponseBody List<FinTradeAccount> finTradeAccountList() {
		List<FinTradeAccount> finTradeAccountList = finTradeAccountService.getFinTradeAccountList();
		return finTradeAccountList;
	}
	
	@RequestMapping(value="/fintradeaccount",method = RequestMethod.POST)
	public @ResponseBody int addOrUpdateFinTradeAccount(@RequestBody(required=false) FinTradeAccount finTradeAccount){
		return finTradeAccountService.addOrUpdateFinTradeAccount(finTradeAccount);
	}
	
	@RequestMapping(value="/fintradeaccount/{tradeacId}",method = RequestMethod.DELETE)
	public @ResponseBody int deleteFinTradeAccount(@PathVariable("tradeacId") int tradeacId){
		return finTradeAccountService.deleteFinTradeAccount(tradeacId);
	}

	
	
	
	
}
