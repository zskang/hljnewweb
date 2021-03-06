package com.cabletech.linepatrol.material.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.springframework.web.context.WebApplicationContext;

import com.cabletech.baseinfo.action.BaseInfoBaseDispatchAction;
import com.cabletech.baseinfo.domainobjects.UserInfo;
import com.cabletech.baseinfo.services.ExportBO;
import com.cabletech.linepatrol.material.service.MonthStatBo;


/**
 * 材料月统计
 * @author cable
 *
 */
public class MonthStateAction extends BaseInfoBaseDispatchAction{
	Logger logger = Logger.getLogger(this.getClass().getName());
	private MonthStatBo getMonthStatService(){
		WebApplicationContext ctx = getWebApplicationContext();
		return (MonthStatBo)ctx.getBean("monthStatBo");
	}
	
	/**
	 * 转到月统计页面
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	public ActionForward MonthStateForm(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response){
		UserInfo user = (UserInfo) request.getSession().getAttribute("LOGIN_USER");
		String deptype = user.getDeptype();
		if(deptype.equals("1")){//移动
			List cons = getMonthStatService().getConsByDeptId(user);
			request.setAttribute("cons",cons);
		}
		return mapping.findForward("monthstatform");
	}
	/**
	 * 转到月统计列表页面
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward statMonth(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		MonthStatBo monthStatBo = getMonthStatService();
		String month = request.getParameter("Month");
		String contractorid = request.getParameter("contractorid");
		UserInfo user = (UserInfo) request.getSession().getAttribute("LOGIN_USER");
		String deptype = user.getDeptype();
		if(deptype.equals("2")){
			contractorid = user.getDeptID();
		}
		List baseInfo = monthStatBo.getBaseInfo(month, contractorid);
		List Intendance = monthStatBo.getIntendance(month, contractorid);
		List RegionPrincipal = monthStatBo.getRegionPrincipal(month, contractorid);
		List MaterialName = monthStatBo.getMaterialName(month, contractorid);
		List MaterialCount = monthStatBo.getMaterialInfo(month, contractorid);
		request.getSession().setAttribute("baseInfo", baseInfo);
		request.getSession().setAttribute("Intendance", Intendance);
		request.getSession().setAttribute("RegionPrincipal", RegionPrincipal);
		request.getSession().setAttribute("MaterialName", MaterialName);
		request.getSession().setAttribute("MaterialCount", MaterialCount);
		return mapping.findForward("monthstatlist");
	}
	/**
	 * 导出材料信息
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	public ActionForward exportMaterialMonthStat(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) {
		ExportBO export = new ExportBO();
		try {
			logger.info(" 创建dao");
			List baseInfo = (List) request.getSession().getAttribute("baseInfo");
			List Intendance = (List) request.getSession().getAttribute("Intendance");
			List RegionPrincipal = (List) request.getSession().getAttribute("RegionPrincipal");
			List MaterialName = (List) request.getSession().getAttribute("MaterialName");
			List MaterialCount = (List) request.getSession().getAttribute("MaterialCount");
			logger.info("得到list");
			export.exportMaterialMonthStat( baseInfo,Intendance,RegionPrincipal,MaterialName,MaterialCount, response);
			logger.info("输出excel成功");
			return null;
		} catch (Exception e) {
			logger.error("导出信息报表出现异常:" + e.getMessage());
			return forwardErrorPage(mapping, request, "error");
		}
	}
}
