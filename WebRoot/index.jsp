<%@ page language="java" import="java.util.*,java.sql.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
  <head>
    <base href="<%=basePath%>">  
    <title>首页</title>
    <link rel="stylesheet" href="css/easyform.css">
    <link rel="stylesheet" href="css/index.css">
    <script type="text/javascript" src="script/jquery-3.2.1.js"></script>
    <script src="script/easyform.js"></script>
    <script type="text/javascript">
      $(document).ready(function(){
          var ef = $('#form').easyform();
          $("#user").focus(function(){
            var value=$(this).val();
            if (value==this.defaultValue) {
              $(this).val("");
            }
          });
          $("#user").blur(function(){
            var value=$(this).val();
            if (value=="") {
              $(this).val(this.defaultValue);
            }
          });

          $("#psw").focus(function(){
            $("#animat").attr("src","imgs/people_none1.png");
            $("#arm").animate({
                opacity:"0",
            });
            $("#arm1").css("display","block");
           
          });
          $("#psw").blur(function(){
            $("#animat").attr("src","imgs/people_none.png");
            $("#arm").animate({
                opacity:"100",
            });
            $("#arm1").css("display","none");
          });
		  /* $("#sub").click(function(){
		  		var username = $.trim($("#user").val());
		  		var password = $("#psw").val();
		  		var type = $("input[type='radio']:checked").attr("id");
		  	    $.post("loginServlet",{username:username,
		  	    					  password:password,
		  	    					  type:type},function(returnedData,status){
		  	    					  		if($.trim(returnedData) == "1"){
		  	    					  			location.href = "manager.jsp";
		  	    					  		}else if($.trim(returnedData) == "2"){
		  	    					  		
		  	    					  			location.href = "general.jsp";
		  	    					  		}
		  	    					  }); 
		  });  */
      });
    </script>
  </head>
  <body bgcolor="#2b2b2b">
      <div class="index_con">
          <div class="index_mid">
              <div class="index_mid_form"> 
                  <form id="form" action="loginServlet">
                      <p style="color:#fff;text-align: center;font-size: 30px;margin:20px 0 20px;">佳佳超市管理系统</p>
                      <!-- user -->
                      <input name="user" type="text" id="user" data-easyform="length:2 19;char-chinese;real-time;" data-message="请输入正确的用户名" data-easytip="position:left;" placeholder="  请输入用户名或员工姓名" onfocus="this.placeholder=''" onblur="this.placeholder='  请输入用户名或员工姓名'">
                      <!-- password -->
                      <input name="password" id="psw" type="password" data-easyform="length:6 11;real-time;" data-message="请输入正确的密码" data-easytip="position:left;" placeholder="   请输入密码(6~11位)"  onfocus="this.placeholder=''" onblur="this.placeholder='   请输入密码(6~11位)'">
                      <br>
                      <!-- radio  -->
                      <input name="peo" type="radio"  value=1 data-message="请选择人群" data-easyform="real-time;" data-easytip="position:left;" />&nbsp;&nbsp;<label>管理员</label> &nbsp;&nbsp;
                      <input name="peo" type="radio" value=2 data-easyform="real-time;" data-easytip="position:left;"  checked/>&nbsp;&nbsp;<label>普通员工</label> 
                      <!-- submit   -->
                      <input type="submit" name="" id="sub" value="登    录">
                  </form>
              </div>
              <div class="index_mid_people"> 
                  <img src="imgs/people_none.png" id="animat">
                  <img src="imgs/arm.png" id="arm">
                  <img src="imgs/arm1.png" id="arm1">
              </div>
          </div>
          <div class="index_bottom">
              <div class="index_bottom_left"> 
              </div>
              <div class="index_bottom_right"> 
                <p id="copy">copyright  ©  2017-2020  长春工业大学  数字媒体技术系    版权所有 </p>
              </div>
          </div>
      </div>
  </body>
</html>
























