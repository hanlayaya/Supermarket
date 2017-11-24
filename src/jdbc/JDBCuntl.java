package jdbc;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.Statement;

public class JDBCuntl {
	 private static String driverClass = null;
	 private static String url = null;
     private static String user = null;
     private static String password = null;
     
     /*static{
    	 Properties props = new Properties();
    	 try {
			props.load(new FileInputStream(new File("WebRoot/WEB-INF/classes/jdbc.properties")));
			driverClass = props.getProperty("driverClass");
	        url = props.getProperty("url");
	   	    user = props.getProperty("user");
		    password = props.getProperty("password");
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
     }*/
     
     public static Connection getConnection(String path) throws FileNotFoundException, IOException, ClassNotFoundException, SQLException{
         Connection conn = null;
         Properties props = new Properties();
         props.load(new FileInputStream(new File(path+"jdbc.properties")));
	     driverClass = props.getProperty("driverClass");
	     url = props.getProperty("url");
	     user = props.getProperty("user");
		 password = props.getProperty("password");
         Class.forName(driverClass);
         conn = (Connection) DriverManager.getConnection(url, user, password); 
         return conn;
     }
     public static void close(ResultSet rs,PreparedStatement pstmt,Connection conn) throws SQLException{
         if(rs != null){
             rs.close();
             rs = null;
         }  
         if(pstmt != null){
             pstmt.close();
             pstmt = null;
         }
          
         if(conn != null){
             conn.close();
             conn = null;
         }
     }
      
}
