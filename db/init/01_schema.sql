DROP DATABASE IF EXISTS eurekabank;
CREATE DATABASE eurekabank CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE eurekabank;

CREATE TABLE tipomovimiento (
    chr_tipocodigo CHAR(3) NOT NULL,
    vch_tipodescripcion VARCHAR(40) NOT NULL,
    vch_tipoaccion VARCHAR(10) NOT NULL,
    vch_tipoestado VARCHAR(15) DEFAULT 'ACTIVO' NOT NULL,
    PRIMARY KEY (chr_tipocodigo)
) ENGINE = INNODB;

CREATE TABLE sucursal (
    chr_sucucodigo CHAR(3) NOT NULL,
    vch_sucunombre VARCHAR(50) NOT NULL,
    vch_sucuciudad VARCHAR(30) NOT NULL,
    vch_sucudireccion VARCHAR(50) NULL,
    int_sucucontcuenta INTEGER NOT NULL,
    PRIMARY KEY (chr_sucucodigo)
) ENGINE = INNODB;

CREATE TABLE empleado (
    chr_emplcodigo CHAR(4) NOT NULL,
    vch_emplpaterno VARCHAR(25) NOT NULL,
    vch_emplmaterno VARCHAR(25) NOT NULL,
    vch_emplnombre VARCHAR(30) NOT NULL,
    vch_emplciudad VARCHAR(30) NOT NULL,
    vch_empldireccion VARCHAR(50) NULL,
    PRIMARY KEY (chr_emplcodigo)
) ENGINE = INNODB;

CREATE TABLE modulo (
    int_moducodigo INTEGER NOT NULL,
    vch_modunombre VARCHAR(50) NULL,
    vch_moduestado VARCHAR(15) NOT NULL DEFAULT 'ACTIVO',
    PRIMARY KEY (int_moducodigo)
) ENGINE = INNODB;

CREATE TABLE usuario (
    chr_emplcodigo CHAR(4) NOT NULL,
    vch_emplusuario VARCHAR(20) NOT NULL,
    vch_emplclave VARCHAR(50) NOT NULL,
    vch_emplestado VARCHAR(15) NULL DEFAULT 'ACTIVO',
    PRIMARY KEY (chr_emplcodigo),
    UNIQUE KEY (vch_emplusuario),
    FOREIGN KEY (chr_emplcodigo) REFERENCES empleado (chr_emplcodigo)
) ENGINE = INNODB;

CREATE TABLE permiso (
    chr_emplcodigo CHAR(4) NOT NULL,
    int_moducodigo INTEGER NOT NULL,
    vch_permestado VARCHAR(15) NOT NULL DEFAULT 'ACTIVO',
    PRIMARY KEY (chr_emplcodigo, int_moducodigo),
    FOREIGN KEY (int_moducodigo) REFERENCES modulo (int_moducodigo),
    FOREIGN KEY (chr_emplcodigo) REFERENCES usuario (chr_emplcodigo)
) ENGINE = INNODB;

CREATE TABLE logsession (
    id INT NOT NULL AUTO_INCREMENT,
    chr_emplcodigo CHAR(4) NOT NULL,
    fec_ingreso DATETIME NOT NULL,
    fec_salida DATETIME NULL,
    ip VARCHAR(20) NOT NULL DEFAULT 'NONE',
    hostname VARCHAR(100) NOT NULL DEFAULT 'NONE',
    PRIMARY KEY (id),
    FOREIGN KEY (chr_emplcodigo) REFERENCES empleado (chr_emplcodigo)
) ENGINE = INNODB;

CREATE TABLE asignado (
    chr_asigcodigo CHAR(6) NOT NULL,
    chr_sucucodigo CHAR(3) NOT NULL,
    chr_emplcodigo CHAR(4) NOT NULL,
    dtt_asigfechaalta DATE NOT NULL,
    dtt_asigfechabaja DATE NULL,
    PRIMARY KEY (chr_asigcodigo),
    KEY idx_asignado01 (chr_emplcodigo),
    KEY idx_asignado02 (chr_sucucodigo),
    FOREIGN KEY (chr_emplcodigo) REFERENCES empleado (chr_emplcodigo),
    FOREIGN KEY (chr_sucucodigo) REFERENCES sucursal (chr_sucucodigo)
) ENGINE = INNODB;

CREATE TABLE cliente (
    chr_cliecodigo CHAR(5) NOT NULL,
    vch_cliepaterno VARCHAR(25) NOT NULL,
    vch_cliematerno VARCHAR(25) NOT NULL,
    vch_clienombre VARCHAR(30) NOT NULL,
    chr_cliedni CHAR(8) NOT NULL,
    vch_clieciudad VARCHAR(30) NOT NULL,
    vch_cliedireccion VARCHAR(50) NOT NULL,
    vch_clietelefono VARCHAR(20) NULL,
    vch_clieemail VARCHAR(50) NULL,
    PRIMARY KEY (chr_cliecodigo)
) ENGINE = INNODB;

CREATE TABLE moneda (
    chr_monecodigo CHAR(2) NOT NULL,
    vch_monedescripcion VARCHAR(20) NOT NULL,
    PRIMARY KEY (chr_monecodigo)
) ENGINE = INNODB;

CREATE TABLE cuenta (
    chr_cuencodigo CHAR(8) NOT NULL,
    chr_monecodigo CHAR(2) NOT NULL,
    chr_sucucodigo CHAR(3) NOT NULL,
    chr_emplcreacuenta CHAR(4) NOT NULL,
    chr_cliecodigo CHAR(5) NOT NULL,
    dec_cuensaldo DECIMAL(12,2) NOT NULL,
    dtt_cuenfechacreacion DATE NOT NULL,
    vch_cuenestado VARCHAR(15) DEFAULT 'ACTIVO' NOT NULL,
    int_cuencontmov INTEGER NOT NULL,
    chr_cuenclave CHAR(6) NOT NULL,
    PRIMARY KEY (chr_cuencodigo),
    FOREIGN KEY (chr_cliecodigo) REFERENCES cliente (chr_cliecodigo),
    FOREIGN KEY (chr_emplcreacuenta) REFERENCES empleado (chr_emplcodigo),
    FOREIGN KEY (chr_sucucodigo) REFERENCES sucursal (chr_sucucodigo),
    FOREIGN KEY (chr_monecodigo) REFERENCES moneda (chr_monecodigo)
) ENGINE = INNODB;

CREATE TABLE movimiento (
    chr_cuencodigo CHAR(8) NOT NULL,
    int_movinumero INTEGER NOT NULL,
    dtt_movifecha DATE NOT NULL,
    chr_emplcodigo CHAR(4) NOT NULL,
    chr_tipocodigo CHAR(3) NOT NULL,
    dec_moviimporte DECIMAL(12,2) NOT NULL,
    chr_cuenreferencia CHAR(8) NULL,
    PRIMARY KEY (chr_cuencodigo, int_movinumero),
    FOREIGN KEY (chr_tipocodigo) REFERENCES tipomovimiento (chr_tipocodigo),
    FOREIGN KEY (chr_emplcodigo) REFERENCES empleado (chr_emplcodigo),
    FOREIGN KEY (chr_cuencodigo) REFERENCES cuenta (chr_cuencodigo)
) ENGINE = INNODB;

CREATE TABLE parametro (
    chr_paracodigo CHAR(3) NOT NULL,
    vch_paradescripcion VARCHAR(50) NOT NULL,
    vch_paravalor VARCHAR(70) NOT NULL,
    vch_paraestado VARCHAR(15) DEFAULT 'ACTIVO' NOT NULL,
    PRIMARY KEY (chr_paracodigo)
) ENGINE = INNODB;

CREATE TABLE interesmensual (
    chr_monecodigo CHAR(2) NOT NULL,
    dec_inteimporte DECIMAL(12,2) NOT NULL,
    PRIMARY KEY (chr_monecodigo),
    FOREIGN KEY (chr_monecodigo) REFERENCES moneda (chr_monecodigo)
) ENGINE = INNODB;

CREATE TABLE costomovimiento (
    chr_monecodigo CHAR(2) NOT NULL,
    dec_costimporte DECIMAL(12,2) NOT NULL,
    PRIMARY KEY (chr_monecodigo),
    FOREIGN KEY (chr_monecodigo) REFERENCES moneda (chr_monecodigo)
) ENGINE = INNODB;

CREATE TABLE cargomantenimiento (
    chr_monecodigo CHAR(2) NOT NULL,
    dec_cargMontoMaximo DECIMAL(12,2) NOT NULL,
    dec_cargImporte DECIMAL(12,2) NOT NULL,
    PRIMARY KEY (chr_monecodigo),
    FOREIGN KEY (chr_monecodigo) REFERENCES moneda (chr_monecodigo)
) ENGINE = INNODB;

CREATE TABLE contador (
    vch_conttabla VARCHAR(30) NOT NULL,
    int_contitem INTEGER NOT NULL,
    int_contlongitud INTEGER NOT NULL,
    PRIMARY KEY (vch_conttabla)
) ENGINE = INNODB;
