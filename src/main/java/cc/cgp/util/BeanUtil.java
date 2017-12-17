/**
 * cc.cgp.util.BeanUtil.java
 * 2017年12月15日 下午7:47:42 by cgp
 */
package cc.cgp.util;

import java.beans.BeanInfo;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;

import net.sf.cglib.beans.BeanMap;

/**
 * 使用org.apache.commons.beanutils进行转换
 * cc.cgp.util.BeanUtil.java
 * 2017年12月15日 下午7:47:42 by cgp
 */
public class BeanUtil {
	public static Object mapToObject(Map<String, Object> map, Class<?> beanClass) throws Exception {
		if (map == null)
			return null;
		Object obj = beanClass.newInstance();
		BeanUtils.populate(obj, map);
		return obj;
	}

	public static Map<?, ?> objectToMap(Object obj) {
		if (obj == null)
			return null;
		return new org.apache.commons.beanutils.BeanMap(obj);
	}
}

class A {

    /**
 * 将对象转换为map
 * @param bean
 * @return
 */
public static <T> Map<String, Object> beanToMap(T bean) {
	Map<String, Object> map = new HashMap<String, Object>();
	if (bean != null) {
		BeanMap beanMap = BeanMap.create(bean);
		for (Object key : beanMap.keySet()) {
			map.put(key+"", beanMap.get(key));
		}			
	}
	return map;
}

/**
 * 将map转换为javabean对象
 * @param map
 * @param bean
 * @return
 */
public static <T> T mapToBean(Map<String, Object> map,T bean) {
	BeanMap beanMap = BeanMap.create(bean);
	beanMap.putAll(map);
	return bean;
}

/**
 * 将List<T>转换为List<Map<String, Object>>
 * @param objList
 * @return
 * @throws JsonGenerationException
 * @throws JsonMappingException
 * @throws IOException
 */
public static <T> List<Map<String, Object>> objectsToMaps(List<T> objList) {
	List<Map<String, Object>> list =  new ArrayList<Map<String, Object>> ();
	if (objList != null && objList.size() > 0) {
		Map<String, Object> map = null;
		T bean = null;
		for (int i = 0,size = objList.size(); i < size; i++) {
			bean = objList.get(i);
			map = beanToMap(bean);
			list.add(map);
		}
	}
	return list;
}

/**
 * 将List<Map<String,Object>>转换为List<T>
 * @param maps
 * @param clazz
 * @return
 * @throws InstantiationException
 * @throws IllegalAccessException
 */
public static <T> List<T> mapsToObjects(List<Map<String, Object>> maps,Class<T> clazz) throws InstantiationException, IllegalAccessException {
	List<T> list = new ArrayList<T>();
	if (maps != null && maps.size() > 0) {
		Map<String, Object> map = null;
		T bean = null;
		for (int i = 0,size = maps.size(); i < size; i++) {
			map = maps.get(i);
			bean = clazz.newInstance();
			mapToBean(map, bean);
			list.add(bean);
		}
	}
	return list;
}
}

/**
 * 使用Introspector进行转换
 */
class B {

	public static Object mapToObject(Map<String, Object> map, Class<?> beanClass) throws Exception {
		if (map == null)
			return null;

		Object obj = beanClass.newInstance();

		BeanInfo beanInfo = Introspector.getBeanInfo(obj.getClass());
		PropertyDescriptor[] propertyDescriptors = beanInfo.getPropertyDescriptors();
		for (PropertyDescriptor property : propertyDescriptors) {
			Method setter = property.getWriteMethod();
			if (setter != null) {
				setter.invoke(obj, map.get(property.getName()));
			}
		}

		return obj;
	}

	public static Map<String, Object> objectToMap(Object obj) throws Exception {
		if (obj == null)
			return null;

		Map<String, Object> map = new HashMap<String, Object>();

		BeanInfo beanInfo = Introspector.getBeanInfo(obj.getClass());
		PropertyDescriptor[] propertyDescriptors = beanInfo.getPropertyDescriptors();
		for (PropertyDescriptor property : propertyDescriptors) {
			String key = property.getName();
			if (key.compareToIgnoreCase("class") == 0) {
				continue;
			}
			Method getter = property.getReadMethod();
			Object value = getter != null ? getter.invoke(obj) : null;
			map.put(key, value);
		}

		return map;
	}

}

/**
 * 使用reflect进行转换
 */
class C {

	public static Object mapToObject(Map<String, Object> map, Class<?> beanClass) throws Exception {
		if (map == null)
			return null;

		Object obj = beanClass.newInstance();

		Field[] fields = obj.getClass().getDeclaredFields();
		for (Field field : fields) {
			int mod = field.getModifiers();
			if (Modifier.isStatic(mod) || Modifier.isFinal(mod)) {
				continue;
			}

			field.setAccessible(true);
			field.set(obj, map.get(field.getName()));
		}

		return obj;
	}

	public static Map<String, Object> objectToMap(Object obj) throws Exception {
		if (obj == null) {
			return null;
		}

		Map<String, Object> map = new HashMap<String, Object>();

		Field[] declaredFields = obj.getClass().getDeclaredFields();
		for (Field field : declaredFields) {
			field.setAccessible(true);
			map.put(field.getName(), field.get(obj));
		}

		return map;
	}
}
