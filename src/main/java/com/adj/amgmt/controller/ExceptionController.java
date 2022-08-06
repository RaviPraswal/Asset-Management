package com.adj.amgmt.controller;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice
public class ExceptionController extends Exception {

	
	// handling Internal Server error
	@ExceptionHandler(Exception.class)
	@ResponseStatus(code = HttpStatus.INTERNAL_SERVER_ERROR)
	public ModelAndView internalServerError() {
		ModelAndView mv = new ModelAndView();
		mv.setStatus(HttpStatus.INTERNAL_SERVER_ERROR);
		mv.setViewName("500");
		return mv;
	}

	// handling Page not found exception
	@ExceptionHandler(NoHandlerFoundException.class)
	@ResponseStatus(code = HttpStatus.NOT_FOUND)
	public ModelAndView pageNotFound() {
		ModelAndView mv = new ModelAndView();
		mv.setStatus(HttpStatus.NOT_FOUND);
		mv.setViewName("404");
		return mv;
	}
}
