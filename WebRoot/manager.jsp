<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>manager</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>
  <script type="text/javascript" src="script/jquery-3.2.1.js"></script>
  <script type="text/javascript">
    $(document).ready(function(){
        $(".sidebar div").click(function(){
        	$("iframe").attr("src",$(this).attr("name") + ".jsp");
        });
    });
  </script>
  <style type="text/css">
    body{
      margin: 0;
      padding: 0;
      width: 100%;
      background-color: #f3f3f3;  
    }
    li {
      list-style: none
    }
    .nav{
      position:relative;
      width: 100%;
      height: 130px;
      border-bottom: 1px solid #ccc;
      background-color: white;  
    }
    .nav .logo{
      display: inline-block;
      /* float: left; */
      position:absolute;
      width: 18%;
      height:130px;
      left:0;
      padding-top:15px;
      background-color: #ffad0e;  
      border-right: 1px solid #ccc;
    }
    .nav .logo img{
    	padding-left: 75px;
    	margin:0 auto;
    }
    .nav .manage_title{
      position: absolute;
      /* width: 82%; */
      width: 80%;
      height: 80px;
      line-height: 80px;
      display: inline-block;
      left: 320px;
    }
    .nav .manage_title p{
      position:absolute;
      font-size: 20px;
      height: 90px;
      line-height:90px;
      color:#828083;
    }
    .main{
	    position: absolute;
      top: 10px;
      left:0;
      bottom:0;
      width: 100%; 
      overflow: hidden;  
      padding-right: 30px;
      box-sizing: border-box;
    }
    .main .sidebar{
  	  position: absolute;
  	  top:120px;
  	  left:0;
  	  /* width: 240px; */
  	  width:18%;
  	  height: 100%;
  	  background-color: #2b2b2b;
      overflow: hidden;
      -moz-box-shadow: 1px 1px 5px #ccc;
      -webkit-box-shadow: 1px 1px 5px #ccc;
      box-shadow: 1px 1px 5px #ccc;
    }
    .sidebar ul{
      margin:0;
      padding:0;
      position:absolute;
      display:block;
      width:300px;
	  height: 100%;
      /* left:25%; */
    }
    .main .sidebar>ul>li{
      display:block;
  	  position:relative;
      width:100%;
  	  border-bottom:1px solid #4d4d4d;
  	  background-color: #2b2b2b;
  	  box-sizing: border-box;
  	  height: 16%;

    }
    .main .sidebar>ul>li img{
      margin-left: -20px;
    }
    .main .sidebar>ul>li:hover{
       width:100%;
	   background-color: #000000;
    }
    .main .sidebar>ul>li div{
  	  position: absolute;
  	  left:50%;
  	  top:50%;
  	  height: 64px;
  	  width: 56px;  
  	  cursor:pointer;  
  	  margin-left: -28px;
  	  margin-top: -32px;
    }
    .main .sidebar>ul>li i{
  	  position: absolute;
  	  display: block;
  	  left:50%;
  	  top:8px;
  	  height: 32px;
    }
    .main .sidebar>ul>li i.account{
      width: 18%;
  	  margin-left: -12px;
  	  background-position: 0 -150px; 
    }
    .main .sidebar>ul>li p{
  	  position: relative;
  	  width: 70px;
  	  text-align: center;
  	  left:50%;
  	  top:40px;
  	  height: 32px;
  	  line-height: 32px;
      color:#FFAD0E; 
  	  margin-left: -40px;
    }
    .main .sidebar>ul>li i{
  	  position: absolute;
  	  display: block;
  	  left:50%;
  	  top:8px;
  	  height: 32px;
    }
    .change{
      position: absolute;
  	  top:140px;
  	  right:0px; 
  	  width: 80%;
      height: 90%;
      left: 20%;
      /* background:blue; */ 
    }
    #index_nav_a{
    	/* float:right; */
    	position:absolute;
    	right:4%;
    	top:30px;
    	z-index:333;
    	color:#2b2b2b;
    }
  </style>
  
  <body>
    <div class="nav">
      <div class="logo">
        <img src="imgs/logo5.png">
      </div>
      <div class="manage_title">
        <p>您好，欢迎使用佳佳超市系统 ！</p>
        <a id="index_nav_a" href="cancelServlet">退出登录</a>
      </div>
     
    </div>
    <div class="main">
      <div class="sidebar">
        <ul>
          <li>
            <div name="goods">
              <i><img src="imgs/sp.png" width="100%"></i>
              <p>商品管理</p>
            </div>
          </li>
          <li>
            <div name="employee">
              <i><img src="imgs/yg.png" width="100%"></i>
              <p>员工信息</p>
            </div>
          </li>
          <li>
            <div name="purchase">
              <i><img src="imgs/jh.png" width="100%"></i>
              <p>商品进货</p>
            </div>
          </li>
          <li>
            <div name="sales">
              <i><img src="imgs/xs.png" width="100%"></i>
              <p>商品销售</p>
            </div>
          </li>
          <li>
            <div name="summary">
              <i><img src="imgs/zl.png" width="100%"></i>
              <p>销售总览</p>
            </div>
          </li>
        </ul>
      </div>
      <div class="change">
        <iframe src="goods.jsp" height="95%" width="98%" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" align="center"></iframe>
      </div>
    </div> 
  </body>
</html>