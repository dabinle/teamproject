package board;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardCommentDTO {
	private int userID;
	private int commentNum;
	private int boardNum;
	private String adminId;
	private String commentContent;
	private Date commentDate;
}