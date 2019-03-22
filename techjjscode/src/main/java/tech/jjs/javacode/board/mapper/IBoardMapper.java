package tech.jjs.javacode.board.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;

import tech.jjs.javacode.board.vo.BoardVO;


public interface IBoardMapper {
	// 등록
	public int insert(BoardVO board);
	
	//게시글 읽기
	public BoardVO read(int s_boardnum);
	
	//전체 게시글 가져오기
	public ArrayList<BoardVO> list(HashMap<String, Object> b,RowBounds rb);
	//전체 글 수
	public int getTotal (HashMap<String, Object> b);
	// 삭제
	public int delete(int s_boardNum);
	// 수정
	public int edit(BoardVO board);
	//autocomplete
	public String[] autocomplete();
	//autocomplete2
	public String[] autocomplete2(String word);
	
	
}
