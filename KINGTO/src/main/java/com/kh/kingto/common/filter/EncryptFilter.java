package com.kh.kingto.common.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;

import com.kh.kingto.common.wrapper.EncryptPasswordWrapper;


@WebFilter(filterName="encryptFilter", servletNames = {"login", "enroll_kr","updatePwd","updatePwd_Eng"})
public class EncryptFilter implements Filter {


    public EncryptFilter() {
    }


	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		EncryptPasswordWrapper wrapper = new EncryptPasswordWrapper((HttpServletRequest)request);

		chain.doFilter(wrapper, response);
	}


	public void init(FilterConfig fConfig) throws ServletException {
		
	}

}
