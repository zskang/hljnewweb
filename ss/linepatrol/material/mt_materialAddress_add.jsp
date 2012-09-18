<%@include file="/common/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<jsp:useBean id="statdao" class="com.cabletech.statistics.dao.StatDao" scope="request"/>

<script type="text/javascript"
			src="${ctx}/js/validate.js"></script>
<script language="javascript">
function downloadFile() {
  location.href = "${ctx}/CableAction.do?method=downloadTemplet";
}

function showupload() {
    var objpart = document.getElementById("groupDivId");
    var objup = document.getElementById("upDivId");
    objpart.style.display="none";
    objup.style.display="block";
}

function noupload()
{
    var objpart = document.getElementById("groupDivId");
    var objup = document.getElementById("upDivId");

    objpart.style.display="block";
    objup.style.display="none";
}

function isValidForm() {
    var myform = document.forms[0];
    var length = myform.remark.value.getGBLength();
    if(myform.address.value==''){
       alert('���ϴ�ŵص㲻��Ϊ�գ�');
     myform.address.focus();
        return false;
    }
if(jQuery.trim(myform.address.value)==""){
		alert("���ϴ�ŵص㲻��Ϊ�ո�!! ");
        myform.address.focus();
		return false;
	}
if(length>1024){
		alert("��ע�������512�����ֻ���1024���ַ���");
		myform.remark.focus();
		return false;
}
processBar(materialAddrBean);
	return true;
}
</script>

<body>
 <div id="groupDivId">
<template:titile value="���Ӳ��ϴ�ŵص���Ϣ"/>

<html:form onsubmit="return isValidForm()" method="Post" action="/MTAddressAction.do?method=addAddress" styleId="materialAddrBean">
  <template:formTable contentwidth="400" namewidth="100">
    <template:formTr name="��ŵص�">
      <html:text property="address" styleClass="inputtext" style="width:205px" maxlength="200"/>
    </template:formTr>
      <template:formTr name="��ά��λ" isOdd="false">
        <html:select property="contractorid" styleClass="inputtext" style="width:205px">
          <html:options collection="deptCollection" property="value" labelProperty="label"/>
        </html:select>
      </template:formTr>
   
    <template:formTr name="��ע">
      <html:textarea property="remark" styleClass="inputtext" style="width:255px;height:100px;" cols="10" rows="10"/>
    </template:formTr>
    <template:formSubmit>
      <td>
        <html:submit styleClass="button">����</html:submit>
      </td>
      <td>
        <html:reset styleClass="button">����</html:reset>
      </td>
      </template:formSubmit>
      </template:formTable>
      </html:form>