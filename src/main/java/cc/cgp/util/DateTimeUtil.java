package cc.cgp.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.apache.log4j.Logger;

public class DateTimeUtil {
	 	private static Logger logger = Logger.getLogger(DateTimeUtil.class);  
	    private static String defaultDatePattern = null;  
	    private static String timePattern = "HH:mm";  
//	    private static Calendar cale = Calendar.getInstance();  
	    public static final String TS_FORMAT = DateTimeUtil.getDatePattern() + " HH:mm:ss.S";  
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
	            return FMDATETIME.format(Calendar.getInstance().getTime());  
	        } catch (Exception e) {  
	        	logger.debug(e.getMessage());  
	        	logger.debug(e.getMessage());  
	        	return "";  
	        }  
	    }  
	    /**
	     * 获取当前时间的字符串，格式为 HH:mm:ss
	     * @return 2017年6月7日 上午10:05:03 by cgp
	     */
	    public static String getTimeStr() {  
	        try {  
	            return FMTIME.format(Calendar.getInstance().getTime());  
	        } catch (Exception e) {  
	            logger.debug(e.getMessage());  
	        	return "";  
	        }  
	    }  
	    /**
	     * 获取当前日期的字符串，格式为 yyyy-MM-dd
	     * @return 2017年6月7日 上午10:05:03 by cgp
	     */
	    public static String getDateStr() {  
	        try {  
	            return FMDATE.format(Calendar.getInstance().getTime());  
	        } catch (Exception e) {  
	            logger.debug(e.getMessage());  
	        	return "";  
	        }  
	    }  
	    
	    /**
	     * 获取当前日期和时间的字符串，格式为 yyyy-MM-dd HH:mm:ss
	     * @return 2017年6月7日 上午10:05:03 by cgp
	     */
	    public static String getDateTimeStr(Date date) {  
	        try {  
	            return FMDATETIME.format(date);  
	        } catch (Exception e) {  
	            logger.debug(e.getMessage());  
	        	return "";  
	        }  
	    }  
	    /**
	     * 获取当前时间的字符串，格式为 HH:mm:ss
	     * @return 2017年6月7日 上午10:05:03 by cgp
	     */
	    public static String getTimeStr(Date date) {  
	        try {  
	            return FMTIME.format(date);  
	        } catch (Exception e) {  
	            logger.debug(e.getMessage());  
	        	return "";  
	        }  
	    }  
	    /**
	     * 获取当前日期的字符串，格式为 yyyy-MM-dd
	     * @return 2017年6月7日 上午10:05:03 by cgp
	     */
	    public static String getDateStr(Date date) {  
	        try {  
	            return FMDATE.format(date);  
	        } catch (Exception e) {  
	            logger.debug(e.getMessage());  
	        	return "";  
	        }  
	    }  
	    /**
	     * 格式为 yyyy-MM-dd 的字符串转化为日历对象
	     * @param datestr
	     * @return 2017年8月4日 下午4:00:11 by cgp
	     */
	    public static Calendar getDate(String datestr){
	    	Calendar calendar = Calendar.getInstance();
	    	try {
				calendar.setTime(FMDATE.parse(datestr));
			} catch (ParseException e) {
				logger.debug(e.getMessage());  
				return null;
			}
        	return calendar;
	    }
	    
	    /**
	     * 格式为 yyyy-MM-dd HH:mm:ss 的字符串转化为日历对象
	     * @param datestr
	     * @return 2017年8月4日 下午4:00:11 by cgp
	     */
	    public static Calendar getDatetime(String datestr){
	    	Calendar calendar = Calendar.getInstance();
	    	try {
				calendar.setTime(FMDATETIME.parse(datestr));
			} catch (ParseException e) {
				logger.debug(e.getMessage());  
				return null;
			}
        	return calendar;
	    }
	    
	    /**
	     * 格式为 HH:mm:ss 的字符串转化为日历对象
	     * @param datestr
	     * @return 2017年8月4日 下午4:00:11 by cgp
	     */
	    public static Calendar getTime(String datestr){
	    	Calendar calendar = Calendar.getInstance();
	    	try {
				calendar.setTime(FMTIME.parse(datestr));
			} catch (ParseException e) {
				logger.debug(e.getMessage());  
				return null;
			}
        	return calendar;
	    }
	    
	    public static synchronized String getDatePattern() {  
	        defaultDatePattern = DATE_FORMAT;  
	        return defaultDatePattern;  
	    }  
	   
	  
	  
	    
}
