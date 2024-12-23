package notice;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class NoticeDTO {
	private int noticeNum;
	private String writer;
	private int adminId;
	private String noticeTitle;
	private String adminPwd;
	private String noticeDate;
	private int hit; 
	private int group_num;
	private int re_order;
	private int re_depth;
	private String noticeContent;
	private String ip;
	private String noticeFile;
	private int filesize;
	private int down; 
}
