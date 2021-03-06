<%@ page language="java" contentType="text/html; charset=GBK"%><%@ include file="/common/header.jsp"%>
<%@ page import = "com.cabletech.baseinfo.beans.*" %>
<link rel="stylesheet" href="${ctx}/css/screen.css" type="text/css" media="screen, print" />
<%
	UseTerminalBean useTerminal = (UseTerminalBean)session.getAttribute("query");
 %>
<template:titile value="${sessionScope.query.year}年${sessionScope.query.month}月份设备使用情况" />
<display:table name="sessionScope.useterminal"   id="currentRowObject"  pagesize="18">
     <display:column property="simid" title="sim卡" sortable="true"/>
     <display:column property="regionname" title="地区" />
	 <display:column property="contractorname" maxLength="8" title="代维公司" />
	  <display:column property="patrolname" maxLength="4" title="巡检组" />
	  <display:column property="totalnum" title="短信总数" />
	  <display:column property="monthlykm" title="巡检里程KM"/> 
	 <display:column property="onlinedays" title="在线天数"/> 
	 <display:column property="patrolnum" title="巡检" />
	 <display:column property="watchnum" title="盯防"  />
	 <display:column property="collectnum" title="采集" /> 
	 <display:column property="troublenum" title="隐患"  /> 
	 <display:column property="othernum" title="其它"/> 
</display:table>
<%
	String section = (String)session.getAttribute("section");
	if(section != null && !"".equals(section)){
%>
	<div align="center"><INPUT type="button" value="返回" name="返回" onclick="javascript:self.location.replace('${ctx}/baseinfo/useTerminalChart.jsp');"/></div>
<%
	}
%>
