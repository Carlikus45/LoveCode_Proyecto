package com.example.model;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class Usuariotest {

    @Test
    void testSetNombre() {
        Usuario u = new Usuario();
        u.setNombre("Carlos");
        assertEquals("Carlos", u.getNombre());
    }

    @Test
    void testSetEmail() {
        Usuario u = new Usuario();
        u.setEmail("carlos@lovecode.com");
        assertEquals("carlos@lovecode.com", u.getEmail());
    }
    @Test
    void testTecnologiasEmpiezaVacia() {
        Usuario u = new Usuario();
        assertNotNull(u.getTecnologias());
        assertTrue(u.getTecnologias().isEmpty());
    }
}