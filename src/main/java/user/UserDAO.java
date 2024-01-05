package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    public UserDAO() {
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

    public int login(String userID, String userPassword) {
        String SQL = "SELECT userPassword FROM USER WHERE userID=?";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                if (rs.getString(1).equals(userPassword)) {
                    return 1; // 로그인 성공
                } else
                    return 0; // 비밀번호 불일치
            }
            return -1; // 아이디가 없음
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -2; // 데이터베이스 오류
    }

    public int join(User user) {
        String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?,?,?,?)";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, user.getUserID());
            pstmt.setString(2, user.getUserPassword());
            pstmt.setString(3, user.getUserName());
            pstmt.setString(4, user.getUserGender());
            pstmt.setString(5, user.getUserEmail());
            pstmt.setString(6, user.getBirth());
            pstmt.setString(7, user.getpNumber());
            pstmt.setString(8, user.getAddress());
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }

    public User getUserInfo(String userID) {
        String SQL = "SELECT * FROM USER WHERE userID = ?";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                User userInfo = new User();
                userInfo.setUserID(rs.getString("userID"));
                userInfo.setUserPassword(rs.getString("userPassword"));
                userInfo.setUserName(rs.getString("userName"));
                userInfo.setUserGender(rs.getString("userGender"));
                userInfo.setUserEmail(rs.getString("userEmail"));
                userInfo.setBirth(rs.getString("birth")); // 추가
                userInfo.setpNumber(rs.getString("pNumber")); // 추가
                userInfo.setAddress(rs.getString("address")); // 추가
                return userInfo;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // 데이터베이스 오류 또는 사용자가 존재하지 않는 경우
    }
}
