package board;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardCommentDTO {
	private int commentNum;
	private int boardNum;
	private String adminName;
	private String commentContent;
	private Date commentDate;
}