package tech.jjs.javacode.board.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;

import tech.jjs.javacode.board.vo.Board2VO;
import tech.jjs.javacode.board.vo.BoardVO;
import tech.jjs.javacode.board.vo.UserVO;


public interface IBoardMapper {
	// 등록
	public int insert(BoardVO board);
	// 등록
	public int insert2(Board2VO board2);
	//게시글 읽기
	public BoardVO read(int s_boardnum);
	//게시글 읽기
	public Board2VO read2(int s_boardnum);
	//전체 게시글 가져오기
	public ArrayList<BoardVO> list(HashMap<String, Object> b,RowBounds rb);
	//japan전체 게시글 가져오기
	public ArrayList<Board2VO> list2(HashMap<String, Object> b,RowBounds rb);
	//전체 글 수
	public int getTotal (HashMap<String, Object> b);
	//전체 글 수
	public int getTotal2 (HashMap<String, Object> b);
	// 삭제
	public int delete(int s_boardNum);
	// 삭제
	public int delete2(int s_boardNum);
	// 수정
	public int edit(BoardVO board);
	// 수정
	public int edit2(Board2VO board);
	//autocomplete
	public String[] autocomplete();
	//autocomplete2
	public String[] autocomplete2(String word);
	//loginCheck
	public UserVO loginCheck(String id, String password);
	
}
