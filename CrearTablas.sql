
----- Inicio Wander ------
create table T_Rol(

ID_Rol int primary key IDENTITY,
Nombre varchar(50),
Estado bit default 1,
Fecha_Registro datetime default GETDATE()
);
go
create table T_Departamento(

ID_Departamento int primary key IDENTITY,
Nombre varchar(50),
Descripcion varchar(250),
Estado bit default 1,
Fecha_Registro datetime default GETDATE()
);
------ Fin Wander -------
go

----- Inicio JOAN ------
create table T_Empleado(

ID_Empleado int primary key IDENTITY,
Nombre varchar(50),
Apellido varchar(50),
Cedula varchar(13),
Sexo varchar(20),
Telefono varchar(12),
Direccion varchar(250),
Fecha_Nacimiento date,
ID_Departamento int references T_Departamento(ID_Departamento),
Estado_Civil varchar(20),
Estado bit,
Fecha_Registro datetime default GETDATE()
);

go

create table T_Cliente(

ID_Cliente int primary key IDENTITY,
Nombre varchar(50),
Apellido varchar(50),
Cedula varchar(50),
Sexo varchar(50),
Telefono varchar(12),
Direccion varchar(250),
Fecha_Nacimiento date,
Estado_Civil varchar(20),
Estado bit default 1,
Fecha_Registro datetime default GETDATE()
);

go

----- Fin JOAN ------

----- Incio Esteban ------
create table T_Categoria(

ID_Categoria int primary key IDENTITY,
Nombre varchar(50),
Estado bit default 1,
Fecha_Registro datetime default GETDATE()
);
go
create table T_Producto(

ID_Producto int primary key IDENTITY,
Codigo varchar(30),
Nombre varchar(50),
Precio decimal(10,2),
ID_Categoria int references T_Categoria(ID_Categoria),
Estado bit default 1,
Fecha_Registro datetime default GETDATE()
);

create table T_Categoria(

ID_Categoria int primary key IDENTITY,
Nombre varchar(50),
Estado binary default 1,
Fecha_Registro datetime default NOW()
);

----- Fin Esteban ------

go
------ Inicio Milko-------
create table T_Ventas(
  
ID_Venta int primary key IDENTITY,
Codigo_Facruta int,
ID_Empleado int references T_Empleado(ID_Empleado),
ID_Cliente int references T_Cliente(ID_Cliente),
Precio_Bruto decimal(10,2),
Descuento decimal(10,2),
ITBIS decimal(10,2),
Precio_Neto decimal(10,2),
Estado bit default 1,
Fecha_Registro datetime default GETDATE()
);

go
create table T_VentaDetalle(
  
ID_VentaDetalle int primary key IDENTITY,
ID_Venta int references T_Ventas(ID_Venta),
ID_Producto int references T_Producto(ID_Producto),
Cantidad int,
Precio_venta decimal(10,2)
);
-------Final MIlko--------


create table T_Usuario (
ID_Usuario int primary key IDENTITY,
Usuario varchar(50),
Pass varchar(50),
ID_Empleado int references T_Empleado(ID_Empleado),
ID_Rol int references T_Rol(ID_Rol),
Estado bit default 1,
Fecha_Registro datetime default GETDATE()

)