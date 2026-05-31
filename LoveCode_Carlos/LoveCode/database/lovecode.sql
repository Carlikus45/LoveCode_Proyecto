DROP DATABASE IF EXISTS LoveCode;
CREATE DATABASE LoveCode CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE LoveCode;

CREATE TABLE Usuarios (
    id             INT AUTO_INCREMENT PRIMARY KEY,
    nombre         VARCHAR(100) NOT NULL,
    email          VARCHAR(150) NOT NULL UNIQUE,
    password       VARCHAR(255) NOT NULL,
    descripcion    TEXT,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Tecnologias (
    id     INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Usuarios_Tecnologias (
    id_usuario    INT NOT NULL,
    id_tecnologia INT NOT NULL,
    PRIMARY KEY (id_usuario, id_tecnologia),
    FOREIGN KEY (id_usuario)    REFERENCES Usuarios(id)    ON DELETE CASCADE,
    FOREIGN KEY (id_tecnologia) REFERENCES Tecnologias(id) ON DELETE CASCADE
);

CREATE TABLE Likes (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    id_emisor   INT NOT NULL,
    id_receptor INT NOT NULL,
    fecha       DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY unico_like (id_emisor, id_receptor),
    FOREIGN KEY (id_emisor)   REFERENCES Usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (id_receptor) REFERENCES Usuarios(id) ON DELETE CASCADE
);

CREATE TABLE Matches (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario1 INT NOT NULL,
    id_usuario2 INT NOT NULL,
    fecha       DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY unico_match (id_usuario1, id_usuario2),
    FOREIGN KEY (id_usuario1) REFERENCES Usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario2) REFERENCES Usuarios(id) ON DELETE CASCADE
);

DELIMITER $$

CREATE TRIGGER generar_match
AFTER INSERT ON Likes
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1 FROM Likes
        WHERE id_emisor   = NEW.id_receptor
          AND id_receptor = NEW.id_emisor
    ) THEN
        INSERT IGNORE INTO Matches (id_usuario1, id_usuario2)
        VALUES (
            LEAST(NEW.id_emisor, NEW.id_receptor),
            GREATEST(NEW.id_emisor, NEW.id_receptor)
        );
    END IF;
END$$

DELIMITER ;

CREATE USER IF NOT EXISTS 'carlos'@'%'        IDENTIFIED BY '1234';
CREATE USER IF NOT EXISTS 'desarrollador'@'%' IDENTIFIED BY '1234';
CREATE USER IF NOT EXISTS 'lector'@'%'        IDENTIFIED BY '1234';

GRANT ALL PRIVILEGES                 ON LoveCode.* TO 'carlos'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON LoveCode.* TO 'desarrollador'@'%';
GRANT SELECT                         ON LoveCode.* TO 'lector'@'%';

FLUSH PRIVILEGES;

DELIMITER $$

CREATE PROCEDURE ContarMatches(IN p_id INT)
BEGIN
    SELECT COUNT(*) AS total_matches
    FROM Matches
    WHERE id_usuario1 = p_id OR id_usuario2 = p_id;
END$$

CREATE PROCEDURE CargarUsuario(IN p_id INT)
BEGIN
    SELECT u.id, u.nombre, u.email, u.descripcion, u.fecha_registro,
           GROUP_CONCAT(t.nombre ORDER BY t.nombre SEPARATOR ', ') AS tecnologias
    FROM Usuarios u
    LEFT JOIN Usuarios_Tecnologias ut ON ut.id_usuario = u.id
    LEFT JOIN Tecnologias t           ON t.id = ut.id_tecnologia
    WHERE u.id = p_id
    GROUP BY u.id;
END$$

CREATE PROCEDURE BorrarUsuario(IN p_id INT)
BEGIN
    DELETE FROM Usuarios WHERE id = p_id;
END$$

DELIMITER ;

INSERT INTO Tecnologias (nombre) VALUES
    ('Java'), ('Python'), ('JavaScript'), ('SQL'), ('HTML'),
    ('CSS'), ('Spring Boot'), ('React'), ('Git'), ('Linux');

INSERT INTO Usuarios (nombre, email, password, descripcion) VALUES
    ('Carlos Lopez',   'carlos@lovecode.com', '1234', 'Frontend lover, React y CSS.'),
    ('Ana Garcia',     'ana@lovecode.com',    '1234', 'Backend con Java y Spring Boot.'),
    ('Laura Martinez', 'laura@lovecode.com',  '1234', 'Fullstack, Python y JavaScript.'),
    ('David Torres',   'david@lovecode.com',  '1234', 'DBA, SQL y Linux.'),
    ('Marta Ruiz',     'marta@lovecode.com',  '1234', 'DevOps, Git y automatizacion.');

INSERT INTO Usuarios_Tecnologias (id_usuario, id_tecnologia) VALUES
    (1,3),(1,5),(1,6),(1,8),
    (2,1),(2,4),(2,7),(2,9),
    (3,2),(3,3),(3,4),(3,9),
    (4,4),(4,10),(4,1),
    (5,9),(5,10),(5,3);

INSERT INTO Likes (id_emisor, id_receptor) VALUES (1, 2);
INSERT INTO Likes (id_emisor, id_receptor) VALUES (2, 1);
INSERT INTO Likes (id_emisor, id_receptor) VALUES (3, 1);
INSERT INTO Likes (id_emisor, id_receptor) VALUES (4, 5);
INSERT INTO Likes (id_emisor, id_receptor) VALUES (5, 4);
