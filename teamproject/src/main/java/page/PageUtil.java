package page;

public class PageUtil {
	public static final int PAGE_SCALE = 10; // 페이지당 게시물 수
	public static final int BLOCK_SCALE = 10; // 페이지 블록 단위(한 화면에 보여줄 페이지 수)
	private int curPage; // 현재 페이지
	private int prevPage; // 이전 페이지
	private int nextPage; // 다음 페이지
	private int totPage; // 전체 페이지 개수
	private int totBlock; // 전체 블록 개수
	private int curBlock; // 현재 페이지 블록
	private int prevBlock; // 이전 페이지 블록
	private int nextBlock; // 다음 페이지 블록
	private int pageBegin; // 현재 페이지 시작 번호
	private int pageEnd; // 현재 페이지 끝 번호
	private int blockStart; // 현재 블록의 시작 번호
	private int blockEnd; // 현재 블록의 끝 번호
	
	public PageUtil(int count, int curPage) {
		curBlock = 1;
		this.curPage = curPage;
		setTotPage(count);
		setPageRange();
		setTotBlock();
		setBlockRange();
	}
	
	public void setTotBlock() {
		totBlock = (int) Math.ceil(totPage*1.0 / BLOCK_SCALE);
	}
	
	public void setBlockRange() {
		curBlock = (int) Math.ceil((curPage-1) / BLOCK_SCALE) + 1;
		blockStart = (curBlock-1) * BLOCK_SCALE + 1;
		blockEnd = blockStart + BLOCK_SCALE - 1;
		
		if (blockEnd > totPage) {
			blockEnd = totPage;
		}
		prevPage = curBlock == 1 ? 1 : (curBlock-1) * BLOCK_SCALE;
		nextPage = curBlock > totBlock ? (curBlock * BLOCK_SCALE) : (curBlock * BLOCK_SCALE) + 1;
		
		if (nextPage >= totPage) {
			nextPage = totPage;
		}
	}
	
	
	public void setPageRange() {
		pageBegin = (curPage - 1) * PAGE_SCALE + 1;
		pageEnd = pageBegin + PAGE_SCALE -1;
	}
	
	public void setTotPage(int count) {
		totPage = (int) Math.ceil(count * 1.0 / PAGE_SCALE);
	}

	public int getTotBlock() {
		return totBlock;
	}

	public void setTotBlock(int totBlock) {
		this.totBlock = totBlock;
	}
	
	public int getTotPage() {
		return totPage;
	}
	
	
	public int getCurPage() {
		return curPage;
	}

	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}

	public int getPrevPage() {
		return prevPage;
	}

	public void setPrevPage(int prevPage) {
		this.prevPage = prevPage;
	}

	public int getNextPage() {
		return nextPage;
	}

	public void setNextPage(int nextPage) {
		this.nextPage = nextPage;
	}
	
	public int getCurBlock() {
		return curBlock;
	}

	public void setCurBlock(int curBlock) {
		this.curBlock = curBlock;
	}

	public int getPrevBlock() {
		return prevBlock;
	}

	public void setPrevBlock(int prevBlock) {
		this.prevBlock = prevBlock;
	}

	public int getNextBlock() {
		return nextBlock;
	}

	public void setNextBlock(int nextBlock) {
		this.nextBlock = nextBlock;
	}

	public int getPageBegin() {
		return pageBegin;
	}

	public void setPageBegin(int pageBegin) {
		this.pageBegin = pageBegin;
	}

	public int getPageEnd() {
		return pageEnd;
	}

	public void setPageEnd(int pageEnd) {
		this.pageEnd = pageEnd;
	}

	public int getBlockStart() {
		return blockStart;
	}

	public void setBlockStart(int blockStart) {
		this.blockStart = blockStart;
	}

	public int getBlockEnd() {
		return blockEnd;
	}

	public void setBlockEnd(int blockEnd) {
		this.blockEnd = blockEnd;
	}
}
