package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
	private Connection conn;
	private ResultSet rs;

	public BbsDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS";
			String dbID = "root";
			String dbPassword = "root1234";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				return rs.getString(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // 데이터베이스 오류
	}

	public int getNext() {
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // 첫 번째 게시물인 경우

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

	public int count() {
		String SQL = "SELECT COUNT(*) FROM bbs WHERE bbsAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				return rs.getInt(1);
			}
			return 1; // 첫 번째 게시물인 경우

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

	public int countByCategory(String category) {
		String SQL = "SELECT COUNT(*) FROM bbs WHERE category = ?  AND bbsAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, category);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				return rs.getInt(1);
			}
			return 1; // 첫 번째 게시물인 경우

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

	public int countByID(String userID) {
		String SQL = "SELECT COUNT(*) FROM bbs WHERE userID = ?  AND bbsAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				return rs.getInt(1);
			}
			return 1; // 첫 번째 게시물인 경우

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

	public int write(String bbsTitle, String userID, String bbsContent, String category) {
		String SQL = "INSERT INTO BBS VALUES (?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);

			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1);
			pstmt.setString(7, category);
			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

	public ArrayList<Bbs> getList(int pageNumber, String category) {
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 AND category = ? ORDER BY bbsID DESC LIMIT 10";

		ArrayList<Bbs> list = new ArrayList<Bbs>();

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);

			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			pstmt.setString(2, category);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				bbs.setCategory(rs.getString(7));
				list.add(bbs);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public ArrayList<Bbs> getListMain(String category) {
		String SQL = "SELECT * FROM BBS WHERE bbsAvailable = 1 AND category = ? ORDER BY bbsID DESC LIMIT 6";

		ArrayList<Bbs> list = new ArrayList<Bbs>();

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);

			pstmt.setString(1, category);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				bbs.setCategory(rs.getString(7));
				list.add(bbs);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public ArrayList<Bbs> getListgreeting() {
		String SQL = "SELECT * FROM bbs.bbs WHERE bbsAvailable = 1 AND category = 'greeting' ORDER BY bbsID DESC LIMIT 6;";

		ArrayList<Bbs> list = new ArrayList<Bbs>();

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				bbs.setCategory(rs.getString(7));
				list.add(bbs);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public ArrayList<Bbs> getListRecent(int pageNumber) {
		String SQL = "SELECT * FROM bbs.bbs WHERE bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 15 OFFSET ?";

		ArrayList<Bbs> list = new ArrayList<Bbs>();

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, (pageNumber - 1) * 15);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				bbs.setCategory(rs.getString(7));
				list.add(bbs);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public ArrayList<Bbs> getListByCategory(String category) {
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		String SQL = "SELECT * FROM bbs WHERE category = ? AND bbsAvailable = 1 ORDER BY bbsID DESC;";

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, category);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Bbs bbs = new Bbs();

				bbs.setBbsID(rs.getInt("bbsID"));
				bbs.setBbsTitle(rs.getString("bbsTitle"));
				bbs.setUserID(rs.getString("userID"));
				bbs.setBbsDate(rs.getString("bbsDate"));
				bbs.setCategory(rs.getString("category"));

				list.add(bbs);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public ArrayList<Bbs> getListByCategoryWithPagination(String category, int pageNumber) {
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		String SQL = "SELECT * FROM bbs WHERE category = ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 15 OFFSET ?";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, category);
			pstmt.setInt(2, (pageNumber - 1) * 15); // 페이지 번호에 따라 OFFSET 값 설정

			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt("bbsID"));
				bbs.setBbsTitle(rs.getString("bbsTitle"));
				bbs.setUserID(rs.getString("userID"));
				bbs.setBbsDate(rs.getString("bbsDate"));
				bbs.setCategory(rs.getString("category"));
				list.add(bbs);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public boolean nextPage(int pageNumber, String category) {

		if (countByCategory(category) - (pageNumber - 1) * 15 > 0) {

			return true;
		}
		return false; // 데이터베이스 오류
	}

	public boolean nextPageMy(int pageNumber, String userID) {

		if (countByID(userID) - (pageNumber - 1) * 15 > 0) {

			return true;
		}
		return false; // 데이터베이스 오류
	}

	public boolean nextPageAll(int pageNumber) {

		if (count() - (pageNumber - 1) * 15 > 0) {

			return true;
		}
		return false; // 데이터베이스 오류
	}

	public Bbs getBbs(int bbsID) {
		String SQL = "SELECT * FROM BBS WHERE bbsID = ?";

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				bbs.setCategory(rs.getString(7));
				return bbs;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; // 데이터베이스 오류
	}

	public boolean nextPageByCategory(String category, int pageNumber) {
		String SQL = "SELECT bbsID FROM bbs WHERE category = ? AND bbsID < ? ORDER BY bbsID DESC LIMIT 10";

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, category);
			pstmt.setInt(2, getNextByCategory(category, pageNumber * 10));
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public int getNextByCategory(String category, int pageNumber) {
		String SQL = "SELECT bbsID FROM bbs WHERE category = ? ORDER BY bbsID DESC LIMIT ?, 1";

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, category);
			pstmt.setInt(2, pageNumber);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0; // 다음 글이 없을 경우 0 반환
	}

	public int update(int bbsID, String bbsTitle, String bbsContent) {
		String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);

			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);
			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

	public int delete(int bbsID) {
		String SQL = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

	public ArrayList<Bbs> getTop5ByCategory(String category) {
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		String SQL = "SELECT * FROM bbs WHERE category=? ORDER BY bbsID DESC LIMIT 5";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, category);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt("bbsID"));
				bbs.setBbsTitle(rs.getString("bbsTitle"));
				bbs.setUserID(rs.getString("userID"));
				bbs.setBbsDate(rs.getString("bbsDate"));
				bbs.setCategory(rs.getString("category"));
				list.add(bbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public ArrayList<Bbs> getMyPosts(String userID, int pageNumber) {
		ArrayList<Bbs> myPosts = new ArrayList<>();
		String SQL = "SELECT * FROM bbs.bbs WHERE bbsAvailable = 1 AND userID = ? ORDER BY bbsID DESC LIMIT 15 OFFSET ?";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setInt(2, (pageNumber - 1) * 15);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt("bbsID"));
				bbs.setBbsTitle(rs.getString("bbsTitle"));
				bbs.setUserID(rs.getString("userID"));
				bbs.setBbsDate(rs.getString("bbsDate"));
				bbs.setBbsContent(rs.getString("bbsContent"));
				bbs.setBbsAvailable(rs.getInt("bbsAvailable"));
				bbs.setCategory(rs.getString("category"));
				myPosts.add(bbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return myPosts;
	}

	public ArrayList<Bbs> getPostsByKeyword(String keyword, int pageNumber) {
		ArrayList<Bbs> myPosts = new ArrayList<>();
		String SQL = "SELECT * FROM bbs.bbs WHERE bbsTitle LIKE ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 15 OFFSET ?";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + keyword + "%");
			pstmt.setInt(2, (pageNumber - 1) * 15);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt("bbsID"));
				bbs.setBbsTitle(rs.getString("bbsTitle"));
				bbs.setUserID(rs.getString("userID"));
				bbs.setBbsDate(rs.getString("bbsDate"));
				bbs.setBbsContent(rs.getString("bbsContent"));
				bbs.setBbsAvailable(rs.getInt("bbsAvailable"));
				bbs.setCategory(rs.getString("category"));
				myPosts.add(bbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return myPosts;
	}

	public static String getCategoryInKorean(String category) {
		String koreanCategory = "";
		if ("greeting".equals(category)) {
			koreanCategory = "가입인사";
		} else if ("science".equals(category)) {
			koreanCategory = "과학";
		} else if ("free".equals(category)) {
			koreanCategory = "자유게시판";
		} else if ("sports".equals(category)) {
			koreanCategory = "스포츠";
		} else if ("economy".equals(category)) {
			koreanCategory = "경제";
		} else if ("entertainment".equals(category)) {
			koreanCategory = "연예";
		} else if ("recent".equals(category)) {
			koreanCategory = "최근 게시물";
		} else if ("food".equals(category)) {
			koreanCategory = "음식";
		}

		return koreanCategory;
	}

	public int getTotalPostCount(String category) {
		String SQL = "SELECT COUNT(*) FROM BBS WHERE category = ?";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, category);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0; // 데이터베이스 오류 또는 게시물이 없는 경우
	}

}