package notice;

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
	private int n_categoryNum;
	private String n_categoryName;
}
