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

	
	
}




