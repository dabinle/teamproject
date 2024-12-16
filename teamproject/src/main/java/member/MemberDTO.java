package member;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MemberDTO {
	private String userID;
	private String userName;
	private String userPwd;
	private String email;
	private String phoneNum;
	private int zipCode;
	private String address;
	private String addressDetail;
}
