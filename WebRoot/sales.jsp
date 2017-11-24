<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>sales</title>
    <link rel="stylesheet" href="css/sales.css">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,ke yword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="script/jquery-3.2.1.js"></script>
    <script type="text/javascript">
    	function deleteTd(obj){
    		if($("table tr:first").siblings().length == 1){
    			$(obj).parent().parent().remove();
    			$("table").append("<tr><td></td><td></td><td></td><td></td><td></td></tr>");
    			$("tr:odd").css("background","#e3e3e3");
    		}else{
    			$(obj).parent().parent().remove();
    		}
    		
    	}
    	$().ready(function(){
    		var total = 0;
    	    $.get("getGoodsNameServlet",{type:1},function(returnedData,status){
               	   	       for(var r = 0; r < returnedData.length;r++){
               	   	       		var id = $.trim(returnedData[r].substring(0,returnedData[r].indexOf(",")));
               	   	       		var name = $.trim(returnedData[r].substring(returnedData[r].indexOf(",") + 1,returnedData[r].length));
               	   	       		$("select").append("<option id = " + id + ">" + name + "</option>");
                            } 
                            $("input:first").val($("select:first option:selected").attr("id"));
                            $("select").change(function(){
                            	$("input:first").val($("select:first option:selected").attr("id"));
                            });
                            $("input:first").blur(function(){
                            	var exit = 0;
                            	for(var i = 0;i < $("select:first option").length;i++){
                            	    if($.trim($(this).val()) == $("select:first option")[i].id){
                            			$("select:first option")[i].selected = true;
                            			exit = 1;
                            			break;
                            		}
                            	}
                            	if(exit == 0){
                            		$("input:first").val($("select:first option:selected").attr("id"));
                            	}
                            });
    		}); 
    		$("button:first").click(function(){
    			var number = parseInt($.trim($("input:last").val()));
    			if((number | 0) === number){
    			}else{
    				$("input:last").val("");
    				return;
    			}
    			if($.trim($("input:first").val())!=""&&$("select").val()!=""&&$.trim($("input:last").val())!=""){
    				$.get("getGoodsNameServlet",{type:"11111",id:$.trim($("input:first").val())},function(returnedData,status){	
    					if($("table tr:first").siblings().length == 8){
    						return;
    					}
    					if($("table tr:first").siblings().length == 1 && $("table tr:first").siblings("tr")[0].childNodes[0].innerText == ""){
    						$("table tr:first").siblings().remove();
    						$("table").append("<tr><td>" + $.trim($("input:first").val()) + "</td><td>" + $("select").val() + "</td><td>" + 
    						parseFloat(returnedData) + "</td><td>" + $.trim($("input:last").val()) + "</td><td><button onclick='deleteTd(this);'>删除</button></td></tr>");
    					}else{
    						$("table").append("<tr><td>" + $.trim($("input:first").val()) + "</td><td>" + $("select").val() + "</td><td>" + 
    						parseFloat(returnedData) + "</td><td>" + $.trim($("input:last").val()) + "</td><td><button onclick='deleteTd(this);'>删除</button></td></tr>");
    					}
    					$("tr:odd").css("background","#e3e3e3"); 
    				}); 
    				
    			}else{
    				$("form")[0].reset();
    				return;
    			}	
    		});
    		$("#sales_btn_zj").click(function(){
    			var total = 0;
    			for(var i = 1;i < $("table tr").length;i++){
    				var id = parseInt(document.getElementsByTagName("tr")[i].getElementsByTagName("td")[0].innerHTML.trim());	
    				var price = parseFloat(document.getElementsByTagName("tr")[i].getElementsByTagName("td")[2].innerHTML.trim());
    				var number = parseInt(document.getElementsByTagName("tr")[i].getElementsByTagName("td")[3].innerHTML.trim());
    				total += price*number;
    				$.ajax({
    					async: false,
    					type:'POST',
    					url:'addSalesServlet',
    					data: {"id":id,"price":price,"number":number},
    					success:function(data){
    					}
    				});
    			}
    			$("body").append("<div id='sum'><span>总价：</span>" + total + "<button>完成</button></div>");
    			$("#sum button").click(function(){
    				location.reload();
    			});
    		});
    		$("table").append("<tr><td></td><td></td><td></td><td></td><td></td></tr>");
    		$("tr:odd").css("background","#e3e3e3");
    	});
    </script>
  </head>
  
  <body>
  	 <div class="employee_title">
        <p><img src="imgs/dw.png"><span style="margin-left: 10px;">商品销售</span></p>
     </div>
  	<div class="sales_message">
  			<form>
		    	商品编号：<input type="text" size=1>
		    	商品名称：<select>	
		  		        </select>
		  		数量：<input type="text" size=2>
		  		<div class="sales_btns">
			  		<button type="button">添加销售</button>
			  		<button type="button" id="sales_btn_zj">结账</button>
			  	</div>	
		    </form>
	</div>  
	<div class="sale_tab">  
	    <table class="sales_tt">
	  		<tr><th>商品编号</th><th>商品名称</th><th>售价</th><th>数量</th><th>移除</th></tr>
	  	</table>
	</div>  	
  </body>
</html>
