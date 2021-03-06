package com.cabletech.planstat.util;

import java.awt.Color;
import java.awt.Font;
import java.awt.GradientPaint;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.beanutils.BasicDynaBean;
import org.apache.log4j.Logger;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.AxisLocation;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.renderer.category.LayeredBarRenderer;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.util.SortOrder;


public class ShowComCompHChart extends HttpServlet{
	private Logger logger = Logger.getLogger("ShowComCompHChart") ;
	public void service( ServletRequest req, ServletResponse res ) throws
    ServletException, IOException{
		 List list = (List)((HttpServletRequest)req).getSession().getAttribute("comCompHInfo");
		 String theYearMonth = (String)((HttpServletRequest)req).getSession().getAttribute("YMForComComp");
		 String title = "代维公司" + theYearMonth + "横向对比分析";
		 String name = null;
		 name = "代维公司名称";
		 res.setContentType( "image/jpeg" );
		 JFreeChart jfreechart = null;
		 if(!list.isEmpty()){
			 logger.info("list is not empty");
		     jfreechart = createChart(getDataSet(list),title,name);  
		 }else{
			 logger.info("list is empty");
		 }
		 int width = 700;
         int height = 500;
         Font font = new Font( "黑体", Font.CENTER_BASELINE, 12 );
         ChartUtilities.writeChartAsJPEG( res.getOutputStream(),1.0f, jfreechart, width, height, null );
	}
	
	private  CategoryDataset getDataSet(List list){
		DefaultCategoryDataset mydataset= new DefaultCategoryDataset();
		 if (!list.isEmpty()){
		    String stractual = "实际巡检点次";
			String strplan = "计划巡检点次";
			for ( int i = 0;i<list.size();i++){
				mydataset.addValue(Integer.parseInt(((BasicDynaBean)list.get(i)).get("factpoint").toString()), stractual,((BasicDynaBean)list.get(i)).get("contractorname").toString());
				mydataset.addValue(Integer.parseInt(((BasicDynaBean)list.get(i)).get("planpoint").toString()), strplan,((BasicDynaBean)list.get(i)).get("contractorname").toString());				
			}
			return mydataset;
		 }
		 logger.info("list is null");
		 return mydataset;
	 }
	
	private static JFreeChart createChart(CategoryDataset categorydataset,String title,String name) {
		
		JFreeChart jfreechart
		    = ChartFactory.createBarChart(title,
						  name, "巡检点次", categorydataset,
						  PlotOrientation.HORIZONTAL, true,
						  true, false);
		
		jfreechart.setBackgroundPaint(Color.white);
		CategoryPlot categoryplot = (CategoryPlot) jfreechart.getPlot();
		categoryplot.setBackgroundPaint(Color.lightGray);
		categoryplot.setDomainGridlinePaint(Color.white);
		categoryplot.setDomainGridlinesVisible(true);
		categoryplot.setRangeGridlinePaint(Color.white);
		categoryplot.setRangeAxisLocation(AxisLocation.BOTTOM_OR_LEFT);
		NumberAxis numberaxis = (NumberAxis) categoryplot.getRangeAxis();
		numberaxis.setStandardTickUnits(NumberAxis.createIntegerTickUnits());
		LayeredBarRenderer layeredbarrenderer = new LayeredBarRenderer();
		layeredbarrenderer.setDrawBarOutline(false);
		layeredbarrenderer.setItemLabelsVisible(true);
		layeredbarrenderer.setSeriesBarWidth(0, 0.1);
		layeredbarrenderer.setSeriesBarWidth(1, 0.15);
		categoryplot.setRenderer(layeredbarrenderer);
		categoryplot.setRowRenderingOrder(SortOrder.DESCENDING);
		GradientPaint gradientpaint
		    = new GradientPaint(0.0F, 0.0F, Color.blue, 0.0F, 0.0F,
					new Color(0, 0, 64));
		GradientPaint gradientpaint_7_
		    = new GradientPaint(0.0F, 0.0F, Color.green, 0.0F, 0.0F,
					new Color(0, 64, 0));
		layeredbarrenderer.setSeriesPaint(0, gradientpaint);
		layeredbarrenderer.setSeriesPaint(1, gradientpaint_7_);
		return jfreechart;
	    }
	
}
