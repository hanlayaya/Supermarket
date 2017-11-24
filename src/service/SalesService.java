package service;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import jdbc.JDBCuntl;

public class SalesService {
	Connection conn;
	public void addSales(int id,float price,int number) throws FileNotFoundException, ClassNotFoundException, IOException, SQLException{
		conn = JDBCuntl.getConnection(this.getClass().getClassLoader().getResource("/").getPath());
		String sql = "insert into sales (s_time,s_goods,s_number,s_money) values (?,?,?,?)";
		PreparedStatement pstmt;
		pstmt = (PreparedStatement)conn.prepareStatement(sql);
		java.util.Date date=new java.util.Date();
		Timestamp tt=new Timestamp(date.getTime());
		pstmt.setTimestamp(1, tt);
		pstmt.setInt(2, id);
		pstmt.setInt(3, number);
		pstmt.setFloat(4, price*number);
		pstmt.executeUpdate();
		pstmt = (PreparedStatement)conn.prepareStatement("select g_stock from goods where g_id=" + id);
		ResultSet rs = pstmt.executeQuery();
		rs.absolute(1);
		int newstock = rs.getInt(1) - number;
		sql = "update goods set g_stock='" + newstock + "' where g_id=" + id;
		pstmt.executeUpdate(sql);
		pstmt.close();
		conn.close();
	}
}
