package com.cabletech.planstat.dao;

import java.sql.ResultSet;
import java.util.List;

import org.apache.log4j.Logger;

import com.cabletech.commons.hb.HibernateDaoSupport;
import com.cabletech.commons.hb.QueryUtil;
public class RealTimeDAOImpl extends HibernateDaoSupport {
	private Logger logger = Logger.getLogger(RealTimeDAOImpl.class.getName());
	public List getBackInfoList( String sql ){
        QueryUtil query = null;
        List list = null;
            try{
                query = new QueryUtil();
                list = query.queryBeans( sql );
            }
            catch( Exception ex ){
                logger.error("��ѯ�쳣��"+ex.getMessage());
                ex.printStackTrace();
            }
            return list;


    }
    public ResultSet getBackInfoListJDBC( String sql ){
       QueryUtil query = null;
       ResultSet resultset = null;
           try{
               query = new QueryUtil();
               resultset = query.executeQuery(sql);
           }
           catch( Exception ex ){
               logger.error("��ѯ�쳣��"+ex.getMessage());
               ex.printStackTrace();
           }
           return resultset;
   }
}
