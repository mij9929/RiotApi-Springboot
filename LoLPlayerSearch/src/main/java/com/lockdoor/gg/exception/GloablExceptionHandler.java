package com.lockdoor.gg.exception;

import java.nio.file.AccessDeniedException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice
public class GloablExceptionHandler {
	// 404 Page Not found
	@ExceptionHandler(value = NoHandlerFoundException.class)
	public final ModelAndView noHandlerFound(NoHandlerFoundException ex) {

		ModelAndView view = new ModelAndView("error/404");
		List<String> details = new ArrayList<>();
		details.add(ex.getLocalizedMessage());

		ErrorResponse errorResponse = new ErrorResponse();
		errorResponse.setMessage(ex.getMessage());
		errorResponse.setDetails(details);
		
		view.addObject("exception", errorResponse);

		return view;
	}

	// 404 Summoner Not found
	@ExceptionHandler(value = EntityNotFoundException.class)
	public final ModelAndView handleEntityNotFound(EntityNotFoundException ex) {
		ModelAndView view = new ModelAndView("error/404-nosummoner");
		List<String> details = new ArrayList<>();
		details.add(ex.getLocalizedMessage());
		
		System.out.println("test");

		ErrorResponse errorResponse = new ErrorResponse();
		errorResponse.setMessage(ex.getMessage());
		errorResponse.setDetails(details);

		view.addObject("exception", errorResponse);

		return view;
	}

	// 404 Page Not found(MissingParamter)
	@ExceptionHandler(value = MissingServletRequestParameterException.class)
	public final ModelAndView MissingParameter(MissingServletRequestParameterException ex) {
		ModelAndView view = new ModelAndView("error/404");
		List<String> details = new ArrayList<>();
		details.add(ex.getLocalizedMessage());

		ErrorResponse errorResponse = new ErrorResponse();
		errorResponse.setMessage(ex.getMessage());
		errorResponse.setDetails(details);

		view.addObject("exception", errorResponse);

		return view;
	}

	// All Error Exception
	@ExceptionHandler(value = Throwable.class)
	public final ModelAndView handleException(Throwable ex) {

		ModelAndView view = new ModelAndView("error/500");
		List<String> details = new ArrayList<>();
		details.add(ex.getLocalizedMessage());

		ErrorResponse errorResponse = new ErrorResponse();
		errorResponse.setMessage(ex.getMessage());
		errorResponse.setDetails(details);

		view.addObject("exception", errorResponse);

		return view;
	}

}
