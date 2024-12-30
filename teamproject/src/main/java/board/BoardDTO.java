package board;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardDTO {
	private int boardNum;
	private String userID;
	private String adminId;
	private String boardTitle;
	private String userPwd;
	private String boardDate;
	private int hit;
	private int groupNum;
	private int re_order;
	private int re_depth;
	private String boardContent;
	private int count_comment;
	private String boardFileName;
	private int boardFileSize;
	private int down;
	private int count_comments;  
}
