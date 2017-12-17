/**
 * cc.cgp.fin.FinAccountInOut.java
 * 2017年12月9日 下午5:01:14 by cgp
 */
package cc.cgp.fin;


/**
 * cc.cgp.fin.FinAccountInOut.java
 * 2017年12月9日 下午5:01:14 by cgp
 */
public class FinAccountInout {
	private int acioId;
	private String acioDesc;
	private int aciotypeId;
	private float acioMoney;
	private int userId;
	private float acioBalance;
	private int acId;
	FinAccount finAccount;
	private String acioHappenedTime;
	private String acioCreateTime;
	private int acioIsdelete;
	private int aciotypeInorout;
	
	public int getAcioId() {
		return acioId;
	}
	public void setAcioId(int acioId) {
		this.acioId = acioId;
	}
	public String getAcioDesc() {
		return acioDesc;
	}
	public void setAcioDesc(String acioDesc) {
		this.acioDesc = acioDesc;
	}
	public int getAciotypeId() {
		return aciotypeId;
	}
	public void setAciotypeId(int aciotypeId) {
		this.aciotypeId = aciotypeId;
	}
	public float getAcioMoney() {
		return acioMoney;
	}
	public void setAcioMoney(float acioMoney) {
		this.acioMoney = acioMoney;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public float getAcioBalance() {
		return acioBalance;
	}
	public void setAcioBalance(float acioBalance) {
		this.acioBalance = acioBalance;
	}
	public int getAcId() {
		return acId;
	}
	public void setAcId(int acId) {
		this.acId = acId;
	}
	public FinAccount getFinAccount() {
		return finAccount;
	}
	public void setFinAccount(FinAccount finAccount) {
		this.finAccount = finAccount;
	}
	public String getAcioHappenedTime() {
		return acioHappenedTime;
	}
	public void setAcioHappenedTime(String acioHappenedTime) {
		this.acioHappenedTime = acioHappenedTime;
	}
	public String getAcioCreateTime() {
		return acioCreateTime;
	}
	public void setAcioCreateTime(String acioCreateTime) {
		this.acioCreateTime = acioCreateTime;
	}
	public int getAcioIsdelete() {
		return acioIsdelete;
	}
	public void setAcioIsdelete(int acioIsdelete) {
		this.acioIsdelete = acioIsdelete;
	}
	public int getAciotypeInorout() {
		return aciotypeInorout;
	}
	public void setAciotypeInorout(int aciotypeInorout) {
		this.aciotypeInorout = aciotypeInorout;
	}
	
	
	
	
//	"id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
//	 "type" TEXT,
//	 "desc" TEXT,
//	 "money" real,
//	 "userid" INTEGER,
//	 "balance" real,
//	 "accountid" INTEGER,
//	 "happenedtime" INTEGER DEFAULT (datetime('now', 'localtime')),
//	 "createtime" INTEGER DEFAULT (datetime('now', 'localtime')),
//	 "isdelete" INTEGER DEFAULT 0

}

