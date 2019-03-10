package tech.jjs.javacode.board.dao;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;





@Repository
public class BoardDAO {

	@Autowired
	SqlSession sqlSession;

	private static final Logger log = LoggerFactory.getLogger(BoardDAO.class);
}
