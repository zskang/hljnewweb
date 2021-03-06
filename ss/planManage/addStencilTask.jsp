<%@include file="/common/header.jsp"%>
<%@page import="com.cabletech.planinfo.services.*"%>
<%@page import="com.cabletech.baseinfo.domainobjects.UserInfo"%>
<%@page import="com.cabletech.commons.config.*"%>
<%
  	UserInfo userinfo = (UserInfo) session.getAttribute("LOGIN_USER");
  	String regionid = userinfo.getRegionID();
  	TaskBO taskbo = new TaskBO();
  	Vector vct = taskbo.getTaskOperations(regionid);
	//巡检点信息
  	Vector pointUnitsVct = new Vector();
  	String strsubline = (String)session.getAttribute("strsubline");
  	GisConInfo gisip = GisConInfo.newInstance();
%>
<SCRIPT language=javascript src="${ctx}/js/prototype.js" type=""></SCRIPT>
<script language="javascript">
var functionid = "1";
//是否选取了子任务
var ifCheckedFlag = 0;
var isCheckedPoint = 0;
//验证输入
function checkInput(){
    if(document.stencilTaskBean.description.value.length == 0){
        alert("请输入该任务名称！");
        document.stencilTaskBean.description.focus();
        return false;
    }
    if(document.stencilTaskBean.lineleveltext.value.length == 0){
        alert("请选择任务的线路级别！");
        document.taskBean.describtion.focus();
        return false;
    }
    if(ifCheckedFlag == 0){
        alert("请选择操作类型！");
        return false;
    }
	if(isCheckedPoint ==0){
		alert("请选择任务巡检点！");
        return false;
	}
    if(document.stencilTaskBean.excutetimes.value.length == 0){
        alert("请输入该巡检次数！");
        document.stencilTaskBean.excutetimes.focus();
        return false;
    }else{
		 var mysplit = /^\d{1,2}$/;
		 if(!mysplit.test(document.stencilTaskBean.excutetimes.value)){
            document.stencilTaskBean.excutetimes.value="";
        	alert("巡检次数只能是数字,且仅为整数,请重新输入");
        	return false;
        }
		 if(document.stencilTaskBean.excutetimes.value == 0){
			alert("巡检次数不能为0，只能大于等于1。");
			return false;
		 }
	}
	var subline = document.getElementById('sublineid').value;
	if(document.stencilTaskBean.typeCheck.length== undefined){
		var temp = document.stencilTaskBean.typeCheck.value;
				if(subline.indexOf(temp) != -1){
					alert("同一线段不能包含在多个子任务中!");
					return false;
				}
	}else{
		for(var j=0;j<document.stencilTaskBean.typeCheck.length;j++){
			if(document.stencilTaskBean.typeCheck[j].checked == true){
				var temp = document.stencilTaskBean.typeCheck[j].value;
				if(subline.indexOf(temp) != -1){
					alert("同一线段不能包含在多个子任务中!");
					return false;
				}
			}			
		}
	}
    return true;

}
//检验是否数字
function valiD(id){
	obj = document.getElementById(id);
    var mysplit = /^\d{1,2}$/;
    if(mysplit.test(obj.value)){
    	return true;
    }else{
    	obj.value="";
        alert("你填写的不是数字,请重新输入");
    }
}
//保存数据
function saveData(ss){
	if(document.stencilTaskBean.subtaskpoint==null){
		alert("该巡检员在此线路级别内没有负责的线段，请选择该巡检员对应的巡检线段的线路级别 ");
		return false;
	}
	ifCheckedFlag = 0;
	isCheckedPoint = 0;
  	for(var i = 0; i < document.stencilTaskBean.operationcheck.length; i ++){
       	if(document.stencilTaskBean.operationcheck[i].checked == true){
           	ifCheckedFlag++;
           	break;
        }
  	}
	if(!document.stencilTaskBean.subtaskpoint.length && document.stencilTaskBean.subtaskpoint.checked){
    	isCheckedPoint++;
   	}else{
		for(var j=0;j<document.stencilTaskBean.subtaskpoint.length;j++){
			if(document.stencilTaskBean.subtaskpoint[j].checked == true){
				isCheckedPoint++;
				break;
            }
		}
	}
    var k = document.stencilTaskBean.linelevel.selectedIndex;
    var levelText = document.stencilTaskBean.linelevel[k].text;
	
    document.stencilTaskBean.lineleveltext.value = levelText;
	if(ss=='1'){
		document.getElementById('SS').value ="1";
	}else{
		document.getElementById('SS').value="0";
	}

    if(checkInput()){
        document.stencilTaskBean.submit();
    }
}
//设置任务名称
function setTaskName(objN,name){
    var tempValue = "";
    var operationSize = 0;
    for(var i = 0; i < document.stencilTaskBean.operationcheck.length; i ++){
	    if(document.stencilTaskBean.operationcheck[i].checked == true){
    		document.stencilTaskBean.description.value = document.stencilTaskBean.operationname[i].value;
            operationSize++;
        }
    }
    if(operationSize > 1){
    	document.stencilTaskBean.description.value = "综合维护任务";
    }
}

getSameLevelPoints = function(){
	var url = "${ctx}/StencilTaskAction.do?method=getTaskPatrolPoint&linelevel="+document.stencilTaskBean.linelevel.value+"&fId=2";
	var ajax = new Ajax.Request(
		url,{
        	method:'post',
        	onLoading:function(){
        		document.getElementById('TaskSublines').innerHTML = "<img src='images/indicator.gif'/>正在加载,请稍候.."; 
        	},
        	onSuccess:function(transport){
        		document.getElementById('TaskSublines').innerHTML = transport.responseText;
        	},
        	onFailure: function(){ alert('请求服务异常...'); }
        }
	);
};
/*
function getSameLevelPoints(){
	var pageName = "${ctx}/StencilTaskAction.do?method=getTaskPatrolPoint&fId=2&linelevel=" + document.stencilTaskBean.linelevel.value;
	location.href = pageName;
}*/

function goBack(){
	var url = "${ctx}/planManage/showStencil.jsp";
	self.location.replace(url);
}
function open_map(ID,FORMAT){
	URL="http://<%=gisip.getServerip()%>:<%=gisip.getServerport()%>/WEBGIS/gisextend/igis.jsp?actiontype=003&lineid="+ID;
 	myleft=(screen.availWidth-650)/2;
 	mytop=100;
 	mywidth=650;
 	myheight=500;
 	if(FORMAT=="1"){
    	myleft=0;
    	mytop=0;
    	mywidth=screen.availWidth-10;
    	myheight=screen.availHeight-40;
 	}
	window.open(URL,"","height="+myheight+",width="+mywidth+",status=1,toolbar=no,resizable=no,menubar=no,location=no,scrollbars=yes,top="+mytop+",left="+myleft);
}
//选择父节点下的所有孩子
var singledouble=0;
function setSon(objN){
	var v = objN.value;
	var objP = document.getElementsByName("subtaskpoint");
	var tr_id = "detailTr_"+objN.value;
	var objPointid;
	var groupBysublinetr=document.getElementById(tr_id).getElementsByTagName("input");
	var prefix = "point_"+v;
	var len = groupBysublinetr.length-1;
	do{
		if(singledouble==0){
			groupBysublinetr[len].checked = objN.checked;
		}else{
			if(len%2==0 && singledouble==2){//双数
				groupBysublinetr[len].checked = objN.checked;
			}
			if(len%2==1 && singledouble==1){//单数
				groupBysublinetr[len].checked = objN.checked;
			}
		}
	}while(--len>=0);
}

//设置父节点是否选中
//存在问题，选择一条时父节点同时取消。
function setParent(objN,v){
	var objC = document.getElementsByName('typeCheck');
	if(objC.length == undefined){
		objC.checked = true;
	}else{
		for(var i=0;i<objC.length;i++){
			if(objC[i].value==v){
				objC[i].checked = objN.checked;	
			}
		}
	}
}
//显示隐藏子节点
function showHideSubTr(objN,sublineid){
	var tr_id='detailTr_'+sublineid;
	var i = objN.index;
	try{
		if(document.getElementById(tr_id)[i].style.display == ""){
			document.getElementById(tr_id)[i].style.display = "none";
		}else{
			document.getElementById(tr_id)[i].style.display = "";
		}
	}catch (e) {
		if(document.getElementById(tr_id).style.display == ""){
			document.getElementById(tr_id).style.display = "none";
		}else{
			document.getElementById(tr_id).style.display = "";
		}
	}
	
}
//全选，不全选
function checkAll(val,sindou){
	singledouble = sindou;
	var objC = document.getElementsByName('typeCheck');
	if(objC != undefined){
		if(objC.length == undefined){
			objC.checked = val;
			setSon(objC);
		}else{
			for(var i=0;i<objC.length;i++){
				objC[i].checked = val;
				setSon(objC[i]);
			}
		}
	}
}
var sd = 0;
//单双数选择
function checksinge(s){
	checkAll(false,0);
	if(sd==s){
		sd=0;
		checkAll(true,2);
		document.getElementById("singledouble").value="选择双数"
	}else{
		sd = s;
		checkAll(true,1);
		document.getElementById("singledouble").value="选择单数"
	}
}
</script>
	<body >
<template:titile value="增加计划模板"/>
	<html:form action="/StencilTaskAction?method=addStencilTask">
	<input name="ss" type="hidden" id ="SS" value="0"><!-- 0代表继续下一步 1代表完成 -->
  	<input name="strsubline" id="sublineid" value="<%=strsubline%>" type="hidden"/>
  	<template:formTable contentwidth="450" namewidth="150">
    <template:formTr name="任务名称">
      <html:text property="description" styleClass="inputtext" maxlength="20" style="width:200px"/>
    </template:formTr>

    <template:formTr name="对应线路级别" isOdd="false">
    <html:hidden property="lineleveltext" />
    <apptag:setSelectOptions columnName1="name" columnName2="code" tableName="lineclassdic" valueName="linetypeColl" order="code"/>
      <html:select property="linelevel" styleClass="inputtext" style="width:200px" onchange="getSameLevelPoints()">
      	<option value="">请选择线路级别</option>
        <html:options collection="linetypeColl" property="value" labelProperty="label"/>
      </html:select>
    </template:formTr>
	 <template:formTr name="估算点数">
    	 <html:text property="evaluatepoint" styleClass="inputtext"  onkeyup="value=value.replace(/[^\d{2,5}]/g,'')" maxlength="5" style="width:200px"></html:text>
    </template:formTr>
    <template:formTr name="任务巡检点" isOdd="false">
		 <div width="100%">
	    	<input type="button" id="uncheckall" onClick="checkAll(false,0)" value="全不选"> 
	    	<input type="button" id="checkall" onClick="checkAll(true,0)" value="全选"> 
	    	<input type="button" id="singledouble" onClick="checksinge(1)" value="单/双数选择"> 
	    </div>
		<div id="TaskSublines" width="100%">
    	<%=request.getAttribute("tasksublineHtm") %>
    	</div>
    </template:formTr>
    <template:formTr name="巡检次数" >
    <div style="color:red">巡检次数表示您将要对以上选择线段巡检点的巡检次数</div>
      <html:text property="excutetimes"  styleId="exID" onblur="valiD(id)" value="1" maxlength="2" styleClass="inputtext" style="width:200px"/>
      <input type="text" class="inputtext" style="border:0;background-color:transparent;width:30px" value="次" readonly>
    </template:formTr>
    
    <template:formTr name="操作类型" isOdd="false">
    <div style="color:red">以下选项为巡检人员到达巡检点时可能要做的操作（仅供参考）</div>
    <%
      if (vct.size() > 0) {
        out.println("<table border=\"0\" cellspacing=\"0\" cellpadding=\"5\">");
        for (int i = 0; i < vct.size(); i++) {
          Vector oneRecord = (Vector) vct.get(i);
          String id = (String) oneRecord.get(0);
          String name = (String) oneRecord.get(1);
          out.println("<tr valign=\"middle\"> ");
          out.println("	<td>           ");
          out.println("		<input type=\"checkbox\" name=\"operationcheck\" value=\"" + id + "\" onclick=setTaskName(this,'"+ name +"')>  ");
          out.println("	</td>     ");
          out.println("	<td>  ");
          out.println("		<input type=\"text\" name=\"operationname\" class=\"inputtext\" style=\"border:0;background-color:transparent;width:80\" value=\"" + name + "\" hiddenValue=\"" + id + "\" readonly>");
          out.println("	</td>  ");
          out.println("</tr>   ");
        }
        out.println("</table>");
      }
    %>
    </template:formTr>
    <template:formSubmit>
      <td titile="继续进行添加操作">
        <html:button property="action" styleClass="button" onclick="saveData(0)">继续</html:button>
      </td>
      <td titile="完成添加操作，到计划模板结果页面">
        <html:button property="action" styleClass="button" onclick="saveData(1)">完成</html:button>
      </td>
      <td titile="取消本次添加操作，到计划模板结果页面">
      <html:button property="action" styleClass="button" onclick="goBack()">取消</html:button>
      </td>
    </template:formSubmit>
  </template:formTable>
</html:form>

</body>
<iframe id="hiddenIframe" style="display:none"></iframe>
