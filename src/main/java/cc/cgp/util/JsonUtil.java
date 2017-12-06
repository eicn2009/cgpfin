package cc.cgp.util;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * Json处理工具类
 */
public class JsonUtil {

	public static ObjectMapper om = new ObjectMapper();
	
	
	/**
	 * 对象转json
	 * @param object
	 * @return
	 */
	public static String toJson(Object object){
		try {
			return om.writeValueAsString(object);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * json转对象
	 * @param json
	 * @param valueType
	 * @return
	 */
	public static <T> T toObject(String json, Class<T> valueType) {
		try {
			return om.readValue(json, valueType);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * json转对象(处理复杂类型对象) 
	 * List<bean> : json, List.class, Bean.class
	 * Map<bean1, bean2> : json, Bean1.class, Bean2.class
	 * @param json
	 * @param valueTypeRef
	 * @return
	 */
	public static <T> T toObject(String json, Class<?> collectionClass, Class<?>... elementClasses) {
		try {
			return om.readValue(json, om.getTypeFactory().constructParametricType(collectionClass, elementClasses));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	
}
