package com.learning.springboot.example;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

@Configuration
@EnableWebMvc
public class WebMvcConfig extends WebMvcConfigurerAdapter {
	private static final String[] CLASSPATH_RESOURCE_LOCATIONS = {
	        "classpath:/META-INF/resources/", "classpath:/resources/",
	        "classpath:/static/", "classpath:/static", "classpath:/public/", "/static/dist",};
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/assets/**").addResourceLocations("/assets/");
        registry.addResourceHandler("/webjars/**").addResourceLocations("classpath:/META-INF/resources/webjars/");
        registry.addResourceHandler("/css/**").addResourceLocations("classpath:/static/css/");
        registry.addResourceHandler("/js/**").addResourceLocations("classpath:/static/js/");
        registry.addResourceHandler("/images/**").addResourceLocations("classpath:/static/images/");
        registry.addResourceHandler("/html/**").addResourceLocations("classpath:/static/html/");
		registry.addResourceHandler("/**").addResourceLocations(CLASSPATH_RESOURCE_LOCATIONS);
	}
	
	@Bean
	public ViewResolver viewResolver(){
		InternalResourceViewResolver view = new InternalResourceViewResolver();
		view.setPrefix("/html/");
		view.setSuffix(".html");
		view.setOrder(1);
		view.setContentType("text/html;charset=UTF-8");
		return view;
	}
	
	/*@Bean
	public HttpMessageConverter<String> responseBodyConverter() {
	    StringHttpMessageConverter converter = new StringHttpMessageConverter(Charset.forName("UTF-8"));
	    return converter;
	}*/
	
	/*@Bean
	public ResourceHttpMessageConverter responseResourceHttpMessageConverter() {
		ResourceHttpMessageConverter converter = new ResourceHttpMessageConverter();
	    return converter;
	}*/
	

	/*@Override
	public void configureMessageConverters(List<HttpMessageConverter<?>> converters) {
	    super.configureMessageConverters(converters);
	    converters.add(responseBodyConverter());
	}*/
	
	@Override
	public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
		configurer.enable();
	}
	
    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/").setViewName("forward:index.html");
    }
}
