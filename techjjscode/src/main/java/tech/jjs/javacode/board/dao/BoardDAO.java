package tech.jjs.javacode.board.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import tech.jjs.javacode.board.mapper.IBoardMapper;
import tech.jjs.javacode.board.vo.Board2VO;
import tech.jjs.javacode.board.vo.BoardVO;
import tech.jjs.javacode.board.vo.UserVO;






@Repository
public class BoardDAO {

	@Autowired
	SqlSession sqlSession;

	private static final Logger log = LoggerFactory.getLogger(BoardDAO.class);
	
	
	

		/**
		 * 글저장
		 * 
		 * @paramcustomer 사용자가 입력한 개인정보
		 * @return 저장성공은 1 , 실패는 0
		 */
		public int insert(BoardVO board) {

			IBoardMapper mapper = sqlSession.getMapper(IBoardMapper.class);
			int result = mapper.insert(board);
			return result;
		}
		
		/**
		 * 글저장
		 * 
		 * @paramcustomer 사용자가 입력한 개인정보
		 * @return 저장성공은 1 , 실패는 0
		 */
		public int insert2(Board2VO board2) {

			IBoardMapper mapper = sqlSession.getMapper(IBoardMapper.class);
			int result = mapper.insert2(board2);
			return result;
		}
		
		
		
		public BoardVO read(int boardnum) {

			IBoardMapper mapper = sqlSession.getMapper(IBoardMapper.class);
			BoardVO result = mapper.read(boardnum);
			return result;
		}
		
		public Board2VO read2(int boardnum) {

			IBoardMapper mapper = sqlSession.getMapper(IBoardMapper.class);
			Board2VO result = mapper.read2(boardnum);
			return result;
		}
		
		//게시글 리스트
		public ArrayList<BoardVO> list(int startRecord ,int countPerPage ,String type,String searchText) {

			IBoardMapper mapper = sqlSession.getMapper(IBoardMapper.class);
			//검색결과의 일부분만 읽기
			RowBounds rb = new RowBounds(startRecord, countPerPage);
			
			HashMap<String, Object> b = new HashMap<>();
			b.put("type", type);
			b.put("searchText",searchText );
			ArrayList<BoardVO> list = mapper.list(b,rb);
			
			return list;
		}
		
		//게시글 리스트
		public ArrayList<Board2VO> list2(int startRecord ,int countPerPage ,String type,String searchText) {

			IBoardMapper mapper = sqlSession.getMapper(IBoardMapper.class);
			//검색결과의 일부분만 읽기
			RowBounds rb = new RowBounds(startRecord, countPerPage);
			
			HashMap<String, Object> b = new HashMap<>();
			b.put("type", type);
			b.put("searchText",searchText );
			ArrayList<Board2VO> list = mapper.list2(b,rb);
			
			return list;
		}
		
		
		//전체 글 수 가져오기
		public int getTotal(String type,String searchText){
			
			IBoardMapper mapper = sqlSession.getMapper(IBoardMapper.class);
			HashMap<String, Object> b = new HashMap<>();
			b.put("type", type);
			b.put("searchText",searchText );
			int total = mapper.getTotal(b);
			
			return total;
			
			
		}
		//전체 글 수 가져오기
		public int getTotal2(String type,String searchText){
			
			IBoardMapper mapper = sqlSession.getMapper(IBoardMapper.class);
			HashMap<String, Object> b = new HashMap<>();
			b.put("type", type);
			b.put("searchText",searchText );
			int total = mapper.getTotal2(b);
			
			return total;
			
			
		}
		
		//글삭제
		public int delete(int s_boardNum) {

			IBoardMapper mapper = sqlSession.getMapper(IBoardMapper.class);
			int result = mapper.delete(s_boardNum);
			return result;
		}
		//글수정
		public int edit(BoardVO board) {

			IBoardMapper mapper = sqlSession.getMapper(IBoardMapper.class);
			int result = mapper.edit(board);
			return result;
		}
		//글수정
		public int edit2(Board2VO board) {

			IBoardMapper mapper = sqlSession.getMapper(IBoardMapper.class);
			int result = mapper.edit2(board);
			return result;
		}
		public String [] autocomplete(){
			IBoardMapper mapper = sqlSession.getMapper(IBoardMapper.class);
			
			String [] result = mapper.autocomplete();
			
			
			return result;

		}
		
		public String [] autocomplete2(String tag){
			IBoardMapper mapper = sqlSession.getMapper(IBoardMapper.class);
			
			String [] result = mapper.autocomplete2(tag);
			
			
			return result;

		}
		
		public UserVO loginCheck(String id, String password){
			IBoardMapper mapper = sqlSession.getMapper(IBoardMapper.class);
			
			UserVO result = mapper.loginCheck(id,password);
			
			
			return result;

		}		
}
