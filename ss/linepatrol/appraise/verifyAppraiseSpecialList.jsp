<%@include file="/common/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	<title>���˽��ȷ��</title>
	</head>
	<link rel="stylesheet" href="${ctx}/css/screen.css" type="text/css" media="screen, print"/>
	<script type="text/javascript">
		function verify(id) {
		window.location.href="${ctx}/appraiseSpecialAction.do?method=viewAppraiseMonth&flag=verify&resultId="+id;
	}
	</script>
	<body>
		<template:titile value="���˽��ȷ��" />
			<display:table name="sessionScope.appraiseResults" id="appraiseResults" pagesize="18" export="false" defaultsort="1" defaultorder="descending" sort="list"	>
				<logic:notEmpty name="appraiseResults">
				<display:column media="html" title="��ά��˾" sortable="true" >
					 	<c:out value="${contractor[appraiseResults.contractorId]}"></c:out>
					 </display:column>
				<display:column property="startDate" sortable="true" format="{0,date,yyyy-MM-dd}"
					title="���˿�ʼʱ��" />
				<display:column property="endDate" sortable="true" format="{0,date,yyyy-MM-dd}"
					title="���˽���ʱ��" />
				<display:column property="result" sortable="true" title="���˽��"
					 maxLength="18" />
				<display:column property="appraiser" title="������"
					 sortable="true" />
				<display:column media="html" title="����">
					<a href="javascript:verify('${appraiseResults.id}');">ȷ��</a>
				</display:column>
				</logic:notEmpty>
			</display:table>
			<table border="0" cellpadding="0" cellspacing="0" width="100%"
				style="border: 0px">
				<tr>
					<td style="text-align: center;">
						<input name="action" class="button" value="����" onclick="history.back();"
							type="button" />
					</td>
				</tr>
			</table>
	</body>
</html>