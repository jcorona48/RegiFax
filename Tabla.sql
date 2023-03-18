
create table T_Categoria(

ID_Categoria int primary key IDENTITY,
Nombre varchar(50),
Estado binary default 1,
Fecha_Registro datetime default GETDATE()
);