package review;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReviewDTO {
	private int reviewNum;
	private String userID;
	private int productNum;
	private String reviewTitle;
	private String reviewContent;
	private String reviewFile;
	private String reviewDate;
	private int reviewScore;
	private int reviewLike;
}