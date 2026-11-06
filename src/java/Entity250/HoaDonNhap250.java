package Entity250;

import java.io.Serializable;
import java.sql.Date;
import java.util.List;

public class HoaDonNhap250 implements Serializable {
    private String id; // Mã hóa đơn nhập
    private Date ngayNhap;
    private int tongSoLuong;
    private double tongTien;
    private String nhaCungCapId;
    private String tenNCC;
    private int maNVK;
    private String tenNVK;
    private List<HDNChiTiet250> listChiTiet;

    public HoaDonNhap250() {}

    public HoaDonNhap250(String id, Date ngayNhap, int tongSoLuong, double tongTien, String nhaCungCapId, String tenNCC, int maNVK, String tenNVK) {
        this.id = id;
        this.ngayNhap = ngayNhap;
        this.tongSoLuong = tongSoLuong;
        this.tongTien = tongTien;
        this.nhaCungCapId = nhaCungCapId;
        this.tenNCC = tenNCC;
        this.maNVK = maNVK;
        this.tenNVK = tenNVK;
    }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public Date getNgayNhap() { return ngayNhap; }
    public void setNgayNhap(Date ngayNhap) { this.ngayNhap = ngayNhap; }

    public int getTongSoLuong() { return tongSoLuong; }
    public void setTongSoLuong(int tongSoLuong) { this.tongSoLuong = tongSoLuong; }

    public double getTongTien() { return tongTien; }
    public void setTongTien(double tongTien) { this.tongTien = tongTien; }

    public String getNhaCungCapId() { return nhaCungCapId; }
    public void setNhaCungCapId(String nhaCungCapId) { this.nhaCungCapId = nhaCungCapId; }

    public String getTenNCC() { return tenNCC; }
    public void setTenNCC(String tenNCC) { this.tenNCC = tenNCC; }

    public int getMaNVK() { return maNVK; }
    public void setMaNVK(int maNVK) { this.maNVK = maNVK; }

    public String getTenNVK() { return tenNVK; }
    public void setTenNVK(String tenNVK) { this.tenNVK = tenNVK; }

    public List<HDNChiTiet250> getListChiTiet() { return listChiTiet; }
    public void setListChiTiet(List<HDNChiTiet250> listChiTiet) { this.listChiTiet = listChiTiet; }
}

