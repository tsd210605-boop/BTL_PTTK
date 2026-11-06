package DAO250;

import Entity250.HDNChiTiet250;
import Entity250.HoaDonNhap250;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class HoaDonNhap_DAO250 {
    private static Connection con;

    public HoaDonNhap_DAO250() throws Exception {
        DAO250 dao = new DAO250();
        con = dao.getConnection();
        if (con == null) {
            System.err.println("Không thể kết nối đến cơ sở dữ liệu.");
        }
    }

    /**
     * Lấy danh sách các lần nhập hàng (hóa đơn nhập) của 1 NCC trong khoảng ngày
     * @param nccId ID nhà cung cấp
     * @param nbd Ngày bắt đầu
     * @param nkt Ngày kết thúc
     * @return Danh sách các hóa đơn nhập
     */
    public List<HoaDonNhap250> getListHDNByNCC(String nccId, Date nbd, Date nkt) {
        List<HoaDonNhap250> list = new ArrayList<>();
        String sql = "{CALL GetListHDNByNCC250(?, ?, ?)}";

        try (CallableStatement cstmt = con.prepareCall(sql)) {
            cstmt.setString(1, nccId);
            cstmt.setDate(2, nbd);
            cstmt.setDate(3, nkt);

            try (ResultSet rs = cstmt.executeQuery()) {
                while (rs.next()) {
                    HoaDonNhap250 hdn = new HoaDonNhap250();
                    hdn.setId(rs.getString("maHDN"));
                    hdn.setNgayNhap(rs.getDate("ngayNhap"));
                    hdn.setTongSoLuong(rs.getInt("tongSoLuong"));
                    hdn.setTongTien(rs.getDouble("tongTien"));
                    hdn.setNhaCungCapId(rs.getString("nhaCungCapId"));
                    hdn.setTenNCC(rs.getString("tenNCC"));
                    hdn.setMaNVK(rs.getInt("maNVK"));
                    hdn.setTenNVK(rs.getString("tenNVK"));
                    list.add(hdn);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Lấy thông tin đầu phiếu của 1 hóa đơn nhập theo mã
     * @param maHDN Mã hóa đơn nhập
     * @return Đối tượng HoaDonNhap250
     */
    public HoaDonNhap250 getHDNById(String maHDN) {
        String sql = "SELECT hdn.id AS maHDN, hdn.ngayNhap, hdn.tongSoLuong, hdn.tongTien, "
                   + "hdn.nhaCungCapId, ncc.ten AS tenNCC, ncc.diaChi AS diaChiNCC, ncc.sdt AS sdtNCC, "
                   + "hdn.maNVK, COALESCE(nvk.hoTen, 'Nhân viên kho') AS tenNVK "
                   + "FROM hoadonnhap_250 hdn "
                   + "JOIN nhacungcap_250 ncc ON hdn.nhaCungCapId = ncc.id "
                   + "LEFT JOIN nvk_250 nvk ON hdn.maNVK = nvk.id "
                   + "WHERE hdn.id = ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, maHDN);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    HoaDonNhap250 hdn = new HoaDonNhap250();
                    hdn.setId(rs.getString("maHDN"));
                    hdn.setNgayNhap(rs.getDate("ngayNhap"));
                    hdn.setTongSoLuong(rs.getInt("tongSoLuong"));
                    hdn.setTongTien(rs.getDouble("tongTien"));
                    hdn.setNhaCungCapId(rs.getString("nhaCungCapId"));
                    hdn.setTenNCC(rs.getString("tenNCC"));
                    hdn.setMaNVK(rs.getInt("maNVK"));
                    hdn.setTenNVK(rs.getString("tenNVK"));
                    return hdn;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Lấy danh sách các mặt hàng chi tiết trong 1 hóa đơn nhập
     * @param maHDN Mã hóa đơn nhập
     * @return Danh sách HDNChiTiet250
     */
    public List<HDNChiTiet250> getChiTietHDN(String maHDN) {
        List<HDNChiTiet250> list = new ArrayList<>();
        String sql = "{CALL GetChiTietHDN250(?)}";

        try (CallableStatement cstmt = con.prepareCall(sql)) {
            cstmt.setString(1, maHDN);

            try (ResultSet rs = cstmt.executeQuery()) {
                while (rs.next()) {
                    HDNChiTiet250 ct = new HDNChiTiet250();
                    ct.setId(rs.getInt("id"));
                    ct.setMaHDN(rs.getString("maHDN"));
                    ct.setMatHangId(rs.getString("matHangId"));
                    ct.setTenMatHang(rs.getString("tenMatHang"));
                    ct.setDonViTinh(rs.getString("donViTinh"));
                    ct.setSoLuong(rs.getInt("soLuong"));
                    ct.setGiaNhap(rs.getDouble("giaNhap"));
                    ct.setThanhTien(rs.getDouble("thanhTien"));
                    list.add(ct);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void main(String[] args) {
        try {
            HoaDonNhap_DAO250 dao = new HoaDonNhap_DAO250();
            List<HoaDonNhap250> list = dao.getListHDNByNCC("NCC001", Date.valueOf("2024-10-01"), Date.valueOf("2024-10-31"));
            System.out.println("Danh sách hóa đơn nhập NCC001: " + list.size());
            for (HoaDonNhap250 hdn : list) {
                System.out.println(" - " + hdn.getId() + " | " + hdn.getNgayNhap() + " | SL: " + hdn.getTongSoLuong() + " | Tiền: " + hdn.getTongTien());
            }

            List<HDNChiTiet250> details = dao.getChiTietHDN("HDN001");
            System.out.println("Chi tiết HDN001: " + details.size() + " mặt hàng.");
            for (HDNChiTiet250 ct : details) {
                System.out.println("   * " + ct.getTenMatHang() + " | SL: " + ct.getSoLuong() + " | Giá nhập: " + ct.getGiaNhap() + " | Thành tiền: " + ct.getThanhTien());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

