package DAO250;

import Entity250.NVQL_250;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class NVQL_DAO250 {
    private static Connection con;

    public NVQL_DAO250() throws Exception {
        DAO250 dao = new DAO250();
        con = dao.getConnection();
        if (con == null) {
            System.err.println("Không thể kết nối đến cơ sở dữ liệu.");
        }
    }

    public NVQL_250 checkLogin(String userId, String password) {
        String sql = "SELECT * FROM nvql_250 WHERE maNV = ? AND password = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, userId);
            ps.setString(2, password);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                NVQL_250 ql = new NVQL_250();
                ql.setId(rs.getInt("id"));
                ql.setHoTen(rs.getString("hoTen"));
                ql.setSdt(rs.getString("sdt"));
                ql.setEmail(rs.getString("email"));
                ql.setNgaySinh(rs.getDate("ngaySinh"));
                ql.setPassword(rs.getString("password"));
                ql.setMaNV(rs.getString("maNV"));
                ql.setChucVu(rs.getString("chucVu"));
                ql.setSieuThiId(rs.getInt("sieuThi_Id"));
                return ql;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}

