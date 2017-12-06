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
	
	@RequestMapping("")
	public String index() throws IOException {
		return "/fin/fin.jsp";

	}
	/**
	 * 账户信息列表
	 * @param finAccount
	 * @return 2017年12月6日 下午5:28:45 by cgp
	 */
	@RequestMapping(value="/accountlist",method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> finAcountList(@RequestBody(required=false) FinAccount finAccount) {
		List<Map<String, Object>> list = finService.getAccountList(finAccount);
		float balancesum = finService.getAccountBalanceSum(finAccount);
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("balancesum", balancesum);
		return map;
	}
	
	/**
	 * 账户类型列表
	 * @return 2017年12月6日 下午5:29:06 by cgp
	 */
	@RequestMapping(value="/accounttypelist",method = RequestMethod.GET)
	public @ResponseBody List<Map<String, Object>> finAcountTypeList() {
		List<Map<String, Object>> map = finService.getAccountTypeList();
		return map;
	}
	/**
	 * 用户列表
	 * @return 2017年12月6日 下午5:29:06 by cgp
	 */
	@RequestMapping(value="/userlist",method = RequestMethod.GET)
	public @ResponseBody List<Map<String, Object>> finUserList() {
		List<Map<String, Object>> map = finService.getUserList();
		return map ;
	}
	/**
	 * 金融机构列表
	 * @return 2017年12月6日 下午5:29:06 by cgp
	 */
	@RequestMapping(value="/orglist",method = RequestMethod.GET)
	public @ResponseBody List<Map<String, Object>> finOrgList() {
		List<Map<String, Object>> map = finService.getOrgList();
		return map ;
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

