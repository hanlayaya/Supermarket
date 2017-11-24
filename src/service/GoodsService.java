package service;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jdbc.JDBCuntl;
import model.Goods;



public class GoodsService {
	Connection conn;
	
	//添加有保质期的商品
	public void addGoodsWithDate(Goods goods) throws FileNotFoundException, ClassNotFoundException, IOException, SQLException{
		conn = JDBCuntl.getConnection(this.getClass().getClassLoader().getResource("/").getPath());
		String sql = "insert into goods (g_name,g_type,g_price,g_measurement,g_stock,g_date) values (?,?,?,?,?,?)";
		PreparedStatement pstmt;
		pstmt = (PreparedStatement)conn.prepareStatement(sql);
		pstmt.setString(1, goods.getName());
		pstmt.setString(2, goods.getType());
		pstmt.setFloat(3, goods.getPrice());
		pstmt.setString(4, goods.getMeasurement());
		pstmt.setInt(5, goods.getStock());
		pstmt.setDate(6, goods.getDate());
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	
	//添加没有保质期的商品
	public void addGoodsWithOutDate(Goods goods) throws FileNotFoundException, ClassNotFoundException, IOException, SQLException{
		conn = JDBCuntl.getConnection(this.getClass().getClassLoader().getResource("/").getPath());
		String sql = "insert into goods (g_name,g_type,g_price,g_measurement,g_stock) values (?,?,?,?,?)";
	    PreparedStatement pstmt;
		pstmt = (PreparedStatement)conn.prepareStatement(sql);
		pstmt.setString(1, goods.getName());
		pstmt.setString(2, goods.getType());
		pstmt.setFloat(3, goods.getPrice());
		pstmt.setString(4, goods.getMeasurement());
		pstmt.setInt(5, goods.getStock());
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	
	//获取全部商品
	public List getGoods(int i) throws FileNotFoundException, ClassNotFoundException, IOException, SQLException{
		conn = JDBCuntl.getConnection(this.getClass().getClassLoader().getResource("/").getPath());
		int BEGIN = i*8-8;
		int LENGTH= 8;
		String sql = "select * from goods LIMIT " + BEGIN + "," + LENGTH;
		PreparedStatement pstmt;
		pstmt = (PreparedStatement)conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
        List<Goods> list = new ArrayList<Goods>();
		while(rs.next()){
			Goods goods = new Goods();
			goods.setId(rs.getInt("g_id"));
			goods.setName(rs.getString("g_name"));
			goods.setType(rs.getString("g_type"));
			goods.setPrice(rs.getFloat("g_price"));
			goods.setMeasurement(rs.getString("g_measurement"));
			goods.setStock(rs.getInt("g_stock"));
			goods.setDate(rs.getDate("g_date"));
			goods.setDetail(rs.getString("g_detail"));
			list.add(goods);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return list;
	}
	
	//查询商品
	public List queryGoods(String query,int i) throws FileNotFoundException, ClassNotFoundException, IOException, SQLException{
		conn = JDBCuntl.getConnection(this.getClass().getClassLoader().getResource("/").getPath());
		int BEGIN = i*8-8;
		int LENGTH= 8;
		List<Goods> list = new ArrayList<Goods>();
		String sql = "select * from goods where g_name LIKE '%" +  query + "%' or g_type LIKE '%" + query + "%' or g_price LIKE '%" + query + 
				     "%' or g_measurement LIKE '%" + query + "%' or g_stock LIKE '%" + query + "%' LIMIT " + BEGIN + "," + LENGTH;               
		PreparedStatement pstmt;
		pstmt = (PreparedStatement)conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()){
			Goods goods = new Goods();
			goods.setId(rs.getInt("g_id"));
			goods.setName(rs.getString("g_name"));
			goods.setType(rs.getString("g_type"));
			goods.setPrice(rs.getFloat("g_price"));
			goods.setMeasurement(rs.getString("g_measurement"));
			goods.setStock(rs.getInt("g_stock"));
			goods.setDate(rs.getDate("g_date"));
			list.add(goods);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return 	list;
	}
	
	//删除商品
	public void deleteGoods(int id) throws FileNotFoundException, ClassNotFoundException, IOException, SQLException{
		conn = JDBCuntl.getConnection(this.getClass().getClassLoader().getResource("/").getPath());
		String sql = "delete from goods where g_id=" + id;
		PreparedStatement pstmt;
		pstmt = (PreparedStatement)conn.prepareStatement(sql);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	//编辑商品
	public void editGoodsWithDate(Goods goods) throws FileNotFoundException, ClassNotFoundException, IOException, SQLException{
		conn = JDBCuntl.getConnection(this.getClass().getClassLoader().getResource("/").getPath());
		String sql = "update goods set g_name='" + goods.getName() + "',g_type='" + goods.getType() + "',g_price='" + goods.getPrice() +
				     "',g_measurement='" + goods.getMeasurement() +"',g_stock='" + goods.getStock() + "',g_date='" + goods.getDate() + 
				     "' where g_id=" + goods.getId() + ";";
		PreparedStatement pstmt;
		pstmt = (PreparedStatement)conn.prepareStatement(sql);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	public void editGoodsWithOutDate(Goods goods) throws FileNotFoundException, ClassNotFoundException, IOException, SQLException{
		conn = JDBCuntl.getConnection(this.getClass().getClassLoader().getResource("/").getPath());
		String sql = "update goods set g_name='" + goods.getName() + "',g_type='" + goods.getType() + "',g_price='" + goods.getPrice() +
			     "',g_measurement='" + goods.getMeasurement() +"',g_stock='" + goods.getStock() + "',g_date=" + goods.getDate() + 
			     " where g_id=" + goods.getId() + ";";
	    PreparedStatement pstmt;
		pstmt = (PreparedStatement)conn.prepareStatement(sql);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
}
	
