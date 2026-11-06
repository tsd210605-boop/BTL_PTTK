package Entity250;

import java.io.Serializable;

public class NhaCungCap250 implements Serializable {
    private String id;
    private String maNCC;
    private String ten;
    private String diaChi;
    private String sdt;
    private String email;
    private String mota;

    public NhaCungCap250() {}

    public NhaCungCap250(String id, String maNCC, String ten, String diaChi, String sdt, String email, String mota) {
        this.id = id;
        this.maNCC = maNCC;
        this.ten = ten;
        this.diaChi = diaChi;
        this.sdt = sdt;
        this.email = email;
        this.mota = mota;
    }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getMaNCC() { return maNCC; }
    public void setMaNCC(String maNCC) { this.maNCC = maNCC; }

    public String getTen() { return ten; }
    public void setTen(String ten) { this.ten = ten; }

    public String getDiaChi() { return diaChi; }
    public void setDiaChi(String diaChi) { this.diaChi = diaChi; }

    public String getSdt() { return sdt; }
    public void setSdt(String sdt) { this.sdt = sdt; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getMota() { return mota; }
    public void setMota(String mota) { this.mota = mota; }
}

