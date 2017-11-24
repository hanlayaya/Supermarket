<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>summary</title>
     <link rel="stylesheet" href="css/summary.css">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript" src="script/echarts.js"></script>
	<script type="text/javascript" src="script/jquery-3.2.1.js"></script>
  </head>
  <body>
  	 <div class="employee_title">
        <p><img src="imgs/dw.png"><span style="margin-left: 10px;">销售总览</span></p>
    </div>
  	<div class="fifth_wrap">
  		<div id="ring"></div>
	    <div id="line"></div>
  	</div>	
	    
    <script type="text/javascript">
    	var ring = echarts.init(document.getElementById('ring'));
    	var ringdata = [];
    	$.ajax({
    		async: false,
    		type:'GET',
    		url:'EchartsServlet',
    		dataType:'json',
    		success:function(data){
    			for(var i = 0;i < data.length;i++){
    				ringdata.push(data[i])
    			}
    		}
    	});
	  	option = {
    		tooltip: {
        		trigger: 'item',//触发时显示相关数据
        		formatter: "{a} <br/>{b}: {c} ({d}%)"
    		},
    		legend: {
        		//orient: 'vertical' 默认为水平布局(horizontal)
        		orient: 'horizontal',
       	    	//x: 'left',
        		data:['食品类','洗护类','粮油类','生活用品类','其他']
    	    },
    		series: [{
            	name:'商品类别',
            	type:'pie',
           	    radius: ['50%', '70%'],
            	avoidLabelOverlap: false,
            	label: {
                	normal: {
                    	show: false,
                    	position: 'center'
                	},
               	    emphasis: {
                    	show: true,
                    	textStyle: {
                        	fontSize: '30',
                        	fontWeight: 'bold'
                   		 }
                	}
            	},
                labelLine: {
                	normal: {
                    	show: false
                	}
            	},
            	data:[
                	{value:ringdata[0], name:'食品类'},
                	{value:ringdata[1], name:'洗护类'},
                	{value:ringdata[2], name:'粮油类'},
                	{value:ringdata[3], name:'生活用品类'},
                	{value:ringdata[4], name:'其他'}
            	]
        	}] 
		};
		ring.setOption(option);

		var line = echarts.init(document.getElementById('line'));	
   		var linedata = [];
    	$.ajax({
    		async: false,
    		type:'POST',
    		url:'EchartsServlet',
    		dataType:'json',
    		success:function(data){
    			for(var i = 0;i < data.length;i++){
    				linedata.push(data[i])
    			}
    		}
    	});	
		option = {
    		title: {
      			text: '过去一周销售额变化',
    		},
    		tooltip: {
        		trigger: 'axis'
    		},
    		legend: {
        		data:['销售','盈利']
    		},
    		toolbox: {
        		show: true,
        		feature: {
            		dataView: {readOnly: false},//是否不可编辑
            		magicType: {type: ['bar']},
            		restore: {},//配置项还原
            		saveAsImage: {}//保存表的图片
        		}
    		},
   	  		xAxis:  {
        		type: 'category',
        		boundaryGap: false,
        		data: ['--','--','--','前天','昨天','今天']
    		},
    		yAxis: {
        		type: 'value',
        		axisLabel: {
            		formatter: '{value} ￥'
        		}
    		},
    		series: [{
            	name:'销售',
            	type:'line',
            	data:[linedata[6],linedata[5],linedata[4],linedata[3],linedata[2],linedata[1]],
            	markPoint: {
                	data: [
                    	{type: 'max', name: '最大值'},
                    	{type: 'min', name: '最小值'}
                	]
            	},
            	markLine: {
                	data: [
                    	{type: 'average', name: '平均值'}
                	]
            	}
        	},
        	{
            	name:'盈利',
            	type:'line',
            	data:[0, 0, 0, 500, 30, 20],
            	markPoint: {
                	data: [
                    	{name: '周最低', value: -2, xAxis: 1, yAxis: -1.5}
                	]
            	},
            	markLine: {
                	data: [
                    	{type: 'average', name: '平均值'},
                    	[{
                        	symbol: 'none',
                        	x: '90%',
                        	yAxis: 'max'
                    	}, {
                        	symbol: 'circle',
                        	label: {
                            	normal: {
                                	position: 'start',
                                	formatter: '最大值'
                            	}
                        	},
                        	type: 'max',
                        	name: '最高点'
                    	}]
                	]
            	}
        	}] 
      	};
      	line.setOption(option);	
    </script>
  </body>
</html>
