package DAO250;

import Entity250.TKNCC250;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class TKNCC_DAO250 {
    private static Connection con;

    public TKNCC_DAO250() throws Exception {
        DAO250 dao = new DAO250();
        con = dao.getConnection();
        if (con == null) {
            System.err.println("Không thể kết nối đến cơ sở dữ liệu.");
        }
    }

    /**
     * Thống kê danh sách nhà cung cấp theo tổng số lượng hàng nhập
     * @param nbd Ngày bắt đầu (yyyy-MM-dd)
     * @param nkt Ngày kết thúc (yyyy-MM-dd)
     * @return Danh sách TKNCC250 xếp theo số lượng hàng nhập giảm dần
     */
    public List<TKNCC250> getTKNCC(String nbd, String nkt) {
        List<TKNCC250> list = new ArrayList<>();
        String sql = "{CALL TKNCCTheoSLNhap250(?, ?)}";

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date startDate = new Date(sdf.parse(nbd).getTime());
            Date endDate = new Date(sdf.parse(nkt).getTime());

            try (CallableStatement cstmt = con.prepareCall(sql)) {
                cstmt.setDate(1, startDate);
                cstmt.setDate(2, endDate);

                try (ResultSet rs = cstmt.executeQuery()) {
                    while (rs.next()) {
                        TKNCC250 tk = new TKNCC250();
                        tk.setId(rs.getString("nccId"));
                        tk.setMaNCC(rs.getString("maNCC"));
                        tk.setTen(rs.getString("tenNCC"));
                        tk.setDiaChi(rs.getString("diaChi"));
                        tk.setSdt(rs.getString("sdt"));
                        tk.setEmail(rs.getString("email"));
                        tk.setSoLanNhap(rs.getInt("soLanNhap"));
                        tk.setTongSoLuongNhap(rs.getInt("tongSoLuongNhap"));
                        tk.setTongGiaTriNhap(rs.getDouble("tongGiaTriNhap"));
                        tk.setNgayBatDau(startDate);
                        tk.setNgayKetThuc(endDate);
                        list.add(tk);
                    }
                }
            }
        } catch (SQLException | ParseException e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void main(String[] args) {
        try {
            TKNCC_DAO250 dao = new TKNCC_DAO250();
            List<TKNCC250> list = dao.getTKNCC("2024-10-01", "2024-10-31");
            System.out.println("Thống kê NCC (2024-10-01 đến 2024-10-31):");
            for (TKNCC250 tk : list) {
                System.out.println(" - " + tk.getTen() + " | SL Nhập: " + tk.getTongSoLuongNhap() + " | Số lần nhập: " + tk.getSoLanNhap() + " | Tổng tiền: " + tk.getTongGiaTriNhap());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

