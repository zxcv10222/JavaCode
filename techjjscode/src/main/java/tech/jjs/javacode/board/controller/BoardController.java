package tech.jjs.javacode.board.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import tech.jjs.javacode.board.dao.BoardDAO;
import tech.jjs.javacode.board.vo.BoardVO;
import tech.jjs.javacode.util.FileService;
import tech.jjs.javacode.util.PageNavigator;

@Controller
public class BoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	@Autowired
	BoardDAO dao;
	
	
	
	@RequestMapping(value = "home", method = RequestMethod.GET)
	public String indexhome(Locale locale, Model model) {

		return "home";
	}

	@RequestMapping(value = "left-sidebar", method = RequestMethod.GET)
	public String leftSidebar(Locale locale, Model model) {

		return "left-sidebar";
	}

	@RequestMapping(value = "no-sidebar", method = RequestMethod.GET)
	public String noSidebar(Locale locale, Model model) {

		return "no-sidebar";
	}

	@RequestMapping(value = "right-sidebar", method = RequestMethod.GET)
	public String rightSidebare(Locale locale, Model model) {

		return "right-sidebar";
	}

	


	
	// 게시판 관련 상수 선언
		static final int countPerPage = 10;// 페이지당 글수
		static final int pagePerGroup = 5; // 페이지 이동 그룹 당 표시할 페이지 수
		static final String uploadPath = "/boardfile";// 파일 업로드 경로

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
			return "/list";
		}

		/**
		 * 글작성 폼
		 */
		@RequestMapping(value = "write", method = RequestMethod.GET)
		public String WriteForm(HttpSession hs) {

			return "/right-sidebar";
		}

		/**
		 * 글작성
		 */
		@RequestMapping(value = "write", method = RequestMethod.POST)
		public String write(BoardVO board, MultipartFile upload, HttpSession hs) {
			
	
	
			
			
			logger.debug(board.toString());
			
			
			// MultiPartFile 객체의 정보 확인
			logger.debug("파일명:{}", upload.getOriginalFilename());
			logger.debug("파일크기:{}", upload.getSize());
			logger.debug("이름:{}", upload.getName());
			logger.debug("파일타입:{}", upload.getContentType());
			logger.debug("파일확인:{}", upload.isEmpty());

			/*
			 * board.setContent(board.getContent().replace("<", "&lt"));
			 * board.setContent(board.getContent().replace(">", "&gt"));
			 */
			board.setS_title(board.getS_title().replace("<", "&lt"));
			board.setS_title(board.getS_title().replace("<", "&gt"));

			// 첨부파일이 있으면 서버의 하드디스크에 파일을 생성해서 복사
			if (!upload.isEmpty()) {

				String savedfile = FileService.saveFile(upload, uploadPath);

				// 원래 파일명과 저장된 파일명을 board객체에 담아 DB에 저장
				board.setS_originalfile(upload.getOriginalFilename());
				board.setS_savedfile(savedfile);
			}

			//String s_custid = (String) hs.getAttribute("loginId");

			String s_content = board.getS_content();
			s_content = s_content.replace("\r\n", "<br>");
			board.setS_content(s_content);
			board.setS_custid("test");
		
			
			dao.insert(board);

			return "redirect:right-sidebar";
		}
		
		/**
		 * 글읽기 보기
		 */
		@RequestMapping(value = "read", method = RequestMethod.GET)
		public String read(int s_boardnum, Model model) {

			BoardVO board = dao.read(s_boardnum);
			

			if (board == null) {
				return "redirect:list";
			}

			model.addAttribute("board", board);

			return "/read";
		}

		/**
		 * 파일 다운로드
		 * 
		 * @param boardnum
		 *            첨부된 파일의
		 * @return null
		 */
		@RequestMapping(value = "download", method = RequestMethod.GET)
		public String filedownload(int s_boardnum, HttpServletResponse response) {
			// 전달된 글번호로 글정보 검색
			BoardVO board = dao.read(s_boardnum);
			if (board == null) {
				return "redirect:list";
			}
			// 원래의 파일명을 보여줄 준비 +인코딩
			String originalfile = board.getS_originalfile();
			try {
				response.setHeader("Content-Disposition",
						"attachment;filename=" + URLEncoder.encode(originalfile, "UTF-8"));
			} catch (UnsupportedEncodingException e1) {
				e1.printStackTrace();
			}

			String savedFile = board.getS_savedfile();
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
		public String delete(int s_boardnum, HttpSession session, RedirectAttributes rttr) {
			// 세션에서 사용자 아이디 읽기
			String loginId = (String) session.getAttribute("loginId");
			BoardVO board = dao.read(s_boardnum);

			if (!loginId.equals(board.getS_custid())) {
				rttr.addFlashAttribute("errorMsg", "부적절한 접근 - 계정 틀림");
				return "redirect:list";
			}

			String savedFile = board.getS_savedfile();
			String fullpath = uploadPath + "/" + savedFile;
			File f = new File(fullpath);
			// 해당 글에 첨부된 파일이 있으면 삭제
			if (f.exists()) {
				FileService.deleteFile(fullpath);
			}

			// 글번호 로그인 아이디를 전달해서 DB에서 글 삭제

			int result = dao.delete(s_boardnum);
			// 글목록 보기로 리다이렉트
			return "redirect:list";
		}

		/**
		 * 글 수정 폼
		 */
		@RequestMapping(value = "edit", method = RequestMethod.GET)
		public String edit(int s_boardnum, HttpSession session, RedirectAttributes rttr, Model model) {
			// 세션에서 사용자 아이디 읽기
			String loginId = (String) session.getAttribute("loginId");
			BoardVO board = dao.read(s_boardnum);

			if (!loginId.equals(board.getS_custid())) {
				rttr.addFlashAttribute("errorMsg", "부적절한 접근 - 계정 틀림");
				return "redirect:list";
			}
			model.addAttribute("board", board);

			return "/editForm";
		}

		/**
		 * 글 수정
		 */
		@RequestMapping(value = "edit", method = RequestMethod.POST)
		public String edit(BoardVO board, HttpSession hs, Model model, MultipartFile upload) {
			logger.debug("초기:{}", board);
			String id = (String) hs.getAttribute("loginId");

			BoardVO board2 = dao.read(board.getS_boardnum());
			if (!upload.isEmpty()) {
				String dropfile = board2.getS_savedfile();
				String fullpath = uploadPath + "/" + dropfile;
				// 기존 파일 삭제
				FileService.deleteFile(fullpath);
				// 새로운 파일 저장
				String savedfile = FileService.saveFile(upload, uploadPath);

				// 원래 파일명과 저장된 파일명을 board객체에 담아 DB에 저장
				board.setS_originalfile(upload.getOriginalFilename());
				board.setS_savedfile(savedfile);
			}
			board.setS_content(board.getS_content().replace("<", "&lt"));
			board.setS_content(board.getS_content().replace(">", "&gt"));
			board.setS_title(board.getS_title().replace("<", "&lt"));
			board.setS_title(board.getS_title().replace("<", "&gt"));

			String content = board.getS_content();
			content = content.replace("\r\n", "<br>");
			board.setS_content(content);
			logger.debug("셋팅완료{}", board);
			dao.edit(board);

			return "redirect:list";
		}


}
