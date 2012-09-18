<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@include file="/common/header.jsp"%>
<script type="text/javascript"
	src="${ctx}/sendtask/js/sendtask-common.js"></script>
<html>
	<head>
		<title>sendtask</title>
		<script type="text/javascript" src="/WebApp/js/prototype.js"></script>
		<script type="" language="javascript">
		var contextPath="${ctx}";
		function validate(){
			var formElements=addApplyForm.elements;
			if(judgeEmptyString(formElements["sendTaskReply.replyresult"].value)){
				alert("�ظ����ݲ���Ϊ�գ�");
				return false;
			}
			if(valCharLength(formElements["sendTaskReply.replyresult"].value)>1020){
				alert("�ظ���������̫�࣡���ܳ���510������");
				return false;
			}
			var allCheck = document.getElementsByName('ifCheck');
			var length = allCheck.length;
			for(var i = 0; i < length; i++) {
				//var index = i + 1;
				var index = allCheck[i].value;
				var pathText = document.getElementById('uploadFile[' + index + '].file');
				var path = pathText.value;
				if(path.length == 0) {
					alert("��ѡ��Ҫ�ϴ��ĸ�����·����\n���û��Ҫ�ϴ��ĸ�����ɾ��!");
					pathText.focus();
					return false;
				}
			}
			return true;
		}
		</script>
	</head>
	<body>
		<!--�����ɵ�-->
		<br>
		<template:titile value="�ɵ��ظ�" />
		<s:form action="sendTaskReplyAction_save" name="addApplyForm"
			onsubmit="return validate();" enctype="multipart/form-data">
			<input name="sendTaskReply.taskId" value="${sendTaskReply.taskId}"
				type="hidden" />
			<input type="hidden" name="sendTaskReply.sendtaskid" value="${id}" />
			<input type="hidden" name="sendTaskReply.transition" value="pass" />
			<input type="hidden" name="sendTaskReply.id"
				value="${sendTaskReply.id }" />
			<input type="hidden" name="sendTaskReply.actiontype" value="REPLY" />
			<table width="90%" border="0" align="center" cellpadding="3"
				cellspacing="0" class="tabout">
				<tr class=trcolor>
					<td class="tdr" width="15%">
						�������
					</td>
					<td class="tdl" width="35%">
						<apptag:quickLoadList cssClass="" name="" listName="dispatch_task"
							keyValue="${sendTask.sendtype}" type="look" isRegion="false"></apptag:quickLoadList>
					</td>
					<td class="tdr">
						�ɵ�ʱ�䣺
					</td>
					<td class="tdl">
						${sendTask.sendtime }
					</td>
				</tr>
				<tr class=trcolor>
					<td class="tdr">
						�ɵ����ţ�
					</td>
					<td class="tdl">
						${sendTask.sendorgname }
					</td>
					<td class="tdr">
						�� �� �ˣ�
					</td>
					<td class="tdl">
						${sendTask.sendusername }
					</td>
				</tr>
				<tr class=trcolor>
					<td class="tdr">
						�������ţ�
					</td>
					<td class="tdl">
						${sendTask.acceptorgname }
					</td>
					<td class="tdr">
						�����ˣ�
					</td>
					<td class="tdl">
						${sendTask.acceptusername }
					</td>
				</tr>
				<tr class=trcolor>
					<td class="tdr">
						�������⣺
					</td>
					<td class="tdl" colspan="3">
						${sendTask.sendtopic }
					</td>
				</tr>
				<tr class=trcolor>
					<td class="tdr">
						����˵����
					</td>
					<td class="tdl" colspan="3">
						${sendTask.sendtext }
					</td>
				</tr>
				<tr class=trcolor>
					<td class="tdr">
						����ʱ�ޣ�
					</td>
					<td class="tdl" colspan="3">
						${processterm }
					</td>
				</tr>
				<tr class=trcolor>
					<td class="tdr">
						���񸽼���
					</td>
					<td class="tdl" colspan="3">
						<apptag:upload cssClass="" entityId="${sendTask.id}"
							entityType="COMMON_SENDTASK" state="look" />
					</td>
				</tr>
				<tr class=trcolor>
					<td class="tdc" colspan="4" id="processHistoryTd"
						style="padding: 5px;">
					</td>
				</tr>
				<tr class=trcolor>
					<td class="tdr">
						�ظ����ݣ�
					</td>
					<td class="tdl" colspan="3">
						<input name="sendTaskReply.replyuserid"
							value="${LOGIN_USER.userID }" type="hidden" />
						<textarea name="sendTaskReply.replyresult" title="�ظ������510�����֣�"
							style="width: 82%" rows="5" class="textarea"></textarea>
					</td>
				</tr>
				<tr class=trcolor>
					<td class="tdr">
						�ظ�������
					</td>
					<td class="tdl" colspan="3">
						<apptag:upload cssClass="" entityId=""
							entityType="COMMON_SENDTASKREPLY" state="add" />
					</td>
				</tr>
			</table>
			<table align="center">
				<tr>
					<td>
						<input type="submit" value="�ظ�" class="button">
					</td>
					<td>
						<input type="reset" value="����" class="button">
					</td>
					<td>
						<input type="button" value="����" class="button" onclick="goBack()">
					</td>
				</tr>
			</table>
		</s:form>
		<script type="text/javascript">
		showProcessHistory('${sendTask.id}');
		</script>
	</body>
</html>