package DAO250;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class DAO250 {

    private static Connection con;

    public DAO250() throws ClassNotFoundException {
        try {
            // Nạp driver MySQL
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
            } catch (ClassNotFoundException e) {
                Class.forName("com.mysql.jdbc.Driver");
            }

            // Cấu hình kết nối MySQL
            String user = "root";
            String password = "123456"; 
            String url250 = "jdbc:mysql://localhost:3306/12_qlst_250?useUnicode=true&characterEncoding=utf8&useSSL=false&allowPublicKeyRetrieval=true";
            try {
                con = DriverManager.getConnection(url250, user, password);
                System.out.println("Kết nối thành công đến CSDL 12_qlst_250");
            } catch (SQLException exDb) {
                String fallbackUrl = "jdbc:mysql://localhost:3306/12_qlst_726?useUnicode=true&characterEncoding=utf8&useSSL=false&allowPublicKeyRetrieval=true";
                con = DriverManager.getConnection(fallbackUrl, user, password);
                System.out.println("Kết nối thành công đến CSDL dự phòng 12_qlst_726");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Kết nối thất bại: " + e.getMessage());
        }
    }

    public static Connection getConnection() {
        return con;
    }

    public static void main(String[] args) {
        try {
            DAO250 dao = new DAO250();
            if (dao.getConnection() != null) {
                System.out.println("Kết nối hợp lệ!");
            } else {
                System.out.println("Kết nối không hợp lệ!");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            System.err.println("Driver không được tìm thấy!");
        }
    }
}

