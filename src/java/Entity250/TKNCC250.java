package Entity250;

import java.io.Serializable;
import java.sql.Date;

public class TKNCC250 extends NhaCungCap250 implements Serializable {
    private int soLanNhap;
    private int tongSoLuongNhap;
    private double tongGiaTriNhap;
    private Date ngayBatDau;
    private Date ngayKetThuc;

    public TKNCC250() {
        super();
    }

    public TKNCC250(String id, String maNCC, String ten, String diaChi, String sdt, String email, String mota,
                    int soLanNhap, int tongSoLuongNhap, double tongGiaTriNhap, Date ngayBatDau, Date ngayKetThuc) {
        super(id, maNCC, ten, diaChi, sdt, email, mota);
        this.soLanNhap = soLanNhap;
        this.tongSoLuongNhap = tongSoLuongNhap;
        this.tongGiaTriNhap = tongGiaTriNhap;
        this.ngayBatDau = ngayBatDau;
        this.ngayKetThuc = ngayKetThuc;
    }

    public int getSoLanNhap() { return soLanNhap; }
    public void setSoLanNhap(int soLanNhap) { this.soLanNhap = soLanNhap; }

    public int getTongSoLuongNhap() { return tongSoLuongNhap; }
    public void setTongSoLuongNhap(int tongSoLuongNhap) { this.tongSoLuongNhap = tongSoLuongNhap; }

    public double getTongGiaTriNhap() { return tongGiaTriNhap; }
    public void setTongGiaTriNhap(double tongGiaTriNhap) { this.tongGiaTriNhap = tongGiaTriNhap; }

    public Date getNgayBatDau() { return ngayBatDau; }
    public void setNgayBatDau(Date ngayBatDau) { this.ngayBatDau = ngayBatDau; }

    public Date getNgayKetThuc() { return ngayKetThuc; }
    public void setNgayKetThuc(Date ngayKetThuc) { this.ngayKetThuc = ngayKetThuc; }
}

