<%@include file="/common/header.jsp"%>
<html>
	<script type="text/javascript" src="js/prototype.js"></script>
	<script type="text/javascript">
	
	addGoBackMod=function() {
		//var url = "${ctx}/SparepartApplyAction.do?method=listWaitAuditingApplyForAu";
		//self.location.replace(url);
		history.back();
	}
	showHistoryDetail=function(value){
		var actionUrl="${ctx}/SparepartAuditingAction.do?method=listAuditingApplyHistory&apply_id="+value+"&rnd="+Math.random();
		var myAjax=new Ajax.Updater(
			"applyAuditingTd",actionUrl,{
			method:"post",
			evalScript:true
			}
		);
	}
	</script>
	<body>
		<br>
		<template:titile value="�鿴����Ѳ��ά���鱸������" />
			<template:formTable namewidth="150" contentwidth="350">
				<template:formTr name="��������">
					<bean:write name="one_apply" property="sparePartName" />
				</template:formTr>
				<template:formTr name="����Ѳ��ά����">
					<bean:write name="one_apply" property="patrolgroupName" />
				</template:formTr>
				<template:formTr name="�������к�">
					<logic:iterate id="item" name="applySs">			            
			            <bean:write name="item" property="serialNumber"/><br>
					 </logic:iterate>
				</template:formTr>				
				<template:formTr name="ʹ�÷�ʽ">
					<logic:equal value="01" name="one_apply" property="useMode">
						ֱ��ʹ��
					</logic:equal>
					<logic:equal value="02" name="one_apply" property="useMode">
						����ʹ��
					</logic:equal>
				</template:formTr>
				<logic:equal value="02" name="one_apply" property="useMode">
					<template:formTr name="��������">
						<logic:equal value="01" name="one_apply" property="replaceType">
							�˻��ɱ���
						</logic:equal>
						<logic:equal value="02" name="one_apply" property="replaceType">
							���޾ɱ���
						</logic:equal>
						<logic:equal value="03" name="one_apply" property="replaceType">
							���Ͼɱ���
						</logic:equal>
					</template:formTr>					
					<template:formTr name="�������������к�">
						<logic:iterate id="item" name="applySs">			            
				            <bean:write name="item" property="usedSerialNumber"/><br>
						</logic:iterate>
					</template:formTr>
				</logic:equal>				
				<template:formTr name="����ʹ��λ��">
					<bean:write name="one_apply" property="applyUsePosition" />
				</template:formTr>
				<template:formTr name="������">
					<bean:write name="one_apply" property="applyPerson" />
				</template:formTr>
				<template:formTr name="���뱸ע">
					<bean:write name="one_apply" property="applyRemark" />
				</template:formTr>
				<logic:notEqual value="" property="auditingResult" name="auditing">
				<template:formTr name="��˽��">
					<bean:write name="auditing" property="auditingResult" />
				</template:formTr>
				<template:formTr name="��˱�ע">
					<bean:write name="auditing" property="auditingRemark" />
				</template:formTr>
				</logic:notEqual>
				<table width="500" border="0" align="center" cellpadding="0" cellspacing="0">
					<tr>
						<td align="center" id="applyAuditingTd"></td>
					</tr>
				</table>
				
				<template:formSubmit>
					<td id="applyAuditingTd"></td>
				</template:formSubmit>

				<template:formSubmit>
					<td>
						
					<input type="button" class="button" value="����" onclick="location.replace('<%=session.getAttribute("S_BACK_URL")%>')"/>
					
					</td>
				</template:formSubmit>
			</template:formTable>
			<script type="text/javascript">
				//showHistoryDetail("<bean:write name="one_apply" property="tid" />");
			</script>
	</body>
</html>