package cc.cgp.cgpfin.framework;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

/**
 * web配置类
 */
@ComponentScan("cc.cgp")
public class WebMvcConfig extends WebMvcConfigurerAdapter {
	@Override // 默认首页
	public void addViewControllers(ViewControllerRegistry registry) {
		registry.addRedirectViewController("/", "/index");
	}

	@Override
	public void configureViewResolvers(ViewResolverRegistry registry) {
		super.configureViewResolvers(registry);
	}

	@Override // 配置拦截器
	public void addInterceptors(InterceptorRegistry registry) {
		super.addInterceptors(registry);
	}
	
}
