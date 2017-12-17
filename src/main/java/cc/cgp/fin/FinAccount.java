/**
 * cc.cgp.fin.FinAccount.java
 * 2017年12月5日 下午7:59:52 by cgp
 */
package cc.cgp.fin;

/**
 * cc.cgp.fin.FinAccount.java
 * 2017年12月5日 下午7:59:52 by cgp
 */
public class FinAccount {
	private int acId;
	private String acName;
	private float acBalance;
	private float acInitbalance;
	private String acCreateTime;
	private String acUpdateTime;
	private int acCanused;
	private int acIsdelete;
	private int userId;
	private String userName;
	private int orgId;
	private String orgName;
	private int actypeId;
	private String actypeName;
	
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
	public int getOrgId() {
		return orgId;
	}
	public void setOrgId(int orgId) {
		this.orgId = orgId;
	}
	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	public int getAcId() {
		return acId;
	}
	public void setAcId(int acId) {
		this.acId = acId;
	}
	public String getAcName() {
		return acName;
	}
	public void setAcName(String acName) {
		this.acName = acName;
	}
	public float getAcBalance() {
		return acBalance;
	}
	public void setAcBalance(float acBalance) {
		this.acBalance = acBalance;
	}
	public float getAcInitbalance() {
		return acInitbalance;
	}
	public void setAcInitbalance(float acInitbalance) {
		this.acInitbalance = acInitbalance;
	}
	public String getAcCreateTime() {
		return acCreateTime;
	}
	public void setAcCreateTime(String acCreateTime) {
		this.acCreateTime = acCreateTime;
	}
	public String getAcUpdateTime() {
		return acUpdateTime;
	}
	public void setAcUpdateTime(String acUpdateTime) {
		this.acUpdateTime = acUpdateTime;
	}
	public int getAcCanused() {
		return acCanused;
	}
	public void setAcCanused(int acCanused) {
		this.acCanused = acCanused;
	}
	public int getAcIsdelete() {
		return acIsdelete;
	}
	public void setAcIsdelete(int acIsdelete) {
		this.acIsdelete = acIsdelete;
	}
	public int getActypeId() {
		return actypeId;
	}
	public void setActypeId(int actypeId) {
		this.actypeId = actypeId;
	}
	public String getActypeName() {
		return actypeName;
	}
	public void setActypeName(String actypeName) {
		this.actypeName = actypeName;
	}
	

}

