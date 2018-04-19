/**
 * 
 */
package cc.cgp.fin.fintrade;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @author eicn 2018年3月4日 上午10:17:37
 *
 */
@Controller
@RequestMapping("/fin/fintradeaccountinout")
public class FinTradeAccountInoutController {
	@Autowired
	 FinTradeAccountInoutService finTradeAccountInoutService;
	
	
	
	@RequestMapping(value="/fintradeaccountinout/{tradeacioId}",method = RequestMethod.GET)
	public @ResponseBody FinTradeAccountInout  getFinTradeAccountInout(@PathVariable("tradeacioId") int tradeacioId){
		FinTradeAccountInout finTradeAccountInout = finTradeAccountInoutService.getFinTradeAccountInout(tradeacioId);
		return finTradeAccountInout;
		
	}
	
	
	@RequestMapping(value="/fintradeaccountinoutlist/{tradeacId}",method = RequestMethod.GET)
	public @ResponseBody List<FinTradeAccountInout> finTradeAccountInoutList(@PathVariable("tradeacId") int tradeacId) {
		List<FinTradeAccountInout> finTradeAccountInoutList = finTradeAccountInoutService.getFinTradeAccountInoutList(tradeacId);
		return finTradeAccountInoutList;
	}
	
	@RequestMapping(value="/fintradeaccountinout",method = RequestMethod.POST)
	public @ResponseBody int addOrUpdateFinTradeAccountInout(@RequestBody(required=false) FinTradeAccountInout finTradeAccountInout){
		return finTradeAccountInoutService.addOrUpdateFinTradeAccountInout(finTradeAccountInout);
	}
	
	@RequestMapping(value="/fintradeaccountinout/{tradeacioId}",method = RequestMethod.DELETE)
	public @ResponseBody int deleteFinTradeAccountInout(@PathVariable("tradeacioId") int tradeacioId){
		return finTradeAccountInoutService.deleteFinTradeAccountInout(tradeacioId);
	}

}
