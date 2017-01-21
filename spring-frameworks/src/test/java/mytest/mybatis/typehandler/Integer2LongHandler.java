package mytest.mybatis.typehandler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedJdbcTypes;
import org.apache.ibatis.type.TypeHandler;

@MappedJdbcTypes(JdbcType.VARCHAR)
public class Integer2LongHandler implements TypeHandler<Long> {

	@Override
	public Long getResult(ResultSet arg0, String arg1) throws SQLException {
		return Long.valueOf(arg0.getString(arg1));
	}

	@Override
	public Long getResult(ResultSet arg0, int arg1) throws SQLException {
		return Long.valueOf(arg0.getString(arg1));
	}

	@Override
	public Long getResult(CallableStatement arg0, int arg1) throws SQLException {
		return Long.valueOf(arg0.getString(arg1));
	}

	@Override
	public void setParameter(PreparedStatement arg0, int arg1, Long arg2, JdbcType arg3) throws SQLException {
		arg0.setInt(arg1, Integer.valueOf(arg1));
	}

}
