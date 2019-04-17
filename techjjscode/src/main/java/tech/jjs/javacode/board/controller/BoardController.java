package tech.jjs.javacode.board.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import tech.jjs.javacode.board.dao.BoardDAO;
import tech.jjs.javacode.board.vo.Board2VO;
import tech.jjs.javacode.board.vo.BoardVO;
import tech.jjs.javacode.board.vo.UserVO;
import tech.jjs.javacode.util.FileService;
import tech.jjs.javacode.util.PageNavigator;

@Controller
public class BoardController {
	

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	@Autowired
	BoardDAO dao;
	
	
	@RequestMapping(value = "test", method = RequestMethod.GET)
	public String test(Locale locale, Model model) {

		return "no-sidebar";
	}
	
	
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String loginForm(Locale locale, Model model) {

		return "loginForm";
	}

	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String login(Locale locale, Model model,UserVO user,HttpSession session) {
		logger.debug("user{}", user);
		UserVO result = dao.loginCheck(user.getId(), user.getPassword());
		logger.debug("result{}", result);
		
		//로그인 실패
		if(result==null){

			
			return "redirect:/login";
		}
			session.setAttribute("id", result.getId());
		
		
	
		return "redirect:/home";

	}

	//로그아웃
	@RequestMapping(value="userLogout", method=RequestMethod.GET)
	public String userLogout(HttpSession session){
		session.removeAttribute("id");
		
		return "redirect:/home";
	}
	
	
	@RequestMapping(value = "home", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {

		return "home";
	}

	
	// 게시판 관련 상수 선언
		static final int countPerPage = 10;// 페이지당 글수
		static final int pagePerGroup = 5; // 페이지 이동 그룹 당 표시할 페이지 수
		static final String uploadPath = "/boardfile";// 파일 업로드 경로
		static final String imageuploadPath = "/profileUpload";// image 파일 업로드 경로
		/**
		 * 게시글 리스트
		 */
		@RequestMapping(value = "list", method = RequestMethod.GET)
		public String list(@RequestParam(value = "page", defaultValue = "1") int page,
				@RequestParam(value = "searchText", defaultValue = "") String searchText,
				@RequestParam(value = "type", defaultValue = "") String type, Model model) {
			logger.debug("현재 페이지{}", page);
			logger.debug("type {}", type);
			logger.debug("검색어 {}", searchText);

			searchText.replace("<", "&lt");
			searchText.replace(">", "&gt");
			// 전체 글 개수
			int total = dao.getTotal(type, searchText);
			// 페이지 계산을 위한 객체 생성
			PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
			// 목록 읽기
			ArrayList<BoardVO> list = dao.list(navi.getStartRecord(), countPerPage, type, searchText);
			
			
			
			
			// JSP에서 출력할 값들을 위한 객체 생성
			model.addAttribute("navi", navi);
			model.addAttribute("list", list);
			model.addAttribute("searchText", searchText);
			model.addAttribute("type", type);


			return "/koreanPage";
		}

		
		
		/**
		 * 게시글 리스트
		 */
		@RequestMapping(value = "list2", method = RequestMethod.GET)
		public String list2(Model model) {
			

			// 목록 읽기
			ArrayList<Board2VO> list2 = dao.list2();
			
			
			// JSP에서 출력할 값들을 위한 객체 생성
			model.addAttribute("list2", list2);
			
			
			


			return "/japanesePage";
		}
		
		
		
		/**
		 * 글작성 폼
		 */
		@RequestMapping(value = "write", method = RequestMethod.GET)
		public String WriteForm(HttpSession hs,Model model) {

			String id = (String)hs.getAttribute("id");	
			//관리자권한만 등록 가능
			if(!id.equals("zxcv1012")){
				
				return "redirect:home";
			}
			
			return "/writeForm";
		}

		/**
		 * 글작성
		 */
		@RequestMapping(value = "write", method = RequestMethod.POST)
		public String write(BoardVO board, MultipartFile upload, HttpSession hs) {

			logger.debug(board.toString());
			
			
			// MultiPartFile 객체의 정보 확인
			//logger.debug("파일명:{}", upload.getOriginalFilename());
			//logger.debug("파일크기:{}", upload.getSize());
			//logger.debug("이름:{}", upload.getName());
			//logger.debug("파일타입:{}", upload.getContentType());
			//logger.debug("파일확인:{}", upload.isEmpty());

			/*
			 * board.setContent(board.getContent().replace("<", "&lt"));
			 * board.setContent(board.getContent().replace(">", "&gt"));
			 */
			board.setTitle(board.getTitle().replace("<", "&lt"));
			board.setTitle(board.getTitle().replace("<", "&gt"));

			// 첨부파일이 있으면 서버의 하드디스크에 파일을 생성해서 복사
			if (!upload.isEmpty()) {

				String savedfile = FileService.saveFile(upload, uploadPath);

				// 원래 파일명과 저장된 파일명을 board객체에 담아 DB에 저장
				board.setOriginalfile(upload.getOriginalFilename());
				board.setSavedfile(savedfile);
			}


			String content = board.getContent();
			content = content.replace("\r\n", "<br>");
			board.setContent(content);
	
		
			
			dao.insert(board);

			return "redirect:list";
		}
		
		/**
		 * 글작성 폼
		 */
		@RequestMapping(value = "write2", method = RequestMethod.GET)
		public String WriteForm() {

	
			
			return "/writeForm2";
		}

		/**
		 * 글작성
		 */
		@RequestMapping(value = "write2", method = RequestMethod.POST)
		public String write2(Board2VO board2, MultipartFile upload, HttpSession hs) {

			logger.debug(board2.toString());
			
			
			
			// 첨부파일이 있으면 서버의 하드디스크에 파일을 생성해서 복사
			if (!upload.isEmpty()) {

				String savedfile = FileService.saveFile(upload, uploadPath);

				// 원래 파일명과 저장된 파일명을 board객체에 담아 DB에 저장
				board2.setOriginalfile(upload.getOriginalFilename());
				board2.setSavedfile(savedfile);
			}


		
			
			dao.insert2(board2);

			return "redirect:list2";
		}
		
		
		
		/**
		 * 글읽기 보기
		 */

		@ResponseBody
		@RequestMapping(value = "read", method = RequestMethod.POST)
		public HashMap<String, Object> read(int boardnum, HttpSession session) {
			
			BoardVO board = dao.read(boardnum);
			
			// 계시판용 리스트
			HashMap<String, Object> result = new HashMap<>();


			result.put("board", board);
			logger.debug("board:{}", board.toString());
			return result;
		}
		
		/**
		 * 글읽기 보기
		 */

		@ResponseBody
		@RequestMapping(value = "read2", method = RequestMethod.POST)
		public HashMap<String, Object> read2(int boardnum, HttpSession session) {
			
			Board2VO board = dao.read2(boardnum);
			
			// 계시판용 리스트
			HashMap<String, Object> result = new HashMap<>();


			result.put("board", board);
			logger.debug("board:{}", board.toString());
			return result;
		}


		/**
		 * 파일 다운로드
		 * 
		 * @param boardnum
		 *            첨부된 파일의
		 * @return null
		 */
		@RequestMapping(value = "download", method = RequestMethod.GET)
		public String filedownload(int boardnum, HttpServletResponse response) {
			// 전달된 글번호로 글정보 검색
			BoardVO board = dao.read(boardnum);
			if (board == null) {
				return "redirect:list";
			}
			// 원래의 파일명을 보여줄 준비 +인코딩
			String originalfile = board.getOriginalfile();
			try {
				response.setHeader("Content-Disposition",
						"attachment;filename=" + URLEncoder.encode(originalfile, "UTF-8"));
			} catch (UnsupportedEncodingException e1) {
				e1.printStackTrace();
			}

			String savedFile = board.getSavedfile();
			String fullpath = uploadPath + "/" + savedFile;
			// 서버에 저장된 파일을 읽어서 클라이언트로 전달할 출력 스트림으로 복사
			FileInputStream in = null;
			ServletOutputStream out = null;
			try {
				in = new FileInputStream(fullpath);
				out = response.getOutputStream();

				FileCopyUtils.copy(in, out);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					in.close();
					out.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			// 클라이언트로전달할 출력스트림으로 복사

			return null;
		}
		/**
		 * 파일 다운로드
		 * 
		 * @param boardnum
		 *            첨부된 파일의
		 * @return null
		 */
		@RequestMapping(value = "download2", method = RequestMethod.GET)
		public String filedownload2(int boardnum, HttpServletResponse response) {
			// 전달된 글번호로 글정보 검색
			Board2VO board = dao.read2(boardnum);
			if (board == null) {
				return "redirect:list";
			}
			// 원래의 파일명을 보여줄 준비 +인코딩
			String originalfile = board.getOriginalfile();
			try {
				response.setHeader("Content-Disposition",
						"attachment;filename=" + URLEncoder.encode(originalfile, "UTF-8"));
			} catch (UnsupportedEncodingException e1) {
				e1.printStackTrace();
			}

			String savedFile = board.getSavedfile();
			String fullpath = uploadPath + "/" + savedFile;
			// 서버에 저장된 파일을 읽어서 클라이언트로 전달할 출력 스트림으로 복사
			FileInputStream in = null;
			ServletOutputStream out = null;
			try {
				in = new FileInputStream(fullpath);
				out = response.getOutputStream();

				FileCopyUtils.copy(in, out);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					in.close();
					out.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			// 클라이언트로전달할 출력스트림으로 복사

			return null;
		}
		/**
		 * 글 삭제
		 */
		@RequestMapping(value = "delete", method = RequestMethod.GET)
		public String delete(int boardnum, HttpSession hs, RedirectAttributes rttr,HttpServletRequest request) {
			
			String id = (String)hs.getAttribute("id");	
			//관리자권한만 등록 가능
			if(!id.equals("zxcv1012")){
				
				return "redirect:home";
			}
			
			
			
			BoardVO board = dao.read(boardnum);

			String savedFile = board.getSavedfile();
			String fullpath = uploadPath + "/" + savedFile;
			
		
			
			String realFolder = request.getSession().getServletContext().getRealPath("profileUpload");
			
			String content = board.getContent();
			logger.debug("content:{}",content);
			
			
			try{ 
  
				Pattern ptn = Pattern.compile("//(.*?)png|//(.*?)jpg", Pattern.DOTALL);   
				
				

				Matcher matcher = ptn.matcher(content); 
			
				while(matcher.find()){ 
				
				
					String imageFileName = matcher.group(0).replaceAll("//", "");        
		    
				    File f2 = new File(realFolder +"\\" + imageFileName );
					// 해당 글에 첨부된 파일이 있으면 삭제
					if (f2.exists()) {
						FileService.deleteFile(realFolder +"\\" + imageFileName );
					}
				    
				    
				} 
				
			
			} catch(Exception e) { 
				e.printStackTrace(); 
			}

			File f = new File(fullpath);
			// 해당 글에 첨부된 파일이 있으면 삭제
			if (f.exists()) {
				FileService.deleteFile(fullpath);
			}

			
		
			
			// 글번호 로그인 아이디를 전달해서 DB에서 글 삭제

			int result = dao.delete(boardnum);
			// 글목록 보기로 리다이렉트
			return "redirect:list";
		}

		/**
		 * 글 수정 폼
		 */
		@RequestMapping(value = "edit", method = RequestMethod.GET)
		public String edit(int boardnum, HttpSession hs, RedirectAttributes rttr, Model model) {

			String id = (String)hs.getAttribute("id");	
			//관리자권한만 등록 가능
			if(!id.equals("zxcv1012")){
				
				return "redirect:home";
			}
			
			BoardVO board = dao.read(boardnum);

	
	
			model.addAttribute("board", board);
			model.addAttribute("edit", "edit");
			
	
			logger.debug("board:{}", board.toString());
			
			return "/writeForm";
		}
		/**
		 * 글 수정 폼
		 */
		@RequestMapping(value = "edit2", method = RequestMethod.GET)
		public String edit2(int boardnum, HttpSession hs, RedirectAttributes rttr, Model model) {

		
			
			Board2VO board = dao.read2(boardnum);

	
	
			model.addAttribute("board", board);
			model.addAttribute("edit", "edit");
			
	
			logger.debug("board:{}", board.toString());
			
			return "/writeForm2";
		}
		/**
		 * 글 수정
		 */
		@RequestMapping(value = "edit", method = RequestMethod.POST)
		public String edit(BoardVO board, HttpSession hs, Model model, MultipartFile upload) {
			logger.debug("초기:{}", board);


			BoardVO board2 = dao.read(board.getBoardnum());
			if (!upload.isEmpty()) {
				String dropfile = board2.getSavedfile();
				String fullpath = uploadPath + "/" + dropfile;
				// 기존 파일 삭제
				FileService.deleteFile(fullpath);
				// 새로운 파일 저장
				String savedfile = FileService.saveFile(upload, uploadPath);

				// 원래 파일명과 저장된 파일명을 board객체에 담아 DB에 저장
				board.setOriginalfile(upload.getOriginalFilename());
				board.setSavedfile(savedfile);
			}
			//board.setContent(board.getContent().replace("<", "&lt"));
			//board.setContent(board.getContent().replace(">", "&gt"));
			board.setTitle(board.getTitle().replace("<", "&lt"));
			board.setTitle(board.getTitle().replace("<", "&gt"));

			//String content = board.getContent();
			//content = content.replace("\r\n", "<br>");
			//board.setContent(content);
			logger.debug("셋팅완료{}", board);
			dao.edit(board);

			return "redirect:list";
		}
		/**
		 * 글 수정
		 */
		@RequestMapping(value = "edit2", method = RequestMethod.POST)
		public String edit2(Board2VO board, HttpSession hs, Model model, MultipartFile upload) {
			logger.debug("초기:{}", board);


			Board2VO board2 = dao.read2(board.getBoardnum());
			if (!upload.isEmpty()) {
				String dropfile = board2.getSavedfile();
				String fullpath = uploadPath + "/" + dropfile;
				// 기존 파일 삭제
				FileService.deleteFile(fullpath);
				// 새로운 파일 저장
				String savedfile = FileService.saveFile(upload, uploadPath);

				// 원래 파일명과 저장된 파일명을 board객체에 담아 DB에 저장
				board.setOriginalfile(upload.getOriginalFilename());
				board.setSavedfile(savedfile);
			}

			board.setTitle(board.getTitle().replace("<", "&lt"));
			board.setTitle(board.getTitle().replace("<", "&gt"));


			logger.debug("셋팅완료{}", board);
			dao.edit2(board);

			return "redirect:list2";
		}

		
		
		@ResponseBody
		@RequestMapping(value = "image", method = RequestMethod.POST)
		public void profileUpload(MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws Exception {
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			// 업로드할 폴더 경로
			String realFolder = request.getSession().getServletContext().getRealPath("profileUpload");
			//UUID uuid = UUID.randomUUID();

			// 업로드할 파일 이름
			String org_filename = file.getOriginalFilename();
			//String str_filename = uuid.toString() + org_filename;
			String savedfile = FileService.saveFile(file, realFolder);
			
			//System.out.println("원본 파일명 : " + org_filename);
			//System.out.println("저장할 파일명 : " + str_filename);

			//String filepath = realFolder + "\\" + str_filename;
			//System.out.println("파일경로 : " + filepath);
	
			//File f = new File(filepath);
			//if (!f.exists()) {
			//	f.mkdirs();
			//}
			//file.transferTo(f);
			//out.println("profileUpload//"+str_filename);
			
			out.println("profileUpload//" + savedfile);
			
			out.close();
	
			
		}
		
		
		@ResponseBody
		@RequestMapping(value = "autocomplete", method = RequestMethod.POST)
		public HashMap<String, Object> autocomplete(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
			HashMap<String, Object> result = new HashMap<>();
			
			String [] categorys =  dao.autocomplete();
			

			result.put("categorys", categorys);
			
			
			
			return result;
			
		}
		@ResponseBody
		@RequestMapping(value = "autocomplete2", method = RequestMethod.POST)
		public void autocomplete2(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
			HashMap<String, Object> result = new HashMap<>();
			String word = request.getParameter("tag");

		
			String [] tags =  dao.autocomplete2(word);

			
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html;charset=utf-8");
			
		    JSONArray list = new JSONArray();
		    JSONObject object = null;
		    
		    
		    for (String s : tags){
		    	object = new JSONObject();
		    	object.put("data", s);
		    	list.add(object);
		    }
     
		    PrintWriter pw = response.getWriter();
		    pw.print(list);
		    pw.flush();
		    pw.close();
	
			
		}
	
		

}
