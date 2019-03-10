package tech.jjs.javacode;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import tech.jjs.javacode.board.vo.BoardVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}

	
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String indexhome(Locale locale, Model model) {

		return "index";
	}

	@RequestMapping(value = "/left-sidebar", method = RequestMethod.GET)
	public String leftSidebar(Locale locale, Model model) {

		return "left-sidebar";
	}

	@RequestMapping(value = "/no-sidebar", method = RequestMethod.GET)
	public String noSidebar(Locale locale, Model model) {

		return "no-sidebar";
	}

	@RequestMapping(value = "/right-sidebar", method = RequestMethod.GET)
	public String rightSidebare(Locale locale, Model model) {

		return "right-sidebar";
	}

	
	
	/**
	 * GET방식의 요청 parameter
	 */

	@RequestMapping(value = "param1", method = RequestMethod.GET)
	public String param1(String str ,int num) {
		logger.debug("param1()실행됨");
		logger.debug(String.valueOf(num));
		logger.debug("전달된 문자열 {} 전달된 숫자 : {}", str,num);
		logger.debug("전달된 숫자 : {}", num);//{}가 매개인자가됨
		
		return "redirect:/";
	}
	
	/**
	 * jsp 파일 보여주기
	 */

	@RequestMapping(value = "param2", method = RequestMethod.GET)
	public String param2() {
		
		return "param2";
	}
	/**
	 * 폼에서 전송한 parameter 받기
	 */

	@RequestMapping(value = "param2", method = RequestMethod.POST)
	public String param2(String name , String phone ,String address) {
		//확인 출력
		
		logger.debug("이름:{},전화:{},주소:{}", name,phone,address);
		return "redirect:/";
	}
	
	@RequestMapping(value = "param3", method = RequestMethod.POST)
	public String param3(BoardVO person ,String etc) {
		//확인 출력
		
		logger.debug("person : {} , etc : {}",person,etc);
		return "redirect:/";
	}

	
	
	
}




