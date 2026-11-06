
package Entity250;


import java.sql.Date;

public class KhachHang_250 {
    private int id;
    private String hoTen;
    private String sdt;
    private String email;  
    private Date ngaySinh;
    private String password;
    private String maKH;
    private int sieuthiId;

    public KhachHang_250() {}

    public KhachHang_250(int id, String hoTen, String sdt, String email, Date ngaySinh, String password, String maKH, int sieuthiId) {
        this.id = id;
        this.hoTen = hoTen;
        this.sdt = sdt;
        this.email = email;
        this.ngaySinh = ngaySinh;
        this.password = password;
        this.maKH = maKH;
        this.sieuthiId = sieuthiId;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getHoTen() { return hoTen; }
    public void setHoTen(String hoTen) { this.hoTen = hoTen; }

    public String getSdt() { return sdt; }
    public void setSdt(String sdt) { this.sdt = sdt; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public Date getNgaySinh() { return ngaySinh; }
    public void setNgaySinh(Date ngaySinh) { this.ngaySinh = ngaySinh; }

    public String getMaKH() { return maKH; }
    public void setMaKH(String maKH) { this.maKH = maKH; }



    public int getSieuthiId() { return sieuthiId; }
    public void setSieuthiId(int sieuThiId) { this.sieuthiId = sieuthiId; }
}
