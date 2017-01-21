package mytest.mybatis;

import java.util.Date;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import mytest.mybatis.mapper.Blog;
import mytest.mybatis.mapper.BlogMapper;

public class MybatisExample {
	
	private final static String resource = "mybatis-config.xml";

	public static void main(String[] args) throws Exception{
		MybatisExample example = new MybatisExample();
		example.testSelect1();
		example.testSelect2();
	}
	
	private SqlSessionFactory getSessionFactory() throws Exception{
		SqlSessionFactoryBuilder builder = new SqlSessionFactoryBuilder();
		SqlSessionFactory sessionFactory = builder.build(Resources.getResourceAsReader(resource));

		return sessionFactory;
	}
	
	void testSelect1() throws Exception{
		SqlSession session = this.getSessionFactory().openSession();
		Blog blog = session.selectOne("mytest.mybatis.mapper.selectBlog", 1l);		
		System.out.println(blog.toString());

		session.close();
	}
	
	void testSelect2() throws Exception{
		SqlSession session = this.getSessionFactory().openSession();
		
		BlogMapper blogMapper = session.getMapper(BlogMapper.class);
		Blog blog = blogMapper.selectBlog(1);
		System.out.println(blog.toString());
		session.close();
	}

	void testInsert1() throws Exception{
		SqlSession session = this.getSessionFactory().openSession();

		Blog blog = new Blog();
		blog.setId(3);
		blog.setTitle("blog");
		blog.setDescription("my blog");
		blog.setCreateBy(0);
		blog.setCreateDate(new Date());
		
		session.insert("insertBlog", blog);
		
		session.commit();
		session.close();
	}
}
