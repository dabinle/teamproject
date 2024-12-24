package board;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class NoticeDTO {
	private int noticeNum;
	private String adminId;
	private String noticeTitle;
	private String noticeContent;
	private String noticeFile;
	private Date noticeDate;
}
