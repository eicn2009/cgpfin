package cc.cgp.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.apache.log4j.Logger;

public class DateTimeUtils {
	 	private static Logger logger = Logger.getLogger(DateTimeUtils.class);  
	    private static String defaultDatePattern = null;  
	    private static String timePattern = "HH:mm";  
	    private static Calendar cale = Calendar.getInstance();  
	    public static final String TS_FORMAT = DateTimeUtils.getDatePattern() + " HH:mm:ss.S";  
	    /** 日期格式yyyy-MM字符串常量 */  
	    private static final String MONTH_FORMAT = "yyyy-MM";  
	    /** 日期格式yyyy-MM-dd字符串常量 */  
	    private static final String DATE_FORMAT = "yyyy-MM-dd";  
	    /** 日期格式HH:mm:ss字符串常量 */  
	    private static final String TIME_FORMAT = "HH:mm:ss";  
	    /** 日期格式yyyy-MM-dd HH:mm:ss字符串常量 */  
	    private static final String DATETIME_FORMAT = "yyyy-MM-dd HH:mm:ss";  
	    /** 某天开始时分秒字符串常量  00:00:00 */  
	    private static final String DAY_BEGIN_STRING_HHMMSS = " 00:00:00";  
	    /**  某天结束时分秒字符串常量  23:59:59  */  
	    public static final String DAY_END_STRING_HHMMSS = " 23:59:59";  
	    private static SimpleDateFormat FMDATE = new SimpleDateFormat(DATE_FORMAT);  
	    private static SimpleDateFormat FMTIME = new SimpleDateFormat(TIME_FORMAT);  
	    private static SimpleDateFormat FMDATETIME = new SimpleDateFormat(DATETIME_FORMAT); 
	    
	    /**
	     * 获取当前日期和时间的字符串，格式为 yyyy-MM-dd HH:mm:ss
	     * @return 2017年6月7日 上午10:05:03 by cgp
	     */
	    public static String getDateTimeStr() {  
	        try {  
	        	cale = Calendar.getInstance();
	            return FMDATETIME.format(cale.getTime());  
	        } catch (Exception e) {  
	            logger.debug("DateUtil.getDateTime():" + e.getMessage());  
	            return "";  
	        }  
	    }  
	    /**
	     * 获取当前时间的字符串，格式为 HH:mm:ss
	     * @return 2017年6月7日 上午10:05:03 by cgp
	     */
	    public static String getTimeStr() {  
	        try {  
	        	cale = Calendar.getInstance();
	            return FMTIME.format(cale.getTime());  
	        } catch (Exception e) {  
	            logger.debug("DateUtil.getDateTime():" + e.getMessage());  
	            return "";  
	        }  
	    }  
	    /**
	     * 获取当前日期的字符串，格式为 yyyy-MM-dd
	     * @return 2017年6月7日 上午10:05:03 by cgp
	     */
	    public static String getDateStr() {  
	        try {  
	        	cale = Calendar.getInstance();
	            return FMDATE.format(cale.getTime());  
	        } catch (Exception e) {  
	            logger.debug("DateUtil.getDateTime():" + e.getMessage());  
	            return "";  
	        }  
	    }  
	    
	    /**
	     * 获取当前日期和时间的字符串，格式为 yyyy-MM-dd HH:mm:ss
	     * @return 2017年6月7日 上午10:05:03 by cgp
	     */
	    public static String getDateTimeStr(Date date) {  
	        try {  
	        	cale = Calendar.getInstance();
	        	cale.setTime(date);
	            return FMDATETIME.format(cale.getTime());  
	        } catch (Exception e) {  
	            logger.debug("DateUtil.getDateTime():" + e.getMessage());  
	            return "";  
	        }  
	    }  
	    /**
	     * 获取当前时间的字符串，格式为 HH:mm:ss
	     * @return 2017年6月7日 上午10:05:03 by cgp
	     */
	    public static String getTimeStr(Date date) {  
	        try {  
	        	cale = Calendar.getInstance();
	        	cale.setTime(date);
	            return FMTIME.format(cale.getTime());  
	        } catch (Exception e) {  
	            logger.debug("DateUtil.getDateTime():" + e.getMessage());  
	            return "";  
	        }  
	    }  
	    /**
	     * 获取当前日期的字符串，格式为 yyyy-MM-dd
	     * @return 2017年6月7日 上午10:05:03 by cgp
	     */
	    public static String getDateStr(Date date) {  
	        try {  
	        	cale = Calendar.getInstance();
	        	cale.setTime(date);
	            return FMDATE.format(cale.getTime());  
	        } catch (Exception e) {  
	            logger.debug("DateUtil.getDateTime():" + e.getMessage());  
	            return "";  
	        }  
	    }  
	    
	    public static synchronized String getDatePattern() {  
	        defaultDatePattern = DATE_FORMAT;  
	        return defaultDatePattern;  
	    }  
	   
	  
	  
	    
}
