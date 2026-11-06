package Entity250;

import java.io.Serializable;

public class HDNChiTiet250 implements Serializable {
    private int id;
    private String maHDN;
    private String matHangId;
    private String tenMatHang;
    private String donViTinh;
    private int soLuong;
    private double giaNhap;
    private double thanhTien;

    public HDNChiTiet250() {}

    public HDNChiTiet250(int id, String maHDN, String matHangId, String tenMatHang, String donViTinh, int soLuong, double giaNhap, double thanhTien) {
        this.id = id;
        this.maHDN = maHDN;
        this.matHangId = matHangId;
        this.tenMatHang = tenMatHang;
        this.donViTinh = donViTinh;
        this.soLuong = soLuong;
        this.giaNhap = giaNhap;
        this.thanhTien = thanhTien;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getMaHDN() { return maHDN; }
    public void setMaHDN(String maHDN) { this.maHDN = maHDN; }

    public String getMatHangId() { return matHangId; }
    public void setMatHangId(String matHangId) { this.matHangId = matHangId; }

    public String getTenMatHang() { return tenMatHang; }
    public void setTenMatHang(String tenMatHang) { this.tenMatHang = tenMatHang; }

    public String getDonViTinh() { return donViTinh; }
    public void setDonViTinh(String donViTinh) { this.donViTinh = donViTinh; }

    public int getSoLuong() { return soLuong; }
    public void setSoLuong(int soLuong) { this.soLuong = soLuong; }

    public double getGiaNhap() { return giaNhap; }
    public void setGiaNhap(double giaNhap) { this.giaNhap = giaNhap; }

    public double getThanhTien() { return thanhTien; }
    public void setThanhTien(double thanhTien) { this.thanhTien = thanhTien; }
}

