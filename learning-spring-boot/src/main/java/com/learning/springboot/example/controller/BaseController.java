package com.learning.springboot.example.controller;

import org.springframework.core.annotation.AnnotationUtils;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@ControllerAdvice
public class BaseController {

    private static final String SESSION_KEY_USER_ID = "session.user.id";

    @ExceptionHandler(Exception.class)
	public ModelAndView exceptionHandler(final HttpServletRequest request, final HttpServletResponse response,
			final Exception ex) {

		ResponseStatus responseStatusAnnotation = AnnotationUtils.findAnnotation(ex.getClass(), ResponseStatus.class);

		return buildModelAndViewErrorPage(request, response, ex,
				responseStatusAnnotation != null ? responseStatusAnnotation.value() : HttpStatus.INTERNAL_SERVER_ERROR);
	}

	private ModelAndView buildModelAndViewErrorPage(final HttpServletRequest request,
            final HttpServletResponse response, final Exception ex, final HttpStatus httpStatus) {
        response.setStatus(httpStatus.value());

        ModelAndView mav = new ModelAndView("error.html");
        if (ex != null) {
            mav.addObject("title", ex);
        }

        mav.addObject("content", request.getRequestURL());
        return mav;
    }

    public String getCurrentUserId(final HttpServletRequest request){
	    return (String) request.getAttribute(SESSION_KEY_USER_ID);
    }
}
