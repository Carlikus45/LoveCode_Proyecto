package com.example;
import java.sql.Connection;
import java.sql.DriverManager;

public class Conexion {
    public static void main(String[] args) {

        String host = "localhost";

        int puerto = 3308;

        String baseDatos = "LoveCode";

        String usuario = "root";

        String contrasena = "1234";

        String url = "jdbc:mariadb://" + host + ":" + puerto + "/" + baseDatos;

        try {
            Connection conn = DriverManager.getConnection(url, usuario, contrasena);
            System.out.println("Conexión exitosa a " + baseDatos);
            conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}

