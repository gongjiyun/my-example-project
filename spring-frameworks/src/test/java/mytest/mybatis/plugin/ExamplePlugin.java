package mytest.mybatis.plugin;

import java.sql.Connection;
import java.util.Properties;

import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;

//@Intercepts({@Signature(type=Executor.class, method="update", args = {MappedStatement.class,Object.class})})
@Intercepts({@Signature(type=StatementHandler.class, method="prepare", args = {Connection.class,Integer.class})})
public class ExamplePlugin implements Interceptor {

	@Override
	public Object intercept(Invocation arg0) throws Throwable {
		System.out.println(arg0.getTarget().toString());
		return arg0.proceed();
	}

	@Override
	public Object plugin(Object target) {
		return Plugin.wrap(target, this);
	}

	@Override
	public void setProperties(Properties arg0) {
		
	}

}
