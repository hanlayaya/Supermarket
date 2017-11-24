<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>employee</title>
    <link rel="stylesheet" href="css/employee.css">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="script/jquery-3.2.1.js"></script>
    <script type="text/javascript">
		//解雇
        function deleteById(id){
         	$.post("deleteEmployeeServlet",{id:id},function(returnedData,status){
         			if($.trim(returnedData) == "Fail"){
         				alert("解雇失败");
         			}else{
         				alert("解雇成功");
         			}
         	});
        };
    	function showPage(page){
         	 $.get("getEmployeeServlet",{page:page},function(returnedData,status){
         	 				if(returnedData.length == 0){
         	 					page = page - 1;
         	 					showPage(page);
         	 				}else{
	         	 				var html = "";
	               	   	    	for(var r = 0; r < returnedData.length;r++){
	                    			var employee = returnedData[r];
	                    		    var id = employee.id; 
	                    			var name = employee.name;
	                    			var sex = employee.sex;
	                   	    		var age = employee.age;
	                  	   	    	var tel = employee.tel;
	                  	    		var address = employee.address;
	                  	    		var salary = employee.salary;
	                  	    		var idcard = employee.idcard;
                  	   			    if(employee.bank){
                  	   			    	var bank = employee.bank;
                  	   			    }else{
                  	   			    	var bank = "";
                  	   			    }
                  	                var password = employee.password;
	                                html += "<tr align='center'><td>" + name + "</td><td>" + sex +
	                                        "</td><td>" + age + "</td><td>" + tel+ "</td><td>"
	                                        + address + "</td><td>" + salary + "</td><td><button class='deletes' id='" 
	                                        + id + "'>解雇</button><button class='edit' id='" + id +"'>详情</button>" +
	                                        "<p style='display:none;'>" + idcard + "</p><p style='display:none;'>" + bank +
	                                        "</p><p style='display:none;'>" + password + "</p></td></tr>";             
	                            }
	                            $("table").append(html);
	                            while($("table tr:first").siblings("tr").length < 8){
	                  				$("table").append("<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>");
	                  			};
	                            $("tr:odd").css("background","#e3e3e3");
	                            $("button.deletes").click(function(){
             						if(confirm("您确定要解雇此员工吗？")){
                						var id = $(this).attr("id"); 
        								deleteById(id);
               	    				}
               	    				$(this).unbind("click"); 
                					$(this).siblings("button").unbind("click");
             					});
             					$("button.edit").click(function(){
             						var id = $(this).attr("id"); 
            						var $theTr = $(this).parent("td").parent("tr");
            						editEmployee(id,$theTr);
             					});
	         	 		     }
         	   	       });
         }
         function showQueryPage(query,querypage){
         	$.post("getEmployeeServlet",{query:query,querypage:querypage},function(returnedData,status){
         	    var html = "";
         	    if(returnedData.length == 0){  
         	 		while($("table tr:first").siblings("tr").length < 8){
	                	$("table").append("<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>");
	                };
	                $("tr:odd").css("background","#e3e3e3"); 
         	 	}else{
         	 		for(var r = 0; r < returnedData.length;r++){
               			var employee = returnedData[r];
               			var id = employee.id; 
                    	var name = employee.name;
                    	var sex = employee.sex;
                   	    var age = employee.age;
                  	   	var tel = employee.tel;
                  	    var address = employee.address;
                  	    var salary = employee.salary;
                  	    var idcard = employee.idcard;
                  	    if(employee.bank){
                  	   		var bank = employee.bank;
                  	   	}else{
                  	   		var bank = "";
                  	   	}
                  	    var password = employee.password;
                    	html += "<tr align='center'><td>" + name + "</td><td>" + sex +
	                                        "</td><td>" + age + "</td><td>" + tel+ "</td><td>"
	                                        + address + "</td><td>" + salary + "</td><td><button class='deletes' id='" 
	                                        + id + "'>解雇</button><button class='edit' id='" + id +"'>详情</button>" +
	                                        "<p style='display:none;'>" + idcard + "</p><p style='display:none;'>" + bank +
	                                        "</p><p style='display:none;'>" + password + "</p></td></tr>";    
                	}
                	$("table").append(html);
                	while($("table tr:first").siblings("tr").length < 8){
	                	$("table").append("<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>");
	                };
                	$("tr:odd").css("background","#e3e3e3"); 	
                	$("button.deletes").click(function(){
             			if(confirm("您确定要解雇此员工吗？")){
                			var id = $(this).attr("id"); 
        					deleteById(id);
               	    	}
               	    	$(this).unbind("click"); 
                		$(this).siblings("button").unbind("click");
             		});
             		$("button.edit").click(function(){
             			var id = $(this).attr("id"); 
             			var $theTr = $(this).parent("td").parent("tr");
            			editEmployee(id,$theTr);
             		});
                  	while($("table tr:first").siblings("tr").length < 8){
                  		$("table").append("<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>");
                  	};
         	  }
              
           });
         }
         function editEmployee(id,$theTr){ 
         		var edit = 0;  
         		$("body").append("<div id='mask'></div>");
				$("#mask").addClass("mask").fadeIn("slow");
				$("#editEmployeeBox").fadeIn("slow");
				$("#editname").val($theTr.children("td")[0].innerText);
				$("#editsex").val($theTr.children("td")[1].innerText);
				$("#editage").val($theTr.children("td")[2].innerText);
				$("#editaddress").val($theTr.children("td")[4].innerText);
				$("#editsalary").val($theTr.children("td")[5].innerText);
				$("#edittel").val($theTr.children("td")[3].innerText);
				$("#editidcard").val($theTr.children("td")[6].getElementsByTagName("p")[0].innerText);
				$("#editbank").val($theTr.children("td")[6].getElementsByTagName("p")[1].innerText);
				$("#editpassword").val($theTr.children("td")[6].getElementsByTagName("p")[2].innerText);	
			 	$("#editEmployeeBox input").each(function(){
						$(this).change(function(){
							edit = 1;
						});
				});
				$("#editEmployeeBox button:last").click(function(){
					if(edit == 1){
						$.post("editEmployeeServlet",{id:id,
													  name:$.trim($("#editname").val()),
													  sex:$.trim($("#editsex").val()),
													  age:$.trim($("#editage").val()),
													  address:$.trim($("#editaddress").val()),
													  salary:$.trim($("#editsalary").val()),
													  tel:$.trim($("#edittel").val()),
													  idcard:$.trim($("#editidcard").val()),
													  bank:$.trim($("#editbank").val()),
													  password:$.trim($("#editpassword").val())},function(returnedData,status){
													  		if($.trim(returnedData) == "Fail"){
													  			alert("修改失败");
													  		}else{
													  			$("#editEmployeeBox").fadeOut("fast");
													  			$("#editEmployeeSuccess").show();
													  		}	
													  });
			 		}else{
			 			$("#editEmployeeBox").fadeOut("fast");
						$("#mask").css({ display: 'none' });
			 		}
			 		edit = 0;
			 	});
			 	
         } 
         $().ready(function(){
         	var page = 1;
         	var querypage = 1;
         	showPage(page);
         	//添加员工
         	$(".employee_sel_left button").click(function(){
         	 	$("body").append("<div id='mask'></div>");
				$("#mask").addClass("mask").fadeIn("slow");
				$("#addEmployeeBox").fadeIn("slow");
         	 });
         	 //addEmployeeBox遮罩的关闭
         	 $("#addEmployeeBox .close_btn").hover(function () { $(this).css({ color: 'black' })}, function () { $(this).css({ color: '#999' }) }).on('click', function () {
				$("#addGoodsBox").fadeOut("fast");
				$("#mask").css({ display: 'none' });
			});	
			//addEmployeeBox的取消按钮
			$("#addEmployeeBox button:first").click(function(){
				$("#addEmployeeBox").fadeOut("fast");
				$("#mask").css({ display: 'none' });
				$("#addEmployeeBox input").val("");
			});
			//editEmployeeBox的取消按钮
			$("#editEmployeeBox button:first").click(function(){
					$("#editEmployeeBox").fadeOut("fast");
					$("#mask").css({ display: 'none' });
			});
			//addEmployeeBox的关闭
			$("#addEmployeeBox .close_btn").hover(function () { $(this).css({ color: 'black' })}, function () { $(this).css({ color: '#999' }) }).on('click', function () {
					$("#addEmployeeBox").fadeOut("fast");
					$("#mask").css({ display: 'none' });
					$("#addEmployeeBox input").val("");
			});
			//editEmployeeBox的关闭
			$("#editEmployeeBox .close_btn").hover(function () { $(this).css({ color: 'black' })}, function () { $(this).css({ color: '#999' }) }).on('click', function () {
					$("#editEmployeeBox").fadeOut("fast");
					$("#mask").css({ display: 'none' });
			});
			//保存
			$("#addEmployeeBox button:last").click(function(){
				$.post("addEmployeeServlet",{name:$.trim($("#name").val()),
											 age:$.trim($("#age").val()),
											 sex:$.trim($("#sex").val()),
											 idcard:$.trim($("#idcard").val()),
											 bank:$.trim($("#bank").val()),
											 address:$.trim($("#address").val()),
											 tel:$.trim($("#tel").val()),
											 password:$.trim($("#password").val()),
											 salary:$.trim($("#salary").val())
											},function(returnedData,status){
													if($.trim(returnedData) == "Fail"){
														alert("添加失败");
													}else{
														$("#addEmployeeBox").fadeOut("fast");
            											$("#addEmployeeSuccess").show();
            											$("#addEmployeeBox input").val("");
													}
				                            		
											});
            		
			 });
			 
			 //addEmployeeSuccess的关闭
			$("#addEmployeeSuccess .close_btn").hover(function () { $(this).css({ color: 'black' })}, function () { $(this).css({ color: '#999' }) }).on('click', function () {
				$("#addEmployeeSuccess").fadeOut("fast");
				$("#mask").css({ display: 'none' });
			});
			//addEmployeeSuccess的关闭
			$("#editEmployeeSuccess .close_btn").hover(function () { $(this).css({ color: 'black' })}, function () { $(this).css({ color: '#999' }) }).on('click', function () {
				$("#editEmployeeSuccess").fadeOut("fast");
				$("#mask").css({ display: 'none' });
			});
         	$("#next").click(function(){
         	 	page = page + 1;
         	 	$("table tr:first").siblings("tr").remove();
         	 	showPage(page);
         	 }); 
         	 
         	 $("#previous").click(function(){
         	 	if(page > 1){
         	 		page = page - 1;
         	 		$("table tr:first").siblings("tr").remove();
         	 		showPage(page);
         	 	}	
         	 });
         	 
         	  $("#forward").click(function(){
         	 	if($("#forwardinput").val() != ""){
         	 		page = parseInt($("#forwardinput").val());
         	 		if((page | 0) === page){
         	 			$("table tr:first").siblings("tr").remove();
         	 			showPage(page);
         	 		}else{
         	 			page = 1;
         	 		} 
         	 	}	
         	 });
         	 
         	 $("#query").click(function(){
         	 	if($.trim($("#queryinput").val()) == ""){
         	 		$("#forwardinput").show();
         	 		$("#forward").show();
         	 		$("table tr:first").siblings("tr").remove();
         	 		showPage(1);
         	 		$("#next").unbind("click");
         	 		$("#previous").unbind("click");
         	 		$("#next").click(function(){
         	 	    	page = page + 1;
         	 			$("table tr:first").siblings("tr").remove();
         	 			showPage(page);
         	        }); 
         		   $("#previous").click(function(){
         	 	   		if(page > 1){
         	 			page = page - 1;
         	 			$("table tr:first").siblings("tr").remove();
         	 			showPage(page);
         	 			}	
         		   });
         	 	}else{
         	 		$("#forwardinput").hide();
         	 		$("#forward").hide();
         	 		var query = $("#queryinput").val();
         	 		$("table tr:first").siblings("tr").remove();
         	 		showQueryPage(query,querypage);
         	 		$("#next").unbind("click");
         	 		$("#previous").unbind("click");
         	 		$("#next").click(function(){
         	 			querypage = querypage + 1;
         	 			$("table tr:first").siblings("tr").remove();
         	 			showQueryPage(query,querypage);
         	 		});
         	 		$("#previous").click(function(){
         	 			if(querypage > 1){
         	 				querypage = querypage - 1;
         	 				$("table tr:first").siblings("tr").remove();
         	 			    showQueryPage(query,querypage);
         	 			}	
         	 		});
         	 	}	
         	 }); 
         });
    </script>
    
  </head>
  
  <body>
        <div class="employee_title">
            <p><img src="imgs/dw.png"><span style="margin-left: 10px;">员工信息</span></p>
        </div>
        <div class="employee_sel">
        	<div class="employee_sel_left">
                <button>添加</button>
        	</div>
        	<div class="employee_sel_right">
        		<input type="text" id="queryinput">
                <button id="query">查询</button>
        	</div>
        </div>           
        <div class="employee_tab">
         	<table class="employee_tt">
         		<tr><th>姓名</th><th>性别</th><th>年龄</th><th>电话</th><th>家庭住址</th><th>月薪</th></tr>
                <div class="employee_tab_bottom">
                    <button id="previous">上一页</button>
                    <button id="next">下一页</button>
                    <input type="text" size=1 id="forwardinput">
                    <button id="forward">转到</button>
                </div>
         	</table>
        </div>
        <div id="addEmployeeBox">
      		<div class="row1">
        		增加员工<a href="javascript:void(0)" class="close_btn">×</a>
        	</div>
        	<div class="row">
           	 	姓名<span><input type="text" id="name"/></span>
           	 	性别<span><input type="text" id="sex"/></span> 
           	 	年龄<span><input type="text" id="age"/></span>
        	</div>
        	<div class="row">
            	地址<span><input type="text" id="address"/></span>
            	月薪<span><input type="text" id="salary"/></span>
            	电话<span><input type="text" id="tel"/></span>
        	</div>
        	<div class="row">
            	身份证号&nbsp;&nbsp;<span><input type="text" id="idcard"/></span>
        	</div>
        	<div class="row">
            	银行卡号&nbsp;&nbsp;<span><input type="text" id="bank"/></span>
        	</div>
        	<div class="row">
            	登录密码&nbsp;&nbsp;<span><input type="text" id="password"/></span>
        	</div>
        	<div class="row">
        		<button>取消</button>
            	<button>保存</button>
        	</div>
        </div>
        <div id="editEmployeeBox">
      		<div class="row1">
        		员工详情<a href="javascript:void(0)" class="close_btn">×</a>
        	</div>
        	<div class="row">
           	 	姓名<span><input type="text" id="editname"/></span>
           	 	性别<span><input type="text" id="editsex"/></span> 
           	 	年龄<span><input type="text" id="editage"/></span>
        	</div>
        	<div class="row">
            	地址<span><input type="text" id="editaddress"/></span>
            	月薪<span><input type="text" id="editsalary"/></span>
            	电话<span><input type="text" id="edittel"/></span>
        	</div>
        	<div class="row">
            	身份证号&nbsp;&nbsp;<span><input type="text" id="editidcard"/></span>
        	</div>
        	<div class="row">
            	银行卡号&nbsp;&nbsp;<span><input type="text" id="editbank"/></span>
        	</div>
        	<div class="row">
            	登录密码&nbsp;&nbsp;<span><input type="text" id="editpassword"/></span>
        	</div>
        	<div class="row">
        		<button>取消</button>
            	<button>保存</button>
        	</div>
        </div>
        <div id="addEmployeeSuccess">
       		<div class="row1">
        		增加员工<a href="javascript:void(0)" class="close_btn">×</a>
        	</div>
        	<div class="row">
            	增加成功
        	</div>
       </div>
        <div id="editEmployeeSuccess">
       		<div class="row1">
        		修改员工<a href="javascript:void(0)" class="close_btn">×</a>
        	</div>
        	<div class="row">
            	修改成功
        	</div>
       </div> 
  </body>
</html>
