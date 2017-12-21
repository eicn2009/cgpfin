/**
 * cc.cgp.fin.FinAccountTransfer.java
 * 2017年12月17日 上午11:48:33 by cgp
 */
package cc.cgp.fin;


/**
 * cc.cgp.fin.FinAccountTransfer.java
 * 2017年12月17日 上午11:48:33 by cgp
 */
public class FinAccountTransfer {
	
	private int actrId;
	private String actrDesc;
	private float actrMoney;
	private String actrHappenedTime;
	private String actrCreateTime;
	private int actrIsdelete;
	private int acIdFrom;
	private String acNameFrom;
	private FinAccount finAccountFrom;
	private int acIdTo;
	private String acNameTo;
	private FinAccount finAccountTo;
	private int userId;
	private String userName;
	
	
	public int getActrId() {
		return actrId;
	}
	public void setActrId(int actrId) {
		this.actrId = actrId;
	}
	public String getActrDesc() {
		return actrDesc;
	}
	public void setActrDesc(String actrDesc) {
		this.actrDesc = actrDesc;
	}
	public float getActrMoney() {
		return actrMoney;
	}
	public void setActrMoney(float actrMoney) {
		this.actrMoney = actrMoney;
	}
	public String getActrHappenedTime() {
		return actrHappenedTime;
	}
	public void setActrHappenedTime(String actrHappenedTime) {
		this.actrHappenedTime = actrHappenedTime;
	}
	public String getActrCreateTime() {
		return actrCreateTime;
	}
	public void setActrCreateTime(String actrCreateTime) {
		this.actrCreateTime = actrCreateTime;
	}
	public int getActrIsdelete() {
		return actrIsdelete;
	}
	public void setActrIsdelete(int actrIsdelete) {
		this.actrIsdelete = actrIsdelete;
	}
	public int getAcIdFrom() {
		return acIdFrom;
	}
	public void setAcIdFrom(int acIdFrom) {
		this.acIdFrom = acIdFrom;
	}
	public String getAcNameFrom() {
		return acNameFrom;
	}
	public void setAcNameFrom(String acNameFrom) {
		this.acNameFrom = acNameFrom;
	}
	public FinAccount getFinAccountFrom() {
		return finAccountFrom;
	}
	public void setFinAccountFrom(FinAccount finAccountFrom) {
		this.finAccountFrom = finAccountFrom;
	}
	public int getAcIdTo() {
		return acIdTo;
	}
	public void setAcIdTo(int acIdTo) {
		this.acIdTo = acIdTo;
	}
	public String getAcNameTo() {
		return acNameTo;
	}
	public void setAcNameTo(String acNameTo) {
		this.acNameTo = acNameTo;
	}
	public FinAccount getFinAccountTo() {
		return finAccountTo;
	}
	public void setFinAccountTo(FinAccount finAccountTo) {
		this.finAccountTo = finAccountTo;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}	
	
	
	
}

