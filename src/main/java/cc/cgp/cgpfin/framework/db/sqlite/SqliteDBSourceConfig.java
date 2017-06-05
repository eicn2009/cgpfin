package cc.cgp.cgpfin.framework.db.sqlite;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.autoconfigure.jdbc.DataSourceBuilder;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.jdbc.core.JdbcTemplate;

@Configuration
public class SqliteDBSourceConfig {
	
//	通过配置文件生成数据库的数据源
	@Bean(name="sqliteds")
	@ConfigurationProperties(prefix="spring.ds_sqlite")
	public DataSource sqliteds (){
		return DataSourceBuilder.create().build();
	}
	
}
