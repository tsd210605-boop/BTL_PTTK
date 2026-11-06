package Entity250;

import java.io.Serializable;

public class MatHang250 implements Serializable {
    private String id;
    private String ten;
    private double gia;
    private String donViTinh;
    private String mota;
    private String nhaCungCapId;
    private String tenNCC;
    private int soLuongTon;
    private String diaChiNCC;
    private String sdtNCC;
    private String emailNCC;

    public MatHang250() {}

    public MatHang250(String id, String ten, double gia, String donViTinh, String mota, String nhaCungCapId, String tenNCC, int soLuongTon) {
        this.id = id;
        this.ten = ten;
        this.gia = gia;
        this.donViTinh = donViTinh;
        this.mota = mota;
        this.nhaCungCapId = nhaCungCapId;
        this.tenNCC = tenNCC;
        this.soLuongTon = soLuongTon;
    }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getTen() { return ten; }
    public void setTen(String ten) { this.ten = ten; }

    public double getGia() { return gia; }
    public void setGia(double gia) { this.gia = gia; }

    public String getDonViTinh() { return donViTinh; }
    public void setDonViTinh(String donViTinh) { this.donViTinh = donViTinh; }

    public String getMota() { return mota; }
    public void setMota(String mota) { this.mota = mota; }

    public String getNhaCungCapId() { return nhaCungCapId; }
    public void setNhaCungCapId(String nhaCungCapId) { this.nhaCungCapId = nhaCungCapId; }

    public String getTenNCC() { return tenNCC; }
    public void setTenNCC(String tenNCC) { this.tenNCC = tenNCC; }

    public int getSoLuongTon() { return soLuongTon; }
    public void setSoLuongTon(int soLuongTon) { this.soLuongTon = soLuongTon; }

    public String getDiaChiNCC() { return diaChiNCC; }
    public void setDiaChiNCC(String diaChiNCC) { this.diaChiNCC = diaChiNCC; }

    public String getSdtNCC() { return sdtNCC; }
    public void setSdtNCC(String sdtNCC) { this.sdtNCC = sdtNCC; }

    public String getEmailNCC() { return emailNCC; }
    public void setEmailNCC(String emailNCC) { this.emailNCC = emailNCC; }
}

