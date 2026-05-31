package com.example.resources;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;


@Component
public class App implements CommandLineRunner {


    @Autowired
    private JdbcTemplate jdbc;

    @Override
    public void run(String... args) {

        Integer ok = jdbc.queryForObject("SELECT 1", Integer.class);
        System.out.println("Conexión exitosa a LoveCode: " + ok);


        listarUsuarios();
    }

    void listarUsuarios() {
        List<Map<String, Object>> usuarios = jdbc.queryForList("SELECT * FROM Usuarios");
        System.out.println("Usuarios registrados:");
        for (Map<String, Object> u : usuarios) {
            System.out.println("- " + u.get("nombre") + " (" + u.get("email") + ")");
        }
    }
}
