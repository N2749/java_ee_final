package com.blog.blog.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;

import java.io.IOException;

/**
 * Servlet implementation class LoginFilter
 */
@WebFilter(
        urlPatterns = "/",
        filterName = "LoginFilter",
        description = "Filter all Users to be logged in"
)
public class LoginFilter implements Filter {
    private static final long serialVersionUID = 1L;
    private FilterConfig filterConfig;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginFilter() {
        super();
        // TODO Auto-generated constructor stub
    }

    @Override
    public void init(FilterConfig fConfig) throws ServletException {
        filterConfig = fConfig;
    }

    @Override
    public void destroy() {
        filterConfig = null;
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain)
            throws IOException, ServletException {

        if (!filterConfig.getInitParameter("active").equalsIgnoreCase("true")) {
            filterChain.doFilter(request, response);
            return;
        }

        ServletContext ctx = filterConfig.getServletContext();
        RequestDispatcher toLoginPagedispatcher = ctx.getRequestDispatcher("/login");

        String email = null;
        Cookie[] cookies = ((HttpServletRequest) request).getCookies();

        if (cookies == null) {
            toLoginPagedispatcher.forward(request, response);
            return;
        }
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("user")) {
                email = cookie.getValue();
            }
        }
        if (email == null) {
            toLoginPagedispatcher.forward(request, response);
        }

        filterChain.doFilter(request, response);
    }
}
