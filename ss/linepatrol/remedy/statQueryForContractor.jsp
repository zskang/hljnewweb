<%@include file="/common/header.jsp"%>
<html>
	<script type="text/javascript"
		src="${ctx}/js/WdatePicker/WdatePicker.js"></script>
	<link type="text/css" rel="stylesheet"
		href="${ctx}/js/WdatePicker/skin/WdatePicker.css">
	<head>
		<script language="javascript" type="">
       			function addGoBack(){
   			location.href = "${ctx}/stataction.do?method=loadQueryForm";
    			return true;
			}
			function checkForm(){
				var month = document.getElementById("month");
				if(month.value == ""){
					alert("��ѡ���·�!");
					month.focus();
					return false;
				}
				return true;
			}
		</script>
	</head>
	<body>
		<template:titile value="��ѯͳ��" />
		<html:form method="Post"
			action="/statRemedyAction.do?method=statRemedyForContractor"
			onsubmit="return checkForm();">
			<template:formTable contentwidth="200" namewidth="200">
				<template:formTr name="�·�<font color='red'>*</font>">
					<input name="month" id="month" class="Wdate inputtext"
						style="width: 160" onfocus="WdatePicker({dateFmt:'yyyy-MM'})"
						readonly />
				</template:formTr>

				<template:formSubmit>
					<td>
						<html:submit styleClass="button">��ѯ</html:submit>
					</td>
					<td>
						<html:reset styleClass="button">����</html:reset>
					</td>
				</template:formSubmit>

			</template:formTable>
		</html:form>
	</body>