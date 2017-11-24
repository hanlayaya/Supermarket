<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>purchase</title>
    <link rel="stylesheet" href="css/purchase.css">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  <script type="text/javascript" src="script/jquery-3.2.1.js"></script>
    <script type="text/javascript">
    	function editSupply(id,$theTr){
         	var edit = 0;  
         	$("body").append("<div id='mask'></div>");
			$("#mask").addClass("mask").fadeIn("slow");
			$("#editSupplyBox").fadeIn("slow");
			$("#editname").val($theTr.children("td")[0].innerText);
			$("#edittel").val($theTr.children("td")[1].innerText);
			$("#editconame").val($theTr.children("td")[2].innerText);
		    $("#editSupplyBox input").each(function(){
					$(this).change(function(){
						edit = 1;
					});
			});
			$("#editSupplyBox button:last").click(function(){
				if(edit == 1){
						$.post("editSupplyServlet",{id:id,
													name:$.trim($("#editname").val()),
													tel:$.trim($("#edittel").val()),
												    coname:$.trim($("#editconame").val())},function(returnedData,status){
													  		if($.trim(returnedData) == "Fail"){
													  			alert("修改失败");
													  		}else{
													  			$("#editSupplyBox").hide();
													  			alert("修改成功");
													  			location.reload();
													  		}	
													  });
			 	}else{
			 			$("#editSupplyBox").fadeOut("fast");
						$("#mask").css({ display: 'none' });
			 	}
			 		edit = 0;
			 	});
    	}
    	$().ready(function(){
    		$("form input:eq(1)").blur(function(){
    			var addstock = parseInt($.trim($(this).val()));
    			//判断addstock是否是整数
    			if((addstock | 0) === addstock){
    			}else{
    				$(this).val("");
    			}
    		});
    		//进货
    		$("input.pur_btn").click(function(){
    			if($.trim($("form input:eq(0)").val())!=""&&$.trim($("form input:eq(1)").val())!=""&&$("select:first").val()!=""&&$("select:last").val()!=""){
    			    $.post("addPurchaseServlet",{g_id:$.trim($("form input:eq(0)").val()),s_id:$("select:last option:selected").attr("id"),addstock:parseInt($.trim($("form input:eq(1)").val()))},function(returnedData,status){
    					alert("进货成功");
    				}); 
    			}           
    		});
    		//添加供应商
    		$("input.pur_supply").click(function(){
    			$("body").append("<div id='mask'></div>");
				$("#mask").addClass("mask").fadeIn("slow");
				$("#addSupplyBox").fadeIn("slow");
    		});    		
			//addSupplyBox的取消按钮
			$("#addSupplyBox button:first").click(function(){
				$("#addSupplyBox").fadeOut("fast");
				$("#mask").css({ display: 'none' });
				$("#addSupplyBox input").val("");
			});
			//editSupplyBox的取消按钮
			$("#editSupplyBox button:first").click(function(){
				$("#editSupplyBox").fadeOut("fast");
				$("#mask").css({ display: 'none' });
				$("#editSupplyBox input").val("");
			});
			//addSupplyBox的关闭
			$("#addSupplyBox .close_btn").hover(function () { $(this).css({ color: 'black' })}, function () { $(this).css({ color: '#999' }) }).on('click', function () {
					$("#addSupplyBox").fadeOut("fast");
					$("#mask").css({ display: 'none' });
					$("#addSupplyBox input").val("");
			});
		    //editSupplyBox的关闭
			$("#editSupplyBox .close_btn").hover(function () { $(this).css({ color: 'black' })}, function () { $(this).css({ color: '#999' }) }).on('click', function () {
					$("#editSupplyBox").fadeOut("fast");
					$("#mask").css({ display: 'none' });
					$("#editSupplyBox input").val("");
			});
			//addSupplyBox的保存按钮
			$("#addSupplyBox button:last").click(function(){
				if($("table tr").length <= 8){
					$.post("addSupplyServlet",{name:$.trim($("#name").val()),
											   tel:$.trim($("#tel").val()),
											   coname:$.trim($("#coname").val())},function(returnedData,status){
											   												$("#addSupplyBox").hide();
											   												$("#mask").css({ display: 'none' });
																							alert("添加成功");
																							location.reload();
																					});
				}else{
					$("#addSupplyBox").hide();
					$("#mask").css({ display: 'none' });
					alert("供应商已满");
				}

			});
    	    $.get("getSupplyServlet",{},function(returnedData,status){
    						var html = "";
               	   	    	for(var r = 0; r < returnedData.length;r++){
                    			var supply = returnedData[r];
                    		    var id = supply.id; 
                    			var name = supply.name;
                    			$("select:last").append("<option  id = " + id + ">" + name + "</option>");
                   	    		var tel = supply.tel;
                  	   	    	var person = supply.person;
                                html += "<tr align='center'><td>" + name + "</td><td>" + tel + "</td><td>" + person+ 
                                        "</td><td><button class='edit' id=" + id + ">编辑</button></td><td><button class='deletes' id=" +
                                        id + ">删除</button></td></tr>";        
                            }
                            $("table").append(html);
                            $("button.edit").click(function(){
                            	var id = $(this).attr("id"); 
            					editSupply(id,$(this).parent().parent());
                            });
                            $("button.deletes").click(function(){
                            	$.post("deleteSupplyServlet",{id:$(this).attr("id")},function(returnedData,status){
                            		if($.trim(returnedData) == "Fail"){
                            			alert("删除失败");
                            		}else{
                            			alert("删除成功");
                            			location.reload();
                            		}
                            	});
                            	$(this).unbind();
                            });
                           	$("tr:odd").css("background","#e3e3e3");
    		});
    		$.get("getGoodsNameServlet",{type:1},function(returnedData,status){
               	   	       for(var r = 0; r < returnedData.length;r++){
               	   	       		var id = $.trim(returnedData[r].substring(0,returnedData[r].indexOf(",")));
               	   	       		var name = $.trim(returnedData[r].substring(returnedData[r].indexOf(",") + 1,returnedData[r].length));
               	   	       		$("select:first").append("<option id = " + id + ">" + name + "</option>");
                            } 
                            $("form input:first").val($("select:first option:selected").attr("id"));
                            $("select:first").change(function(){
                            	$("form input:first").val($("select:first option:selected").attr("id"));
                            });
                            $("form input:first").blur(function(){
                            	var exit = 0;
                            	for(var i = 0;i < $("select:first option").length;i++){
                            	    if($.trim($(this).val()) == $("select:first option")[i].id){
                            			$("select:first option")[i].selected = true;
                            			exit = 1;
                            			break;
                            		}
                            	}
                            	if(exit == 0){
                            		$("form input:first").val($("select:first option:selected").attr("id"));
                            	}
                            });
    		}); 
    	    
    	});
    </script>
  </head>
  
  <body>
  	<div class="goods_title">
            <p><img src="imgs/dw.png"><span style="margin-left: 10px;">商品进货</span></p>
   </div>
  	<div class="goods_sel">
  		<form>
  			商品编号：<input type="text">
  			商品名称：<select>	
  		           </select>
  			供应商：<select>	
  		          </select>
  	                    供应数量：<input type="text" size=2>
  	   		<input type="button" value="添加进货" class="pur_btn">
  	   		<input type="button" value="添加供应商" class="pur_supply"> 
  	   </form>
    </div>   
  	<div class="goods_tab">
         <table class="goods_tt">
  			<tr><th>供应商名称</th><th>联系电话</th><th>联系人姓名</th><th></th></tr>	
  		</table>
  	</div>
    <div id="addSupplyBox">
      		<div class="row1">
        		增加供应商<a href="javascript:void(0)" class="close_btn">×</a>
        	</div>
        	<div class="row">
           	 	供应商名称<span><input type="text" id="name"/></span>
        	</div>
        	<div class="row">
            	联系电话&nbsp;&nbsp;&nbsp;<span><input type="text" id="tel"/></span>
        	</div>
        	<div class="row">
            	联系人姓名<span><input type="text" id="coname"/></span>
        	</div>
        	<div class="row">
        		<button>取消</button>
            	<button>保存</button>
        	</div>
     </div>
     <div id="editSupplyBox">
      		<div class="row1">
        		编辑供应商<a href="javascript:void(0)" class="close_btn">×</a>
        	</div>
        	<div class="row">
           	 	供应商名称<span><input type="text" id="editname"/></span>
        	</div>
        	<div class="row">
            	联系电话&nbsp;&nbsp;&nbsp;<span><input type="text" id="edittel"/></span>
        	</div>
        	<div class="row">
            	联系人姓名<span><input type="text" id="editconame"/></span>
        	</div>
        	<div class="row">
        		<button>取消</button>
            	<button>保存</button>
        	</div>
     </div>  
  </body>
</html>
