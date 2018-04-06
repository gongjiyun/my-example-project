package mytest.mybatis.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface BlogMapper {
	
	@Select("SELECT * FROM Blog WHERE id=#{id}#")
	public Blog selectBlog(long id);
	
	@Insert("insert into Blog (id, title, description, create_date, create_by) values(#{id}, #{title}, #{description}, #{createDate}, #{createBy})")
	public Long insertBlog(Blog blog);

}
