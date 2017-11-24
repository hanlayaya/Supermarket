<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>goods</title>
    <link rel="stylesheet" href="css/goods.css">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="script/jquery-3.2.1.js"></script>
    <script type="text/javascript">
    	//给addGoodsBox和editGoodsBox设置日期
    	function getDate(){
    	 	 var i=2017;
    		 var date = new Date();
             year = date.getFullYear();
    		 var dropList;
   			 for(i;i<2022;i++){
      		 	if(i == year){
            		dropList = dropList + "<option value='"+i+"' selected>"+i+"</option>";
        		}else{
            		dropList = dropList + "<option value='"+i+"'>"+i+"</option>";
        		}
    		 }
   			 $("#year,#edityear").html(dropList);
   			 var monthly;
    		 for(month=1;month<13;month++){
             	monthly = monthly + "<option value='"+month+"'>"+month+"</option>";
             }
   			 $("#month,#editmonth").html(monthly);
   			 var dayly;
   			 for(day=1;day<=31;day++){
       			 dayly = dayly + "<option value='"+day+"'>"+day+"</option>";
    		 }
   			 $("#day,#editday").html(dayly);
    		 $("#month").change(function(){
       			 var currentDay;
        		 var Flag = $("#year").val();
        		 var currentMonth = $("#month").val();
       			 switch(currentMonth){
           			 case "1" :case "3" :case "5" :case "7" :case "8" :case "10" :
            		 case "12" :total = 31;break;
            		 case "4" :case "6" :case "9" :
           		 	 case "11" :total = 30;break;
            	 	 case "2" :
               		 if((Flag%4 == 0 && Flag%100 != 0) || Flag%400 == 0){
                     	total = 29;
                     }else{
                     	total = 28;
                     }
                     default:break;
            	}
         		for(day=1;day <= total;day++){
            		currentDay = currentDay + "<option value='"+day+"'>"+day+"</option>";
        		}
       		    $("#day").html(currentDay);
        	});	
        	$("#editmonth").change(function(){
       			 var currentDay;
        		 var Flag = $("#edityear").val();
        		 var currentMonth = $("#editmonth").val();
       			 switch(currentMonth){
           			 case "1" :case "3" :case "5" :case "7" :case "8" :case "10" :
            		 case "12" :total = 31;break;
            		 case "4" :case "6" :case "9" :
           		 	 case "11" :total = 30;break;
            	 	 case "2" :
               		 if((Flag%4 == 0 && Flag%100 != 0) || Flag%400 == 0){
                     	total = 29;
                     }else{
                     	total = 28;
                     }
                     default:break;
            	}
         		for(day=1;day <= total;day++){
            		currentDay = currentDay + "<option value='"+day+"'>"+day+"</option>";
        		}
       		    $("#editday").html(currentDay);
        	});
    	 }
    	 
    	 function trans(date){
         	 	var d = date.indexOf(",");
         	 	var year = date.substring(d + 1);
         	 	var day = date.substring(d - 2,d).trim();
         	 	var month = date.substring(0,d - 2).trim();
         	 	var months = ["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"];
         	 	for(var p = 0;p < 12;p++){
         	 		if(month == months[p])
         	 			month = p + 1;
         	 	}
         	 	return year + "-" + month + "-" + day;
         	 }
         
         function deleteById(id){
         	$.post("deleteGoodsServlet",{id:id},function(returnedData,status){
         		if($.trim(returnedData) == "Fail"){
         			alert("删除失败");
         		}else{
         			alert("删除成功");
         		} 
         	});
         }	 
         function editGoods(id,$theTr){
         		$("body").append("<div id='mask'></div>");
				$("#mask").addClass("mask").fadeIn("slow");
				$("#editGoodsBox").fadeIn("slow");
				$("#editname").val($theTr.children("td")[0].innerHTML);
				$("#editname")[0].select();
				$("#edittype").val($theTr.children("td")[1].innerHTML);
				$("#editprice").val($theTr.children("td")[2].innerHTML);
				$("#editmeasurement").val($theTr.children("td")[3].innerHTML);
				$("#editstock").val($theTr.children("td")[4].innerHTML);
				$("#editGoodsBox button:last").click(function(){
				var permit = 1;
				if($.trim($("#editname").val()) == ""||$.trim($("#edittype").val()) == ""||$.trim($("#editprice").val()) == ""||$.trim($("#editmeasurement").val()) == ""||$.trim($("#editstock").val()) == ""){
					permit = 0;
				}
				else if(isNaN(parseFloat($.trim($("#editprice").val())))||isNaN(parseInt($.trim($("#editstock").val())))){
					permit = 0;
				}
				if(permit == 1){
					if($("#edithasDate:checked").val() != "hasDate"){
						$.post("editGoodsServlet",{name: $("#editname").val(), 
												  id:id,
            	  	                              type:$("#edittype").val(), 
            	  	                              price:$("#editprice").val(),
            	  	                              measurement:$("#editmeasurement").val(),
            	  	                              stock:$("#editstock").val(),
            	  	                              year:$("#edityear option:selected").val(),
            	  	                              month:$("#editmonth option:selected").val(),
            	  	                              day:$("#editday option:selected").val()},
            	  	                              function(returnedData,status){
            	  	                              		$("#editGoodsBox").hide();
            	  	                              		$("#editGoodsSuccess").show();
            	  	                              }
            	  	    );
					}else{
						$.post("editGoodsServlet",{name: $("#editname").val(), 
												  id:id,
            	  	                              type:$("#edittype").val(), 
            	  	                              price:$("#editprice").val(),
            	  	                              measurement:$("#editmeasurement").val(),
            	  	                              stock:$("#editstock").val()},
            	  	                              function(returnedData,status){
            	  	                              		$("#editGoodsBox").hide();
            	  	                              		$("#editGoodsSuccess").show();
            	  	                              }                         	
	                    );
					}
				}	
			 });	
         } 
         function showPage(page){
         	   	$.ajax({
    				async: false,
    				type:'GET',
    				url:'getGoodsServlet',
    				dataType:'json',
    				data: {"page":page},
    				success:function(data){
    						var html = "";	
         	 				if($.trim(data) == "false"){
         	 					page = page - 1;
         	 					showPage(page);   
         	 				}else{
         	 					for(var r = 0; r < data.length;r++){
                    				var goods = data[r];
                    		   	    var id = goods.id; 
                    				var name = goods.name;
                   	    			var type = goods.type;
                  	   	    		var price = goods.price;
                  	    			var measurement = goods.measurement;
                  	    			var stock = goods.stock;
                   	    			var date = goods.date;
                   	    			var detail = goods.detail;
                        			if(date == undefined){ 
                   						date = "无";
                        			}else{
                   						date = trans(date);
                       		    	}
                                    html += "<tr align='center'><td>" + name + "</td><td>" + type +
                                            "</td><td>" + price + "</td><td>" + measurement+ "</td><td>"
                                            + stock + "</td><td>" + date + "</td>" + "<td><button class='deletes' id='" 
                                            + id + "'>删除</button><button class='edit' id='" + id + "'>编辑</button><button class='detail' id='" + 
                                            id + "'>商品详情<p style='display:none'>" + detail + "</p></button></td></tr>";             
                                  }
                            	$("table").append(html);
                            	$("button.deletes").click(function(){
             						if(confirm("您确定要删除吗？")){
                						var id = $(this).attr("id"); 
        								deleteById(id);
                					}
                				    $(this).unbind("click"); 
                				    $(this).siblings("button").unbind("click");
             					});
            				    $("button.edit").click(function(){
             						var id = $(this).attr("id"); 
            						editGoods(id,$(this).parent().parent());
             					});
             					$("button.detail").click(function(){
             						$(".goods_tt").add($(".goods_tab_bottom")).hide();
             						$(".goods_tab").append("<div class='uedit'></div>"); 
             						$(".uedit").append($("#container")).append("<br><button class='save_detail' id=" + $(this).attr("id") + ">保存</button>"); 
             						var ue = UE.getEditor("container");
             						$("#container").text($(this).children("p")[0].innerText);
             						$($("button.save_detail")).click(function(){
             							$.ajax({async:false,
             									type:'POST',
             									url:'addGoodsDetailServlet',
             									data:{id:$(this).attr("id"),detail:ue.getContentTxt()},
             									success:function(data){
             										if($.trim(data) == "Fail"){
             											alert("修改失败");
             										}
             										$("div.uedit").remove();
             										$(".goods_tt").add($(".goods_tab_bottom")).show();
             										location.reload();
             									}
             							});
             						});
             					});
                            	while($("table tr:first").siblings("tr").length < 8){
                            		$("table").append("<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>");
                            	};
         	 			    } 	
         	 				$("tr:odd").css("background","#e3e3e3");
         	   	       }
    			});   
         }
         
         function showQueryPage(query,querypage){
         	$.get("queryGoodsServlet",{query:query,querypage:querypage},function(returnedData,status){
         	    var html = "";
         	    if($.trim(returnedData) == "false"){ 
         	 		while($("table tr:first").siblings("tr").length < 8){
                  		$("table").append("<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>");
                  	};  
         	 	}else{
         	 		for(var r = 0; r < returnedData.length;r++){
               			var goods = returnedData[r];
               			var id = goods.id;
                    	var name = goods.name;
                    	var type = goods.type;
                    	var price = goods.price;
                    	var measurement = goods.measurement;
                    	var stock = goods.stock;
                   		var date = goods.date;
                    	if(date == undefined){
                    		date = "无";
                    	}else{
                    		date = trans(date);
                    	}
                    	html += "<tr align='center'><td>" + name + "</td><td>" + type +
                                "</td><td>" + price + "</td><td>" + measurement+ "</td><td>"
                                + stock + "</td><td>" + date + "</td>" + "<td><button class='deletes' id='" 
                                + id + "'>删除</button><button class='edit' id='" + id +"'>编辑</button></td></tr>";   
                	}
                	$("table").append(html);
                	$("button.deletes").click(function(){
             			if(confirm("您确定要删除吗？")){
                			var id = $(this).attr("id"); 
        					deleteById(id);
               	    	}
               	    	$(this).unbind("click"); 
                		$(this).siblings("button").unbind("click");
             		});
             		$("button.edit").click(function(){
             			var id = $(this).attr("id"); 
            			editGoods(id,$(this).parent().parent());
             		});
                  	while($("table tr:first").siblings("tr").length < 8){
                  		$("table").append("<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>");
                  	};
         	  }
              $("tr:odd").css("background","#e3e3e3"); 	
           });
         } 
         	 
         $().ready(function(){
         	getDate();
         	var page = 1;
            var querypage = 1;
         	showPage(page);
         	//添加商品信息
         	$(".goods_sel_left button").click(function(){
         	 	$("body").append("<div id='mask'></div>");
				$("#mask").addClass("mask").fadeIn("slow");
				$("#addGoodsBox").fadeIn("slow");
				$("#container").show();
         	 });
         	//有无保质期
            $("#hasDate").click(function(){
             	if($("#hasDate:checked").val() == "hasDate"){
             		$("#year").val("");
             		$("#month").val("");
             		$("#day").val("");
             	}
            });
            $("#edithasDate").click(function(){
             	if($("#edithasDate:checked").val() == "hasDate"){
             		$("#edityear").val("");
             		$("#editmonth").val("");
             		$("#editday").val("");
             	}
            });
           	//保存
			$("#addGoodsBox button:last").click(function(){
				var permit = 1;
				if($.trim($("#name").val()) == ""||$.trim($("#type").val()) == ""||$.trim($("#price").val()) == ""||$.trim($("#measurement").val()) == ""||$.trim($("#stock").val()) == ""){
					permit = 0;
				}
				else if(isNaN(parseFloat($.trim($("#price").val())))||isNaN(parseInt($.trim($("#stock").val())))){
					permit = 0;
				}
				if(permit == 1){
					if($("#hasDate:checked").val() != "hasDate"){
						$.post("addGoodsServlet",{name: $("#name").val(), 
            	  	                              type:$("#type").val(), 
            	  	                              price:$("#price").val(),
            	  	                              measurement:$("#measurement").val(),
            	  	                              stock:$("#stock").val(),
            	  	                              year:$("#year option:selected").val(),
            	  	                              month:$("#month option:selected").val(),
            	  	                              day:$("#day option:selected").val()},
            	  	                              function(returnedData,status){
            	  	                              		$("#addGoodsBox").hide();
            	  	                              		$("#addGoodsSuccess").show();
            	  	                              }
            	  	    );
					}else{
						$.post("addGoodsServlet",{name: $("#name").val(), 
            	  	                              type:$("#type").val(), 
            	  	                              price:$("#price").val(),
            	  	                              measurement:$("#measurement").val(),
            	  	                              stock:$("#stock").val()},
            	  	                              function(returnedData,status){
            	  	                              		$("#addGoodsBox").hide();
            	  	                              		$("#addGoodsSuccess").show();
            	  	                              }                         	
	                    );
					}
				}	
			 });
           	//addGoodsBox的关闭
           	$("#addGoodsBox .close_btn").hover(function () { $(this).css({ color: 'black' })}, function () { $(this).css({ color: '#999' }) }).on('click', function () {
				$("#addGoodsBox").fadeOut("fast");
				$("#mask").css({ display: 'none' });
			});	
			//addGoodsBox的取消按钮
			$("#addGoodsBox button:first").click(function(){
				$("#addGoodsBox").fadeOut("fast");
				$("#mask").css({ display: 'none' });
			});
			//editGoodsBox的取消按钮
			$("#editGoodsBox button:first").click(function(){
					$("#editGoodsBox").fadeOut("fast");
					$("#mask").css({ display: 'none' });
			});
			//editGoodsBox的关闭
			$("#editGoodsBox .close_btn").hover(function () { $(this).css({ color: 'black' })}, function () { $(this).css({ color: '#999' }) }).on('click', function () {
					$("#editGoodsBox").fadeOut("fast");
					$("#mask").css({ display: 'none' });
			});
			//addGoodsSuccess的关闭
			$("#addGoodsSuccess .close_btn").hover(function () { $(this).css({ color: 'black' })}, function () { $(this).css({ color: '#999' }) }).on('click', function () {
				$("#addGoodsSuccess").fadeOut("fast");
				$("#mask").css({ display: 'none' });
				$("#name").val("");
				$("#type").val("");
				$("#price").val("");
				$("#measurement").val("");
				$("#stock").val("");
			});
			//editGoodsSuccess的关闭	
			$("#editGoodsSuccess .close_btn").hover(function () { $(this).css({ color: 'black' })}, function () { $(this).css({ color: '#999' }) }).on('click', function () {
				$("#editGoodsSuccess").fadeOut("fast");
				$("#mask").css({ display: 'none' });
				$("#editname").val("");
				$("#edittype").val("");
				$("#editprice").val("");
				$("#editmeasurement").val("");
				$("#editstock").val("");
			});	
			//下一页
            $("#next").click(function(){
         	 	page = page + 1;
         	 	$("table tr:first").siblings("tr").remove();
         	 	showPage(page);	
         	 }); 
         	//上一页
            $("#previous").click(function(){
         	 	if(page > 1){
         	 		page = page - 1;
         	 		$("table tr:first").siblings("tr").remove();
         	 		showPage(page);
         	 	}	
         	 });
         	//转到
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
         	 //查询
         	 $("#query").click(function(){
         	 	if($("#queryinput").val() == ""){
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
        <div class="goods_title">
            <p><img src="imgs/dw.png"><span style="margin-left: 10px;">商品管理</span></p>
        </div>
        <div class="goods_sel">
        	<div class="goods_sel_left">
                <button>添加</button>
        	</div>
        	<div class="goods_sel_right">
        		<input type="text" id="queryinput">
                <button id="query">查询</button>
        	</div>
        </div>           
        <div class="goods_tab">
         	<table class="goods_tt">
         		<tr><th>商品名称</th><th>商品类型</th><th>商品价格</th><th>计量单位</th><th>商品库存</th><th>保质期</th></tr>
                <div class="goods_tab_bottom">
                    <button id="previous">上一页</button>
                    <button id="next">下一页</button>
                    <input type="text" size=1 id="forwardinput">
                    <button id="forward">转到</button>
                </div>
         	</table>
        </div>  - 
        <div id="addGoodsBox">
       		<div class="row1">
        		添加商品<a href="javascript:void(0)" class="close_btn">×</a>
        	</div>
        	<div class="row">
           	 	商品名称<span><input type="text" id="name"/></span>&nbsp;&nbsp;
           	 	商品类别<span><input type="text" id="type"/></span> 
        	</div>
        	<div class="row">
            	商品价格<span><input type="text" id="price"/></span>&nbsp;&nbsp;
            	计量方式<span><input type="text" id="measurement"/></span>
        	</div>
        	<div class="row">
            	商品库存<span><input type="text" id="stock"/></span>
        	</div>
        	<div class="row">
            	保质期至<select id="year"></select>年<select id="month"></select>月<select id="day"></select>日
            	<input type="checkbox" id="hasDate" value="hasDate" style="vertical-align:middle;width:20px;"/>无
        	</div>
        	<div class="row">
        		<button>取消</button>
            	<button>保存</button>
        	</div>
       </div>
       <div id="addGoodsSuccess">
       		<div class="row1">
        		添加商品<a href="javascript:void(0)" class="close_btn">×</a>
        	</div>
        	<div class="row">
            	添加成功
        	</div>
       </div>
       <div id="editGoodsBox">
       		<div class="row1">
        		修改商品<a href="javascript:void(0)" class="close_btn">×</a>
        	</div>
        	<div class="row">
           	 	商品名称<span><input type="text" id="editname"/></span>&nbsp;&nbsp;
           	 	商品类别<span><input type="text" id="edittype"/></span> 
        	</div>
        	<div class="row">
            	商品价格<span><input type="text" id="editprice"/></span>&nbsp;&nbsp;
            	计量方式<span><input type="text" id="editmeasurement"/></span>
        	</div>
        	<div class="row">
            	商品库存<span><input type="text" id="editstock"/></span>
        	</div>
        	<div class="row">
            	保质期至<select id="edityear"></select>年<select id="editmonth"></select>月<select id="editday"></select>日
            	<input type="checkbox" id="edithasDate" value="hasDate" style="vertical-align:middle;width:20px;"/>无
        	</div>
        	<div class="row">
        		<button>取消</button>
            	<button>保存</button>
        	</div>
       </div>
       <div id="editGoodsSuccess">
       		<div class="row1">
        		修改商品<a href="javascript:void(0)" class="close_btn">×</a>
        	</div>
        	<div class="row">
            	修改成功
        	</div>
       </div>  
       <script id="container" name="content" type="text/plain"></script>
       <!-- 配置文件 -->
       <script type="text/javascript" charset="utf-8" src="uedit/ueditor.config.js"></script>
   	   <!-- 编辑器源码文件 -->
       <script type="text/javascript" charset="utf-8" src="uedit/ueditor.all.js"></script>
	   <!-- 实例化编辑器 -->
       <script type="text/javascript">
       		/* var ue = UE.getEditor("container"); */
       		/* ue.getContentTxt();  */	
       </script>
  </body>
</html>
