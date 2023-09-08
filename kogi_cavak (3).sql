-- Active: 1692386688304@@127.0.0.1@3306@phpmyadmin

create database Kogi_cavak;

use Kogi_cavak; 

create table Tipo_documento (
    Cod_tdoc varchar(5) PRIMARY key not null,
    Desc_tdoc varchar (45) not null
);

create table Usuarios(
pk_fk_tdoc varchar(5) not null,
id_usuario int not null,
primer_nombre varchar(25) not null,
segundo_nombre varchar(25),
primer_apellido varchar(25) not null,
segundo_apellido varchar(25),
direccion_usuario varchar(25) not null,
primary key (pk_fk_tdoc, id_usuario)
);

Alter table Usuarios
add foreign key (pk_fk_tdoc)
references Tipo_documento (Cod_tdoc);

create table Roles(
cod_rol int primary key not null,
desc_rol Varchar(30) not null
);


create table Usuario_has_roles(
Usuario_tdoc varchar(5) not null,
Usuario_id int not null,
Usuario_rol int not  null,
estado_rol boolean not  null,
primary key (Usuario_tdoc, Usuario_id, Usuario_rol)
);

Alter table Usuario_has_roles
add foreign key (Usuario_tdoc, Usuario_id)
references Usuarios (pk_fk_tdoc, id_usuario);
Alter table Usuario_has_roles
add foreign key (Usuario_rol)
references Roles (cod_rol);

create table Cliente(
tdoc_cliente varchar(5) not null,
id_cliente int not null,
Email_cliente varchar (45)not null,
primary key (tdoc_cliente, id_cliente)
);

Alter table Cliente
add foreign key (tdoc_cliente, id_cliente)
references Usuarios (pk_fk_tdoc, id_usuario);


create table Empleado(
tdoc_empleado varchar(5) not null,
id_empleado int not null,
horaro_ingreso_emp time not null,
horario_salida_emp time not null,
sueldo_empleado double not null,
primary key (tdoc_empleado, id_empleado)
);

Alter table Empleado
add foreign key (tdoc_empleado, id_empleado)
references Usuarios (pk_fk_tdoc, id_usuario);


CREATE TABLE Registrarse (
    Id_usuario varchar(25) NOT NULL,
    Rol_fk_usuario int NOT NULL,
    Nomb_usuario varchar(25) NOT NULL,
    Primer_nombre varchar(25) NOT NULL,
    Primer_apellido varchar(25) NOT NULL,
    Contraseña_hash varchar(60) NOT NULL, -- El hash de la contraseña se almacena aquí (60 caracteres)
    Rep_Contraseña_hash varchar(60) NOT NULL,
    Telefono_usuario varchar(25) NOT NULL,
    Correo_usuario varchar(25) NOT NULL,
    primary key (Id_usuario, Rol_fk_usuario)
);
Alter table Registrarse
add foreign key (Rol_fk_usuario)
references Roles (cod_rol);

CREATE TABLE Iniciar_sesión (
    Id_usuario varchar(25) NOT NULL,
    Rol_fk_usuario int NOT NULL,
    Nomb_usuario varchar(25) NOT NULL,
    Contraseña_hash varchar(60) NOT NULL, -- El hash de la contraseña se almacena aquí (60 caracteres)
    primary key (Id_usuario)
);

Alter table Iniciar_sesión 
add foreign key (Id_usuario)
references Registrarse (Id_usuario);

create table Tipo_producto(
tipo_prod varchar(20) primary key not null,
estado_tprod boolean not null
);

create table Colecciones(
    id_colecciones varchar (5) primary key not null,
    año_coleccion date not null,
    nombre_coleccion varchar (45) not null
);

create table Productos(
    codigo_prod varchar (10) primary key not null,
    nombre_prod varchar (45) not null,
    desc_prod varchar(45) not null,
    pedreria_prod varchar (25) not null, 
    material_prod varchar (45) not null,
    precio_por_unidad decimal not null,
    fk_id_colecciones varchar (5) not null,
    fk_tipo_prod varchar(20) not null
);

Alter table Productos
add foreign key (fk_tipo_prod)
references Tipo_producto (tipo_prod);

Alter table Productos
add foreign key (fk_id_colecciones)
references Colecciones (id_colecciones);


create Table Producto_has_empleado (
    fk_pk_codigo_prod varchar(10) not null,
    fk_pk_id_empleado int not null,
    horas_por_prod decimal(10, 2),
    primary key (fk_pk_codigo_prod, fk_pk_id_empleado)
);


Alter table Producto_has_empleado
add foreign key (fk_pk_codigo_prod)
references Productos (codigo_prod);


create table Garantia (
    id_garantia int not null,
    fk_pk_codigo_prod varchar (10) not null,
    Tiempo_garantia varchar (10) not null,
    desc_valides_garnt varchar (100) not null,
    primary key (id_garantia, fk_pk_codigo_prod)
); 

Alter table Garantia
add foreign key (fk_pk_codigo_prod)
references Productos (codigo_prod);

create table Stocks(
    id_stocks int not null,
    fk_pk_codigo_prod varchar (10) not null,
    unidades_disponibles decimal not null,
    fecha_inicio_disp date not null,
    primary key (id_stocks, fk_pk_codigo_prod)
);

Alter table Stocks
add foreign key (fk_pk_codigo_prod)
references Productos (codigo_prod);

create table Factura (
    N_factura int primary key not null,
    empleado_tdoc_v varchar(5) not null,
    empleado_id_v int not null,
    cliente_tdoc varchar(5) not null,
    cliente_id int not null,
    Fecha_factura date not null,
    SubTotal double not null,
    IVA double not null,
    Total_factura double not null
);

UPDATE Factura
SET Total_factura = SubTotal + IVA;


Alter table Factura
add foreign key (cliente_tdoc, cliente_id)
references Cliente (tdoc_cliente, id_cliente);
Alter table Factura
add foreign key (empleado_tdoc_v, empleado_id_v)
references Empleado (tdoc_empleado, id_empleado);


create table Factura_productos(
fk_pk_factura int not null,
fk_pk_cod_producto varchar (10) not null,
cantidad_prod int not null,
valor_prod_cant double not null,
primary key (fk_pk_factura, fk_pk_cod_producto)
);

Alter table Factura_productos
add foreign key (fk_pk_factura)
references Factura (n_factura);
Alter table Factura_productos
add foreign key (fk_pk_cod_producto)
references Productos (codigo_prod);


INSERT INTO Tipo_documento (Cod_tdoc, Desc_tdoc)
VALUES
('C.C.', 'Cedula de ciudadania'),
('T.I.', 'Tarjeta de identidad'),
('C.E.', 'Cedula de extranjeria');


-- Inserción de datos en Usuarios (continuación)
INSERT INTO Usuarios (pk_fk_tdoc, id_usuario, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, direccion_usuario)
VALUES
('C.C.', 1, 'Juan', 'Pablo', 'Rodríguez', 'Gómez', 'Calle Falsa #123'),
('T.I.', 2, 'María', 'Isabel', 'López', 'Martínez', 'Avenida Imaginaria #456'),
('C.E.', 3, 'Carlos', NULL, 'Pérez', 'Fernández', 'Carrera Irreal #789'),
('C.C.', 4, 'Ana', 'María', 'González', 'Ramírez', 'Calle Ficticia #234'),
('T.I.', 5, 'Luis', 'Miguel', 'Hernández', 'Pérez', 'Avenida Imaginada #567'),
('C.E.', 6, 'Laura', NULL, 'Díaz', 'Sánchez', 'Carrera Irreal #890'),
('C.C.', 7, 'Andrés', 'Felipe', 'Martínez', 'López', 'Calle Falsa #345'),
('T.I.', 8, 'Diana', 'Carolina', 'Soto', 'Gómez', 'Avenida Inventada #678'),
('C.E.', 9, 'Jorge', NULL, 'Vargas', 'Fernández', 'Carrera Imaginaria #901'),
('C.C.', 10, 'Sofía', 'Valentina', 'Ramírez', 'Rodríguez', 'Calle de Ensueño #456'),
('T.I.', 11, 'Diego', 'Alejandro', 'Pérez', 'Sánchez', 'Avenida Irreal #789'),
('C.E.', 12, 'Mónica', NULL, 'Gómez', 'Hernández', 'Carrera Ficticia #123'),
('C.C.', 13, 'Andrea', 'Camila', 'López', 'González', 'Calle de Sueños #567'),
('T.I.', 14, 'Miguel', 'Ángel', 'Fernández', 'Díaz', 'Avenida Falsa #890'),
('C.E.', 15, 'Carolina', NULL, 'Sánchez', 'Martínez', 'Carrera de Fantasía #234');

-- Inserción de datos en Roles
INSERT INTO Roles (cod_rol, desc_rol)
VALUES
(1, 'Empleado'),
(2, 'Cliente');
-- Inserción de datos en Usuario_has_roles (continuación)
INSERT INTO Usuario_has_roles (Usuario_tdoc, Usuario_id, Usuario_rol, estado_rol)
VALUES
('C.C.', 1, 1, true),
('T.I.', 2, 1, true),
('C.E.', 3, 1, true),
('C.C.', 4, 1, true),
('T.I.', 5, 1, true),
('C.E.', 6, 1, true),
('C.C.', 7, 1, true),
('T.I.', 8, 1, true),
('C.E.', 9, 1, true),
('C.C.', 10, 1, true),
('T.I.', 11, 2, true),
('C.E.', 12, 2, true),
('C.C.', 13, 2, true),
('T.I.', 14, 2, true),
('C.E.', 15, 2, true);


-- Inserción de datos en Cliente (continuación)
INSERT INTO Cliente (tdoc_cliente, id_cliente, Email_cliente)
VALUES
('C.C.', 1, 'cliente1@example.com'),
('T.I.', 2, 'cliente2@example.com'),
('C.E.', 3, 'cliente3@example.com'),
('C.C.', 4, 'cliente4@example.com'),
('T.I.', 5, 'cliente5@example.com'),
('C.E.', 6, 'cliente6@example.com'),
('C.C.', 7, 'cliente7@example.com'),
('T.I.', 8, 'cliente8@example.com'),
('C.E.', 9, 'cliente9@example.com'),
('C.C.', 10, 'cliente10@example.com');



-- Inserción de datos en Empleado (continuación)
INSERT INTO Empleado (tdoc_empleado, id_empleado, horaro_ingreso_emp, horario_salida_emp, sueldo_empleado)
VALUES
('T.I.', 11, '09:00:00', '18:00:00', 2300000),
('C.E.', 12, '08:30:00', '17:30:00', 2200000),
('C.C.', 13, '09:30:00', '18:30:00', 2600000),
('T.I.', 14, '07:00:00', '16:00:00', 2400000),
('C.E.', 15, '08:00:00', '17:00:00', 2500000);


-- Inserción de datos en Tipo_producto (continuación)
INSERT INTO Tipo_producto (tipo_prod, estado_tprod)
VALUES
('Anillos', true),
('Pulseras', true),
('Collares', true),
('Aretes', true),
('Relojes', true),
('Gargantillas', true);

-- Inserción de datos en Colecciones (continuación)
INSERT INTO Colecciones (id_colecciones, año_coleccion, nombre_coleccion)
VALUES
('COL01', '2023-01-01', 'Colección Invierno'),
('COL02', '2023-07-01', 'Colección Verano'),
('COL03', '2023-03-01', 'Colección Primavera'),
('COL04', '2023-10-01', 'Colección Otoño'),
('COL05', '2023-06-01', 'Colección Verano II'),
('COL06', '2023-12-01', 'Colección Navidad');

-- Inserción de datos en Productos (continuación)
INSERT INTO Productos (codigo_prod, nombre_prod, desc_prod, pedreria_prod, material_prod, precio_por_unidad, fk_id_colecciones, fk_tipo_prod)
VALUES
('PROD01', 'Anillo Diamante', 'Anillo con un diamante de corte brillante', 'Diamante', 'Oro Blanco', 1500000, 'COL01', 'Anillos'),
('PROD02', 'Pulsera Perlas', 'Pulsera de perlas cultivadas con cierre de plata', 'Perlas', 'Plata', 500000, 'COL02', 'Pulseras'),
('PROD03', 'Collar Zafiro', 'Collar elegante con zafiro azul en un colgante', 'Zafiro', 'Oro Amarillo', 1800000, 'COL03', 'Collares'),
('PROD04', 'Anillo Rubí', 'Anillo con un rubí precioso y detalle en diamantes', 'Rubí', 'Platino', 2100000, 'COL03', 'Anillos'),
('PROD05', 'Aretes Perlas', 'Aretes de perlas con cierre de oro rosa', 'Perlas', 'Oro Rosa', 800000, 'COL01', 'Aretes'),
('PROD06', 'Pulsera Diamante', 'Pulsera con eslabones de diamante en oro blanco', 'Diamante', 'Oro Blanco', 2200000, 'COL02', 'Pulseras'),
('PROD07', 'Collar Esmeralda', 'Collar con esmeralda colombiana y cadena de plata', 'Esmeralda', 'Plata', 1900000, 'COL04', 'Collares'),
('PROD08', 'Anillo Topacio', 'Anillo con topacio azul rodeado de topacios blancos', 'Topacio', 'Plata', 1200000, 'COL05', 'Anillos'),
('PROD09', 'Pulsera Zafiro', 'Pulsera de zafiro con detalles en oro amarillo', 'Zafiro', 'Oro Amarillo', 1500000, 'COL06', 'Pulseras'),
('PROD10', 'Aretes Rubí', 'Aretes con rubíes incrustados en oro blanco', 'Rubí', 'Oro Blanco', 900000, 'COL04', 'Aretes'),
('PROD11', 'Collar Perlas', 'Collar largo de perlas con broche de plata', 'Perlas', 'Plata', 950000, 'COL05', 'Collares'),
('PROD12', 'Anillo Amatista', 'Anillo con amatista púrpura y detalles en oro rosa', 'Amatista', 'Oro Rosa', 1300000, 'COL06', 'Anillos'),
('PROD13', 'Aretes Diamante', 'Aretes con diamantes en forma de lágrima en oro amarillo', 'Diamante', 'Oro Amarillo', 1100000, 'COL01', 'Aretes'),
('PROD14', 'Collar Rubí', 'Collar con colgante de rubí y cadena de oro blanco', 'Rubí', 'Oro Blanco', 2000000, 'COL02', 'Collares'),
('PROD15', 'Pulsera Esmeralda', 'Pulsera de esmeraldas colombianas en oro amarillo', 'Esmeralda', 'Oro Amarillo', 1700000, 'COL03', 'Pulseras');

-- Inserción de datos en Producto_has_empleado (continuación)
INSERT INTO Producto_has_empleado (fk_pk_codigo_prod, fk_pk_id_empleado, horas_por_prod)
VALUES
('PROD01', 6, '10 horas'),
('PROD02', 7, '8 horas'),
('PROD03', 8, '9 horas'),
('PROD04', 9, '7 horas'),
('PROD05', 6, '6 horas'),
('PROD06', 7, '8 horas'),
('PROD07', 10, '5 horas'),
('PROD08', 11, '7 horas'),
('PROD09', 8, '6 horas'),
('PROD10', 9, '5 horas'),
('PROD11', 6, '4 horas'),
('PROD12', 7, '6 horas'),
('PROD13', 12, '5 horas'),
('PROD14', 11, '7 horas'),
('PROD15', 10, '6 horas');

-- Inserción de datos en Garantia (continuación)
INSERT INTO Garantia (id_garantia, fk_pk_codigo_prod, Tiempo_garantia, desc_valides_garnt)
VALUES
(1, 'PROD01', '1 año', 'Garantía cubre defectos de fabricación'),
(2, 'PROD02', '2 años', 'Garantía cubre daños en el cierre'),
(3, 'PROD03', '1 año', 'Garantía cubre defectos de fabricación'),
(4, 'PROD04', '2 años', 'Garantía cubre daños en el material'),
(5, 'PROD05', '1 año', 'Garantía cubre defectos de diseño'),
(6, 'PROD06', '1 año', 'Garantía cubre defectos de fabricación'),
(7, 'PROD07', '2 años', 'Garantía cubre daños en el cierre'),
(8, 'PROD08', '1 año', 'Garantía cubre defectos de fabricación'),
(9, 'PROD09', '2 años', 'Garantía cubre daños en el material'),
(10, 'PROD10', '1 año', 'Garantía cubre defectos de diseño'),
(11, 'PROD11', '1 año', 'Garantía cubre defectos de fabricación'),
(12, 'PROD12', '2 años', 'Garantía cubre daños en el cierre'),
(13, 'PROD13', '1 año', 'Garantía cubre defectos de fabricación'),
(14, 'PROD14', '1 año', 'Garantía cubre defectos de fabricación'),
(15, 'PROD15', '2 años', 'Garantía cubre daños en el material');


-- Inserción de datos en Stocks (continuación)
INSERT INTO Stocks (id_stocks, fk_pk_codigo_prod, unidades_disponibles, fecha_inicio_disp)
VALUES
(1, 'PROD01', 20, '2023-01-01'),
(2, 'PROD02', 15, '2023-07-01'),
(3, 'PROD03', 30, '2023-01-15'),
(4, 'PROD04', 25, '2023-07-15'),
(5, 'PROD05', 18, '2023-01-01'),
(6, 'PROD06', 12, '2023-07-01'),
(7, 'PROD07', 28, '2023-01-15'),
(8, 'PROD08', 22, '2023-07-15'),
(9, 'PROD09', 17, '2023-01-01'),
(10, 'PROD10', 10, '2023-07-01'),
(11, 'PROD11', 24, '2023-01-15'),
(12, 'PROD12', 19, '2023-07-15'),
(13, 'PROD13', 15, '2023-01-01'),
(14, 'PROD14', 8, '2023-07-01'),
(15, 'PROD15', 23, '2023-01-15');


-- Inserción de datos en Factura
INSERT INTO Factura (N_factura, empleado_tdoc_v, empleado_id_v, cliente_tdoc, cliente_id, Fecha_factura, SubTotal, IVA, TotaL_factura)
VALUES
(1, 'C.C.', 13, 'C.C.', 1, '2023-08-01', 1200000, 228000, 1428000),
(2, 'T.I.', 14, 'T.I.', 5, '2023-08-02', 800000, 152000, 952000),
(3, 'C.E.', 12, 'C.C.', 4, '2023-08-03', 1800000, 342000, 2142000),
(4, 'C.C.', 13, 'T.I.', 2, '2023-08-04', 2500000, 475000, 2975000),
(5, 'T.I.', 11, 'C.E.', 6, '2023-08-05', 1400000, 266000, 1666000),
(6, 'C.E.', 15, 'C.E.', 6, '2023-08-06', 1100000, 209000, 1309000),
(7, 'C.C.', 13, 'T.I.', 8, '2023-08-07', 1950000, 370500, 2320500),
(8, 'T.I.', 14, 'C.C.', 7, '2023-08-08', 900000, 171000, 1071000),
(9, 'C.E.', 12, 'C.E.', 9, '2023-08-09', 1700000, 323000, 2023000),
(10, 'C.C.', 13, 'T.I.', 8, '2023-08-10', 2100000, 399000, 2499000),
(11, 'T.I.', 11, 'C.C.', 10, '2023-08-11', 1500000, 285000, 1785000),
(12, 'C.E.', 12, 'T.I.', 8, '2023-08-12', 1300000, 247000, 1547000),
(13, 'C.C.', 13, 'C.E.', 3, '2023-08-13', 800000, 152000, 952000),
(14, 'T.I.', 14, 'T.I.', 5, '2023-08-14', 1100000, 209000, 1309000),
(15, 'C.E.', 15, 'C.C.', 4, '2023-08-15', 1600000, 304000, 1904000);



-- Factura 1
INSERT INTO Factura_productos (fk_pk_factura, fk_pk_cod_producto, cantidad_prod, valor_prod_cant)
VALUES
(1, 'PROD01', 2, 3000000),
(1, 'PROD02', 1, 500000),
(1, 'PROD03', 3, 5400000);

-- Factura 2
INSERT INTO Factura_productos (fk_pk_factura, fk_pk_cod_producto, cantidad_prod, valor_prod_cant)
VALUES
(2, 'PROD02', 3, 1500000),
(2, 'PROD01', 1, 1500000),
(2, 'PROD03', 2, 3600000);

-- Factura 3
INSERT INTO Factura_productos (fk_pk_factura, fk_pk_cod_producto, cantidad_prod, valor_prod_cant)
VALUES
(3, 'PROD03', 1, 1800000),
(3, 'PROD04', 2, 4200000),
(3, 'PROD05', 1, 800000);

-- Factura 4
INSERT INTO Factura_productos (fk_pk_factura, fk_pk_cod_producto, cantidad_prod, valor_prod_cant)
VALUES
(4, 'PROD04', 3, 6300000),
(4, 'PROD05', 1, 800000),
(4, 'PROD06', 2, 4400000);

-- Factura 5
INSERT INTO Factura_productos (fk_pk_factura, fk_pk_cod_producto, cantidad_prod, valor_prod_cant)
VALUES
(5, 'PROD05', 2, 1600000),
(5, 'PROD06', 1, 1100000),
(5, 'PROD07', 3, 5700000);

-- Factura 6
INSERT INTO Factura_productos (fk_pk_factura, fk_pk_cod_producto, cantidad_prod, valor_prod_cant)
VALUES
(6, 'PROD06', 1, 1100000),
(6, 'PROD07', 2, 3800000),
(6, 'PROD08', 1, 1800000);

-- Factura 7
INSERT INTO Factura_productos (fk_pk_factura, fk_pk_cod_producto, cantidad_prod, valor_prod_cant)
VALUES
(7, 'PROD07', 3, 5700000),
(7, 'PROD08', 1, 1800000),
(7, 'PROD09', 2, 3000000);

-- Factura 8
INSERT INTO Factura_productos (fk_pk_factura, fk_pk_cod_producto, cantidad_prod, valor_prod_cant)
VALUES
(8, 'PROD08', 2, 3600000),
(8, 'PROD09', 1, 1500000),
(8, 'PROD10', 3, 2700000);

-- Factura 9
INSERT INTO Factura_productos (fk_pk_factura, fk_pk_cod_producto, cantidad_prod, valor_prod_cant)
VALUES
(9, 'PROD09', 1, 1500000),
(9, 'PROD10', 2, 1800000),
(9, 'PROD11', 1, 1200000);

-- Factura 10
INSERT INTO Factura_productos (fk_pk_factura, fk_pk_cod_producto, cantidad_prod, valor_prod_cant)
VALUES
(10, 'PROD10', 3, 2700000),
(10, 'PROD11', 1, 1200000),
(10, 'PROD12', 2, 2600000);

-- Factura 11
INSERT INTO Factura_productos (fk_pk_factura, fk_pk_cod_producto, cantidad_prod, valor_prod_cant)
VALUES
(11, 'PROD11', 2, 3000000),
(11, 'PROD12', 1, 1300000),
(11, 'PROD13', 3, 3300000);

-- Factura 12
INSERT INTO Factura_productos (fk_pk_factura, fk_pk_cod_producto, cantidad_prod, valor_prod_cant)
VALUES
(12, 'PROD12', 1, 1300000),
(12, 'PROD13', 2, 2200000),
(12, 'PROD14', 3, 6000000);

-- Factura 13
INSERT INTO Factura_productos (fk_pk_factura, fk_pk_cod_producto, cantidad_prod, valor_prod_cant)
VALUES
(13, 'PROD13', 1, 1100000),
(13, 'PROD14', 2, 4000000),
(13, 'PROD15', 3, 5100000);

-- Factura 14
INSERT INTO Factura_productos (fk_pk_factura, fk_pk_cod_producto, cantidad_prod, valor_prod_cant)
VALUES
(14, 'PROD14', 1, 2000000),
(14, 'PROD15', 2, 3400000),
(14, 'PROD01', 1, 1500000);

-- Factura 15
INSERT INTO Factura_productos (fk_pk_factura, fk_pk_cod_producto, cantidad_prod, valor_prod_cant)
VALUES
(15, 'PROD15', 1, 1700000),
(15, 'PROD01', 2, 3000000),
(15, 'PROD02', 1, 500000);


-- Inserción de datos en Registrarse (continuación)
INSERT INTO Registrarse (Id_usuario, Rol_fk_usuario, Nomb_usuario, Primer_nombre, Primer_apellido, Contraseña_hash, Rep_contraseña_hash, Telefono_usuario, Correo_usuario)
VALUES
('C.C.1', 1, 'Juan01', 'Juan', 'Rodríguez', MD5('password01'), MD5('password01'), '1234567890', 'juan01@example.com'),
('T.I.2', 1, 'María02', 'María', 'López', MD5('password02'), MD5('password02'), '9876543210', 'maria02@example.com'),
('C.E.3', 1, 'Carlos03', 'Carlos', 'Pérez', MD5('password03'), MD5('password03'), '4567890123', 'carlos03@example.com'),
('C.C.4', 1, 'Ana04', 'Ana', 'González', MD5('password04'), MD5('password04'), '7890123456', 'ana04@example.com'),
('T.I.5', 1, 'Luis05', 'Luis', 'Hernández', MD5('password05'), MD5('password05'), '2345678901', 'luis05@example.com'),
('C.E.6', 1, 'Laura06', 'Laura', 'Díaz', MD5('password06'), MD5('password06'), '3456789012', 'laura06@example.com'),
('C.C.7', 1, 'Andrés07', 'Andrés', 'Martínez', MD5('password07'), MD5('password07'), '4567890123', 'andres07@example.com'),
('T.I.8', 1, 'Diana08', 'Diana', 'Soto', MD5('password08'), MD5('password08'), '5678901234', 'diana08@example.com'),
('C.E.9', 1, 'Jorge09', 'Jorge', 'Vargas', MD5('password09'), MD5('password09'), '6789012345', 'jorge09@example.com'),
('C.C.10', 1, 'Sofía10', 'Sofía', 'Ramírez', MD5('password10'), MD5('password10'), '7890123456', 'sofia10@example.com'),
('T.I.11', 2, 'Diego11', 'Diego', 'Pérez', MD5('password11'), MD5('password11'), '8901234567', 'diego11@example.com'),
('C.E.12', 2, 'Mónica12', 'Mónica', 'Gómez', MD5('password12'), MD5('password12'), '9012345678', 'monica12@example.com'),
('C.C.13', 2, 'Andrea13', 'Andrea', 'López', MD5('password13'), MD5('password13'), '1234567890', 'andrea13@example.com'),
('T.I.14', 2, 'Miguel14', 'Miguel', 'Fernández', MD5('password14'), MD5('password14'), '2345678901', 'miguel14@example.com'),
('C.E.15', 2, 'Carolina15', 'Carolina', 'Sánchez', MD5('password15'), MD5('password15'), '3456789012', 'carolina15@example.com');

-- Inserción de datos en Iniciar_sesión (continuación)
INSERT INTO Iniciar_sesión (Id_usuario, Rol_fk_usuario, Nomb_usuario, Contraseña_hash)
VALUES
('C.C.1', 1, 'Juan01', MD5('password01')),
('T.I.2', 1, 'María02', MD5('password02')),
('C.E.3', 1, 'Carlos03', MD5('password03')),
('C.C.4', 1, 'Ana04', MD5('password04')),
('T.I.5', 1, 'Luis05', MD5('password05')),
('C.E.6', 1, 'Laura06', MD5('password06')),
('C.C.7', 1, 'Andrés07', MD5('password07')),
('T.I.8', 1, 'Diana08', MD5('password08')),
('C.E.9', 1, 'Jorge09', MD5('password09')),
('C.C.10', 1, 'Sofía10', MD5('password10')),
('T.I.11', 2, 'Diego11', MD5('password11')),
('C.E.12', 2, 'Mónica12', MD5('password12')),
('C.C.13', 2, 'Andrea13', MD5('password13')),
('T.I.14', 2, 'Miguel14', MD5('password14')),
('C.E.15', 2, 'Carolina15', MD5('password15'));
