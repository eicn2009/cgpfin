package cc.cgp.web.demo.gotojsp;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class Controller1 {

	@RequestMapping("/gotos1")
	public String gotos1(){
		return "/index.jsp";
	}
	
}
