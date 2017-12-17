/**
 * cc.cgp.util.DataUtil.java
 * 2017年12月15日 下午3:52:16 by cgp
 */
package cc.cgp.util;

import java.beans.BeanInfo;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.*;

import org.apache.commons.beanutils.BeanUtils;

import cc.cgp.fin.FinAccount;
import net.sf.cglib.beans.BeanMap;

/**
 * cc.cgp.util.DataUtil.java 2017年12月15日 下午3:52:16 by cgp
 */
public class CamelUtil {

	/**
	 * 将Map中的key由下划线转换为驼峰
	 *
	 * @param map
	 * @return
	 */
	public static Map<String, Object> getCamleMap(Map<String, Object> map) {
		Map<String, Object> newMap = new HashMap<String, Object>();
		Iterator<Map.Entry<String, Object>> it = map.entrySet().iterator();
		while (it.hasNext()) {
			Map.Entry<String, Object> entry = it.next();
			String key = entry.getKey();
			String newKey = getCamelStr(key);
			newMap.put(newKey, entry.getValue());
		}
		return newMap;
	}

	public static String getCamelStr(String colName) {
		StringBuilder sb = new StringBuilder();
		String[] str = colName.toLowerCase().split("_");
		int i = 0;
		for (String s : str) {
			if (s.length() == 1) {
				s = s.toUpperCase();
			}
			i++;
			if (i == 1) {
				sb.append(s);
				continue;
			}
			if (s.length() > 0) {
				sb.append(s.substring(0, 1).toUpperCase());
				sb.append(s.substring(1));
			}
		}
		return sb.toString();
	}

	/**
	 * 将List中map的key值命名方式格式化为驼峰
	 *
	 * @param
	 * @return
	 */
	public static List<Map<String, Object>> getCamelMapList(List<Map<String, Object>> list) {
		List<Map<String, Object>> newList = new ArrayList<Map<String, Object>>();
		for (Map<String, Object> o : list) {
			newList.add(getCamleMap(o));
		}
		return newList;
	}

	/**
	 * 
	 * @param beanClass
	 * @param map
	 * @return 2017年12月15日 下午7:54:24 by cgp
	 */
	@SuppressWarnings("unchecked")
	public static <T> T getCamelClassFromMap(Class<T> beanClass, Map<String, Object> map) {
		T t = null;
		try {
			t = (T) BeanUtil.mapToObject(getCamleMap(map), beanClass);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return t;

		// T t = null;
		// Constructor<?> c = null;
		// try {
		// c = classType.getConstructor();
		// t = (T) c.newInstance();
		// } catch (Exception e) {
		// e.printStackTrace();
		// }
		// return t;
	}

	public static void main(String[] args) {
		Map<String, Object> map =  new HashMap<String, Object>();
		map.put("ac_id", 1);
		
		FinAccount finAccount = getCamelClassFromMap(FinAccount.class,map);
		System.out.println();
	}
}


