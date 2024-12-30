package faq;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FaqDTO {
	private int faqNum;
	private int f_categoryNum ;
	private String adminId;
	private String qusetion;
	private String f_answer;
	private String f_categoryName;
}
