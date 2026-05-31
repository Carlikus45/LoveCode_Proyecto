# LoveCode — Web Edition

App tipo Tinder para desarrolladores.
Te registras con tus tecnologias, ves perfiles de otros y das likes.
Si dos usuarios se dan like mutuamente, sale un match automatico.

## Tecnologias

- Base de datos: MariaDB (IP: LocalHost, usuario: root)
- Backend: Java 17 + Spring Boot
- Frontend: HTML, CSS y JavaScript 
- Build: Maven

## Estructura


LoveCode/
├── backend/
│   ├── pom.xml
│   └── src/main/java/com/example/
│       ├── Main.java                          -> arranca el servidor
│       ├── resources/App.java                 -> hereda la conexion original
│       ├── model/Usuario.java                 -> clase de la tabla Usuarios
│       ├── repository/UsuarioRepository.java  -> consultas a la BD
│       └── controller/UsuarioController.java  -> rutas del servidor
├── frontend/
│   ├── index.html      -> login 
│   ├── registro.html   -> registro con tecnologias
│   ├── perfiles.html   -> tarjetas con likes y modal de match
│   ├── match.xsl       -> transformacion XSLT para la ficha de match
│   ├── match.xml       -> ejemplo de XML de match
│   ├── tests.html      -> ejecuta las pruebas en el navegador
│   ├── tests.js        -> pruebas unitarias
│   └── style.css       -> el CSS 
├── database/
│   └── lovecode.sql    -> script SQL completo
│   
└── README.md

