<%@ page contentType="text/html; charset=GBK" %>
<%
String regionid = request.getParameter("regionid");
%>
<html>
<head>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=gb2312">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title>�ƶ�������·Ѳ�����ϵͳ</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
</head>

<body>
<TABLE class=borderon id=control cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
    <TR>
      <td>
        <table border="0" cellspacing="0" cellpadding="0">
          <tr align="center">
          <td width=100 class="lbutton"  style="cursor:hand"><a href="${ctx}/accidentAction.do?method=loadAllAccident&regionid=<%=regionid%>" target="iframemain"> �ϰ���ѯ�б�</a></td>
            <td width=100 class="lbutton"  style="cursor:hand"><a href="${ctx}/accidentAction.do?method=loadUndoenAccident&regionid=<%=regionid%>" target="iframemain"> �������ϰ�</a></td>
            <td width=100 class="lbutton"  style="cursor:hand"><a href="${ctx}/accidentAction.do?method=loadAllDoingAccident&regionid=<%=regionid%>" target="iframemain"> �����ϰ�</a></td>
            <td width=100 class="lbutton"  style="cursor:hand"> <a href="queryAccident.jsp?regionid=<%=regionid%>" target="iframemain"> �ϰ�������ѯ</a> </td>
            <!-- <td width=100 class="lbutton"  style="cursor:hand"> <a href="queryPatrolOp.jsp" target="iframemain"> ���ϴ���ͳ��</a> </td> -->
          </tr>
      </table></td>
    </TR>
   <tr>
    <td height="2" background="../images/bg_line.gif"><img src="../images/1px.gif" width="1" height="1"></td>
  </tr>
  </TBODY>
</TABLE>
<TABLE width="100%" height="100%" border=0 cellPadding=0 cellSpacing=0 class=borderon id=control>
  <TR>
    <TD>
      <DIV id=iframexxx >
        <IFRAME name=iframemain
            marginWidth=0 marginHeight=0 src="${ctx}/accidentAction.do?method=loadAllAccident&regionid=<%=regionid%>" frameBorder=0 width="100%" scrolling=YES height="95%"></IFRAME>
    </DIV></TD>
  </TR>
</TABLE>
</body>
</html>