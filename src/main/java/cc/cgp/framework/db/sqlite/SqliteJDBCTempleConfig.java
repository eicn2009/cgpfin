package cc.cgp.framework.db.sqlite;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;

@Configuration
public class SqliteJDBCTempleConfig {
	
	@Autowired
	@Qualifier("sqliteds")
	private DataSource ds;
	
//	生成jdbcTemple
	@Bean(name="sqliteJDBCTemple")
	@Qualifier("sqliteJDBCTemple")
	public JdbcTemplate getSqliteJDBCTemple(){
		return new JdbcTemplate(ds);
	}
	
	@Bean(name="sqliteNamedParameterJDBCTemple")
	@Qualifier("sqliteNamedParameterJDBCTemple")
	public NamedParameterJdbcTemplate getSqliteNamedParameterJdbcTemplate(){
		return new NamedParameterJdbcTemplate(ds);
	}
}
