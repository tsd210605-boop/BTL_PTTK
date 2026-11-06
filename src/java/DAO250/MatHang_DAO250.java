package DAO250;

import Entity250.MatHang250;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MatHang_DAO250 {
    private static Connection con;

    public MatHang_DAO250() throws Exception {
        DAO250 dao = new DAO250();
        con = dao.getConnection();
        if (con == null) {
            System.err.println("Không thể kết nối đến cơ sở dữ liệu.");
        }
    }

    /**
     * Tìm kiếm danh sách mặt hàng có tên hoặc mô tả chứa từ khóa
     * @param keyword Từ khóa tìm kiếm
     * @return Danh sách mặt hàng phù hợp
     */
    public List<MatHang250> searchMatHang(String keyword) {
        List<MatHang250> list = new ArrayList<>();
        String sql = "{CALL TimKiemMatHang250(?)}";

        try (CallableStatement cstmt = con.prepareCall(sql)) {
            cstmt.setString(1, keyword != null ? keyword.trim() : "");

            try (ResultSet rs = cstmt.executeQuery()) {
                while (rs.next()) {
                    MatHang250 mh = new MatHang250();
                    mh.setId(rs.getString("id"));
                    mh.setTen(rs.getString("ten"));
                    mh.setGia(rs.getDouble("gia"));
                    mh.setDonViTinh(rs.getString("donViTinh"));
                    mh.setMota(rs.getString("mota"));
                    mh.setSoLuongTon(rs.getInt("soLuongTon"));
                    mh.setNhaCungCapId(rs.getString("nhaCungCapId"));
                    mh.setTenNCC(rs.getString("tenNCC"));
                    list.add(mh);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Lấy thông tin chi tiết của 1 mặt hàng theo ID
     * @param id Mã mặt hàng
     * @return Đối tượng MatHang250 chi tiết kèm thông tin Nhà cung cấp
     */
    public MatHang250 getMatHangById(String id) {
        String sql = "{CALL GetMatHangById250(?)}";

        try (CallableStatement cstmt = con.prepareCall(sql)) {
            cstmt.setString(1, id);

            try (ResultSet rs = cstmt.executeQuery()) {
                if (rs.next()) {
                    MatHang250 mh = new MatHang250();
                    mh.setId(rs.getString("id"));
                    mh.setTen(rs.getString("ten"));
                    mh.setGia(rs.getDouble("gia"));
                    mh.setDonViTinh(rs.getString("donViTinh"));
                    mh.setMota(rs.getString("mota"));
                    mh.setSoLuongTon(rs.getInt("soLuongTon"));
                    mh.setNhaCungCapId(rs.getString("nhaCungCapId"));
                    mh.setTenNCC(rs.getString("tenNCC"));
                    mh.setDiaChiNCC(rs.getString("diaChiNCC"));
                    mh.setSdtNCC(rs.getString("sdtNCC"));
                    mh.setEmailNCC(rs.getString("emailNCC"));
                    return mh;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) {
        try {
            MatHang_DAO250 dao = new MatHang_DAO250();
            List<MatHang250> list = dao.searchMatHang("Sữa");
            System.out.println("Kết quả tìm kiếm: " + list.size() + " mặt hàng.");
            for (MatHang250 m : list) {
                System.out.println(" - " + m.getId() + " | " + m.getTen() + " | " + m.getGia() + " | " + m.getTenNCC());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

