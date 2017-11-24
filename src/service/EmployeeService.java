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
import model.Employee;
import model.Goods;

public class EmployeeService {
	Connection conn;
	
	//获取所有员工的信息
	public List getEmployee(int i) throws FileNotFoundException, ClassNotFoundException, IOException, SQLException{
		conn = JDBCuntl.getConnection(this.getClass().getClassLoader().getResource("/").getPath());
		int BEGIN = i*8-8;
		int LENGTH= 8;
		String sql = "select * from employee LIMIT " + BEGIN + "," + LENGTH;
		PreparedStatement pstmt;
		pstmt = (PreparedStatement)conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
        List<Employee> list = new ArrayList<Employee>();
		while(rs.next()){
			Employee employee = new Employee();
			employee.setId(rs.getInt("e_id"));
			employee.setName(rs.getString("e_name"));
			employee.setSex(rs.getString("e_sex"));
			employee.setAge(rs.getInt("e_age"));
			employee.setTel(rs.getString("e_tel"));
			employee.setAddress(rs.getString("e_address"));
			employee.setSalary(rs.getInt("e_salary"));
			employee.setIdcard(rs.getString("e_idcard"));
			employee.setBank(rs.getString("e_bank"));
			employee.setPassword(rs.getString("e_password"));
			list.add(employee);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return list;
	}
	//查询员工
	public List queryEmployee(String query,int i) throws FileNotFoundException, ClassNotFoundException, IOException, SQLException{
		conn = JDBCuntl.getConnection(this.getClass().getClassLoader().getResource("/").getPath());
		
		int BEGIN = i*8-8;
		int LENGTH= 8;
		List<Employee> list = new ArrayList<Employee>();
		String sql = "select * from employee where e_name LIKE '%" +  query + "%' or e_sex LIKE '%" + query + "%' or e_address LIKE '%" + query + 
				     "%' or e_tel LIKE '%" + query + "%' or e_age LIKE '%" + query + "%' LIMIT " + BEGIN + "," + LENGTH + ";";  
		PreparedStatement pstmt;
		pstmt = (PreparedStatement)conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()){
			Employee employee = new Employee();
			employee.setId(rs.getInt("e_id"));
			employee.setName(rs.getString("e_name"));
			employee.setSex(rs.getString("e_sex"));
			employee.setAge(rs.getInt("e_age"));
			employee.setTel(rs.getString("e_tel"));
			employee.setAddress(rs.getString("e_address"));
			employee.setSalary(rs.getInt("e_salary"));
			employee.setIdcard(rs.getString("e_idcard"));
			employee.setBank(rs.getString("e_bank"));
			employee.setPassword(rs.getString("e_password"));
			list.add(employee);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return 	list;
	}
	//解雇员工
	public void deleteEmployee(int id) throws FileNotFoundException, ClassNotFoundException, IOException, SQLException{
		conn = JDBCuntl.getConnection(this.getClass().getClassLoader().getResource("/").getPath());
		String sql = "delete from employee where e_id=" + id +";";
		PreparedStatement pstmt;
		pstmt = (PreparedStatement)conn.prepareStatement(sql);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	//编辑员工信息
	public void editEmployee(Employee employee) throws FileNotFoundException, ClassNotFoundException, IOException, SQLException{
		conn = JDBCuntl.getConnection(this.getClass().getClassLoader().getResource("/").getPath());
		String sql = "update employee set e_name='" + employee.getName() + "',e_tel='" + employee.getTel() + "',e_sex='" + employee.getSex() +
			     "',e_salary='" + employee.getSalary() + "',e_idcard='" + employee.getIdcard() + "',e_bank='" + employee.getBank() + 
			     "',e_age='" + employee.getAge() + "',e_password='" + employee.getPassword() + "',e_address='" + employee.getAddress() + 
			     "'  where e_id=" + employee.getId() + ";";
		System.out.println(sql);
		PreparedStatement pstmt;
		pstmt = (PreparedStatement)conn.prepareStatement(sql);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	//添加员工
	public void addEmployee(Employee employee) throws FileNotFoundException, ClassNotFoundException, IOException, SQLException{
		conn = JDBCuntl.getConnection(this.getClass().getClassLoader().getResource("/").getPath());
		String sql = "insert into employee values (null,'" + employee.getName() + "','" + 
					 employee.getSex() + "','" + employee.getAddress() + "','" + employee.getTel() + 
					 "'," + employee.getAge() + ",'" + employee.getIdcard() + "'," + employee.getSalary() + 
					 ",'" + employee.getBank() + "','" + employee.getPassword() + "');";
		System.out.println(sql);
		PreparedStatement pstmt;
		pstmt = (PreparedStatement)conn.prepareStatement(sql);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
}
