﻿

----- Inicio JOAN ------

create table T_Empleado(

ID_Empleado int primary key IDENTITY,
Nombre varchar(50),
Apellido varchar(50),
Cedula varchar(13),
Telefono varchar(12),
Direccion varchar(250),
Fecha_Nacimiento date,
ID_Departamento int references T_Departamento(ID_Departamento),
Estado_Civil varchar(20),
Estado binary,
Fecha_Registro datetime default NOW()
);

create table T_Cliente(

ID_Cliente int primary key IDENTITY,
Nombre varchar(50),
Apellido varchar(50),
Cedula varchar(13),
Telefono varchar(12),
Direccion varchar(250),
Fecha_Nacimiento date,
Estado_Civil varchar(20),
Estado binary default 1,
Fecha_Registro datetime default NOW()
);



----- Fin JOAN ------

----- Incio Esteban ------
create table T_Producto(

ID_Producto int primary key IDENTITY,
Codigo varchar(30),
Nombre varchar(50),
Precio decimal(10,2),
ID_Categoria int references T_Categoria(ID_Categoria),
Estado binary default 1,
Fecha_Registro datetime default NOW()
);

create table T_Categoria(

ID_Categoria int primary key IDENTITY,
Nombre varchar(50),
Estado binary default 1,
Fecha_Registro datetime default NOW()
);

----- Fin Esteban ------

----- Inicio Wander ------
create table T_Rol(

ID_Rol int primary key IDENTITY,
Nombre varchar(50),
Estado binary default 1,
Fecha_Registro datetime default NOW()
);

create table T_Departamento(

ID_Departamento int primary key IDENTITY,
Nombre varchar(50),
Descripcion varchar(250),
Estado binary default 1,
Fecha_Registro datetime default NOW()
);
------ Fin Wander -------
