package service;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import jdbc.JDBCuntl;
import model.Goods;
import model.Supply;

public class SupplyService {
	Connection conn;
	
	//获取供应商信息
	public List getSupply() throws FileNotFoundException, ClassNotFoundException, IOException, SQLException{
		conn = JDBCuntl.getConnection(this.getClass().getClassLoader().getResource("/").getPath());
		String sql = "select * from supply";
		PreparedStatement pstmt;
		pstmt = (PreparedStatement)conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
        List<Supply> list = new ArrayList<Supply>();
		while(rs.next()){
			Supply supply = new Supply();
			supply.setId(rs.getInt("s_id"));
			supply.setName(rs.getString("s_name"));
			supply.setTel(rs.getString("s_tel"));
			supply.setPerson(rs.getString("s_person"));
			list.add(supply);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return list;
	}
	//进货
	public void addPurchase(int g,int s,int addstock) throws FileNotFoundException, ClassNotFoundException, IOException, SQLException{
		conn = JDBCuntl.getConnection(this.getClass().getClassLoader().getResource("/").getPath());
		String sql = "select g_stock from goods where g_id=" + g; 
		PreparedStatement pstmt;
		pstmt = (PreparedStatement)conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		rs.absolute(1);
		int newstock = rs.getInt(1) + addstock;
		//System.out.println(rs.getInt(1));
		sql = "update goods set g_stock='" + newstock + "' where g_id=" + g;
		pstmt.executeUpdate(sql);
		sql = "insert into purchase (p_time,p_goods,p_number,p_supply) values (?,?,?,?)";
		pstmt = (PreparedStatement)conn.prepareStatement(sql);
		java.util.Date date=new java.util.Date();
		Timestamp tt=new Timestamp(date.getTime());
		pstmt.setTimestamp(1, tt);
		pstmt.setInt(2, g);
		pstmt.setInt(3, addstock);
		pstmt.setInt(4, s);
		pstmt.executeUpdate();
		
		rs.close();
		pstmt.close();
		conn.close();
		
	}
	//删除供应商
	public void deleteSupply(int id) throws FileNotFoundException, ClassNotFoundException, IOException, SQLException{
		conn = JDBCuntl.getConnection(this.getClass().getClassLoader().getResource("/").getPath());
		String sql = "delete from supply where s_id=" + id +";";
		PreparedStatement pstmt;
		pstmt = (PreparedStatement)conn.prepareStatement(sql);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	//添加供应商
	public void addSupply(Supply supply) throws FileNotFoundException, ClassNotFoundException, IOException, SQLException{
		conn = JDBCuntl.getConnection(this.getClass().getClassLoader().getResource("/").getPath());
		String sql = "insert into supply values (null,'" + supply.getName() + "','" + 
					 supply.getTel() + "','" + supply.getPerson() + "');";
		PreparedStatement pstmt;
		pstmt = (PreparedStatement)conn.prepareStatement(sql);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	//编辑供应商
	public void editSupply(Supply supply) throws FileNotFoundException, ClassNotFoundException, IOException, SQLException{
		conn = JDBCuntl.getConnection(this.getClass().getClassLoader().getResource("/").getPath());
		String sql = "update supply set s_name='" + supply.getName() + "',s_tel='" + supply.getTel() + "',s_person='" + 
					 supply.getPerson() + "' where s_id=" + supply.getId() + ";";
	    PreparedStatement pstmt;
		pstmt = (PreparedStatement)conn.prepareStatement(sql);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
}
