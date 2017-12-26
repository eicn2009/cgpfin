/**
 * cc.cgp.fin.FinController.java
 * 2017年12月2日 下午8:00:25 by cgp
 */
package cc.cgp.fin;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.security.auth.login.AccountException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cc.cgp.util.JsonUtil;

/**
 * cc.cgp.fin.FinController.java
 * 2017年12月2日 下午8:00:25 by cgp
 */
@Controller
@RequestMapping("/fin")
public class FinController {
	
	@Autowired
	FinService finService;
	
	/**
	 * 进入账户列表页
	 * @return
	 * @throws IOException 2017年12月26日 下午5:56:24 by cgp
	 */
	@RequestMapping("")
	public String index() throws IOException {
		return "/fin/fin.jsp";

	}
	
	/**
	 * 进入收支明细信息页
	 * @return
	 * @throws IOException 2017年12月26日 下午5:55:42 by cgp
	 */
	@RequestMapping("/accountinout")
	public String accountInout() throws IOException {
		return "/fin/fin_account_inout.jsp";

	}
	/**
	 * 进入转账明细页
	 * @return
	 * @throws IOException 2017年12月26日 下午5:56:01 by cgp
	 */
	@RequestMapping("/accounttransfer")
	public String accountTransfer() throws IOException {
		return "/fin/fin_account_transfer.jsp";

	}
	
	/**
	 * 账户信息列表
	 * @param finAccount
	 * @return 2017年12月6日 下午5:28:45 by cgp
	 */
	@RequestMapping(value="/accountlist",method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> finAcountList(@RequestBody(required=false) FinAccount finAccount) {
		List<FinAccount> accountList = finService.getAccountList(finAccount);
		float balanceSum = finService.getAccountBalanceSum(finAccount);
		Map<String, Object> map = new HashMap<>();
		map.put("accountList", accountList);
		map.put("acBalanceSum", balanceSum);
		return map;
	}
	
	/**
	 * 账户类型列表
	 * @return 2017年12月6日 下午5:29:06 by cgp
	 */
	@RequestMapping(value="/accounttypelist",method = RequestMethod.GET)
	public @ResponseBody List<Map<String, Object>> finAcountTypeList() {
		List<Map<String, Object>> accountTypeList = finService.getAccountTypeList();
		return accountTypeList;
	}
	/**
	 * 用户列表
	 * @return 2017年12月6日 下午5:29:06 by cgp
	 */
	@RequestMapping(value="/userlist",method = RequestMethod.GET)
	public @ResponseBody List<Map<String, Object>> finUserList() {
		List<Map<String, Object>> userList = finService.getUserList();
		return userList;
	}
	/**
	 * 金融机构列表
	 * @return 2017年12月6日 下午5:29:06 by cgp
	 */
	@RequestMapping(value="/orglist",method = RequestMethod.GET)
	public @ResponseBody List<Map<String, Object>> finOrgList() {
		List<Map<String, Object>> orgList = finService.getOrgList();
		return orgList;
	}
	/**
	 * 查询收支明细类型列表
	 * @return 2017年12月9日 下午7:31:32 by cgp
	 */
	@RequestMapping(value="/accountinouttypelist/{inorout}",method = RequestMethod.GET)
	public @ResponseBody List<Map<String, Object>> getFinAccountInOutTypeList(@PathVariable("inorout") int inorout) {
		List<Map<String, Object>> accountInoutTypeList = finService.getAccountInoutTypeList(inorout);
		return accountInoutTypeList;
	}
	/**
	 * 保存或者更新收支明细
	 * @param finAccountInOut
	 * @return 2017年12月16日 下午3:42:42 by cgp
	 */
	@RequestMapping(value="/accountinout",method = RequestMethod.POST)
	public @ResponseBody int saveFinAccountInOut(@RequestBody(required=false) FinAccountInout finAccountInOut) {
		return finService.addOrUpdateFinAccountInout(finAccountInOut);
	}
	/**
	 * 删除收支明细
	 * @param acioId
	 * @return 2017年12月16日 下午3:44:35 by cgp
	 */
	@RequestMapping(value="/accountinout/{acioId}",method = RequestMethod.DELETE)
	public @ResponseBody int deleteFinAccountInOut(@PathVariable("acioId") int acioId) {
		return finService.deleteFinAccountInout(acioId);
	}
	/**
	 * 根据指定信息查询收支明细
	 * @param finAccountInout
	 * @return 2017年12月16日 下午3:44:49 by cgp
	 */
	@RequestMapping(value="/accountinoutlist",method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> getFinAccountInoutList(@RequestBody(required=false) FinAccountInout finAccountInout) {
		List<Map<String, Object>> finAccountInoutList = finService.getAccountInoutList(finAccountInout);
		return finAccountInoutList;
	}
	/**
	 * 收支明细统计
	 * @param finAccountInout
	 * @return 2017年12月24日 下午5:57:02 by cgp
	 */
	@RequestMapping(value="/accountinoutstatistics",method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> getFinAccountInoutStatistics(@RequestBody(required=false) FinAccountInout finAccountInout ) {
		List<Map<String, Object>> aicoStatisticsList = finService.getAccountInoutStatistics(finAccountInout);
		return aicoStatisticsList;
	}
	
	
	/**
	 * 获取转账信息列表
	 * @param finAccountTransfer
	 * @return 2017年12月26日 下午5:54:30 by cgp
	 */
	@RequestMapping(value="/accounttransferlist",method = RequestMethod.GET)
	public @ResponseBody List<FinAccountTransfer> getFinAccountTransferList(@RequestBody(required=false) FinAccountTransfer finAccountTransfer) {
		List<FinAccountTransfer> finAccountTransferList = finService.getAccountTransferList(finAccountTransfer);
		return finAccountTransferList;
	}
	
	/**
	 * 保存和更新转账信息
	 * @param finAccountTransfer
	 * @return 2017年12月26日 下午5:54:54 by cgp
	 */
	@RequestMapping(value="/accounttransfer",method = RequestMethod.POST)
	public @ResponseBody int saveFinAccountTransfer(@RequestBody(required=false) FinAccountTransfer finAccountTransfer) {
		return finService.addOrUpdateFinAccountTransfer(finAccountTransfer);
	}
	/**
	 * 删除转账信息
	 * @param actrId
	 * @return 2017年12月26日 下午5:55:14 by cgp
	 */
	@RequestMapping(value="/accounttransfer/{actrId}",method = RequestMethod.DELETE)
	public @ResponseBody int deleteFinAccountTransfer(@PathVariable("actrId") int actrId) {
		return finService.deleteFinAccountTransfer(actrId);
	}
	/**
	 * 测试用，返回字符串
	 * @return 2017年12月6日 下午5:29:06 by cgp
	 */
	@RequestMapping(value="/teststr",method = RequestMethod.POST)
	public @ResponseBody String teststr(@RequestParam int id) {
		
		return "ok"+id;
	}

	/**
	 * 测试用，用字符串返回map，也可以直接返回map
	 * @return 2017年12月6日 下午5:29:06 by cgp
	 */
	@RequestMapping(value="/testjson",method = RequestMethod.POST)
	public @ResponseBody String testjson(@RequestParam int id) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id+"");
		return JsonUtil.toJson(map);
	}
}

