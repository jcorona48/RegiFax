
/* ------------------------------- Reportes de Ventas --------------------------------- */
create PROC SP_ReporteVentas(
@FechaInicio varchar(10),
@FechaFin varchar(10),
@ID_Empleado int
)
as 
begin
	set dateformat dmy;
	select 
	CONVERT(char(10),V.Fecha_Registro,103) as Fecha_Registro,V.Codigo_Factura,e.Nombre as NombreEmp, 
	e.Apellido as ApellidoEmp, c.Nombre as NombreCli, c.Apellido as ApellidoCli, c.Cedula as CedulaCli,
	V.Precio_Bruto, V.ITBIS, V.Precio_Neto from T_Ventas V
	inner join T_Empleado e on e.ID_Empleado = V.ID_Empleado
	inner join T_Cliente c on c.ID_Cliente = V.ID_Cliente
	where CONVERT(date,V.Fecha_Registro) between @FechaInicio and @FechaFin
	and e.ID_Empleado = iif(@ID_Empleado=0,e.ID_Empleado,@ID_Empleado)

end

go

create PROC SP_ReporteVentasTopProducto(
@FechaInicio varchar(10),
@FechaFin varchar(10),
@ID_Empleado int
)
as 
begin
	select TOP 10 p.Codigo, p.Nombre, SUM(vd.ID_VentaDetalle) as Total_Vendido, c.Nombre as Categoria
	from T_VentaDetalle vd
	inner join T_Producto p on p.ID_Producto = vd.ID_Producto
	inner join T_Categoria c on c.ID_Categoria = vd.ID_Categoria
	inner join T_Ventas v on v.ID_Venta = vd.ID_Venta
	inner join T_Empleado e on e.ID_Empleado = v.ID_Empleado
	where CONVERT(date,V.Fecha_Registro) between @FechaInicio and @FechaFin
	and e.ID_Empleado = iif(@ID_Empleado=0,e.ID_Empleado,@ID_Empleado)

end
go
create PROC SP_ReporteVentasTopCliente(
@FechaInicio varchar(10),
@FechaFin varchar(10),
@ID_Empleado int
)
as 
begin
	select TOP 10 c.Cedula, c.Nombre, c.Apellido, SUM(v.Precio_Neto) as Total_Comprado
	from T_Ventas v
	inner join T_Cliente c on c.ID_Cliente = v.ID_Cliente
	inner join T_Ventas v on v.ID_Venta = vd.ID_Venta
	inner join T_Empleado e on e.ID_Empleado = v.ID_Empleado
	where CONVERT(date,V.Fecha_Registro) between @FechaInicio and @FechaFin
	and e.ID_Empleado = iif(@ID_Empleado=0,e.ID_Empleado,@ID_Empleado)
end

go

create PROC SP_ReporteVentasCliente(
@FechaInicio varchar(10),
@FechaFin varchar(10),
@ID_Empleado int
)
as 
begin
	select c.Cedula, c.Nombre, c.Apellido, SUM(v.Precio_Neto) as Total_Comprado
	from T_Ventas v
	inner join T_Cliente c on c.ID_Cliente = v.ID_Cliente
	inner join T_Ventas v on v.ID_Venta = vd.ID_Venta
	inner join T_Empleado e on e.ID_Empleado = v.ID_Empleado
	where CONVERT(date,V.Fecha_Registro) between @FechaInicio and @FechaFin
	and e.ID_Empleado = iif(@ID_Empleado=0,e.ID_Empleado,@ID_Empleado)
end

/* ------------------------------- Fin Reportes de Ventas --------------------------------- */

go

/* ------------------------------- Reportes de Cliente --------------------------------- */

create PROC SP_ConsultarCliente(
@valor varchar(100)
)
as 
	SET NOCOUNT ON;
	if((@valor='0'))
		begin
			SELECT C.ID_Cliente, C.Nombre, C.Apellido, C.Cedula, C.Telefono, C.Sexo, C.Direccion,
			C.Fecha_Nacimiento, C.Estado_Civil, C.Estado 
			FROM T_Cliente AS C
		end
	Else
		begin
			IF ((ISNUMERIC(@valor)=1))
				 BEGIN
					SELECT C.ID_Cliente, C.Nombre, C.Apellido, C.Cedula, C.Telefono, C.Sexo, C.Direccion,
					 C.Fecha_Nacimiento, C.Estado_Civil, C.Estado 
					FROM T_Cliente AS C
					WHERE (C.ID_Cliente = @valor) ORDER BY C.ID_Cliente
				 END
			ELSE
				BEGIN
					SELECT C.ID_Cliente, C.Nombre, C.Apellido, C.Cedula, C.Telefono, C.Sexo, C.Direccion,
						C.Fecha_Nacimiento, C.Estado_Civil, C.Estado 
					FROM T_Cliente AS C
					WHERE (C.Nombre Like '%'+@valor + '%') OR
					 (C.Apellido Like '%'+@valor + '%') OR (C.Cedula Like '%'+@valor + '%') OR
					 (C.Telefono Like '%'+@valor + '%') OR (C.Sexo Like '%'+@valor + '%')
					 OR (C.Direccion Like '%'+@valor + '%') OR (C.Fecha_Nacimiento Like '%'+@valor + '%')
					 OR (C.Estado_Civil Like '%'+@valor + '%') OR (C.Estado Like '%'+@valor + '%')
					ORDER BY C.ID_Cliente
				END
		end


/* ------------------------------- Reportes de Cliente FIN --------------------------------- */

go
/* ------------------------------- Reportes de Empleado --------------------------------- */

create PROC SP_ConsultarEmpleado(
@valor varchar(100)
)
as 
	SET NOCOUNT ON;
	if((@valor='0'))
		begin
			SELECT C.ID_Empleado, C.Nombre, C.Apellido, C.Cedula, C.Telefono, C.Sexo, C.Direccion,
			C.Fecha_Nacimiento, C.Estado_Civil, C.Estado 
			FROM T_Empleado AS C
		end
	Else
		begin
			IF ((ISNUMERIC(@valor)=1))
				 BEGIN
					SELECT C.ID_Empleado, C.Nombre, C.Apellido, C.Cedula, C.Telefono, C.Sexo, C.Direccion,
					 C.Fecha_Nacimiento, C.Estado_Civil, C.Estado 
					FROM T_Empleado AS C
					WHERE (C.ID_Empleado = @valor) ORDER BY C.ID_Empleado
				 END
			ELSE
				BEGIN
					SELECT C.ID_Empleado, C.Nombre, C.Apellido, C.Cedula, C.Telefono, C.Sexo, C.Direccion,
						C.Fecha_Nacimiento, C.Estado_Civil, C.Estado 
					FROM T_Empleado AS C
					WHERE (C.Nombre Like '%'+@valor + '%') OR (C.Apellido Like '%'+@valor + '%') OR (C.Cedula Like '%'+@valor + '%') OR
					 (C.Telefono Like '%'+@valor + '%') OR (C.Sexo Like '%'+@valor + '%')
					 OR (C.Direccion Like '%'+@valor + '%') OR (C.Fecha_Nacimiento Like '%'+@valor + '%')
					 OR (C.Estado_Civil Like '%'+@valor + '%') OR (C.Estado Like '%'+@valor + '%')
					ORDER BY C.ID_Empleado
				END
		end


/* ------------------------------- Reportes de Empleado  FIN--------------------------------- */


go
/* ------------------------------- Reportes de Producto --------------------------------- */

create PROC SP_ConsultarProducto(
@valor varchar(100)
)
as 
	SET NOCOUNT ON;
	if((@valor='0'))
		begin
			SELECT C.ID_Producto, C.Codigo, C.Nombre, C.Cantidad, C.Precio, C.ID_Categoria, C.Estado, C.Fecha_Registro
			FROM T_Producto AS C
		end
	Else
		begin
			IF ((ISNUMERIC(@valor)=1))
				 BEGIN
					SELECT C.ID_Producto, C.Codigo, C.Nombre, C.Cantidad, C.Precio, C.ID_Categoria, C.Estado, C.Fecha_Registro
					FROM T_Producto AS C
					WHERE (C.ID_Producto = @valor) ORDER BY C.ID_Producto
				 END
			ELSE
				BEGIN
					SELECT C.ID_Producto, C.Codigo, C.Nombre, C.Cantidad, C.Precio, C.ID_Categoria, C.Estado, C.Fecha_Registro 
					FROM T_Producto AS C
					WHERE (C.Codigo Like '%'+@valor + '%') OR
					(C.Nombre Like '%'+@valor + '%') OR
					 (C.Cantidad Like '%'+@valor + '%') OR 
					 (C.Precio Like '%'+@valor + '%') OR 
					 (C.ID_Categoria Like '%'+@valor + '%') OR
					(C.Estado Like '%'+@valor + '%') OR
					 (C.Fecha_Registro Like '%'+@valor + '%') 
					ORDER BY C.ID_Producto
				END
		end


/* ------------------------------- Reportes de Producto  FIN--------------------------------- */

go
/* ------------------------------- Reportes de Categoria --------------------------------- */

create PROC SP_ConsultarCategoria(
@valor varchar(100)
)
as 
	SET NOCOUNT ON;
	if((@valor='0'))
		begin
			SELECT C.ID_Categoria, C.Nombre, C.Estado, C.Fecha_Registro
			FROM T_Categoria AS C
		end
	Else
		begin
			IF ((ISNUMERIC(@valor)=1))
				 BEGIN
					SELECT C.ID_Categoria, C.Nombre, C.Estado, C.Fecha_Registro
					FROM T_Cliente AS C
					WHERE (C.ID_Categoria = @valor) ORDER BY C.ID_Categoria
				 END
			ELSE
				BEGIN
					SELECT C.ID_Categoria, C.Nombre, C.Estado, C.Fecha_Registro
					FROM T_Categoria AS C
					WHERE (C.Nombre Like '%'+@valor + '%') OR (C.Etado Like '%'+@valor + '%') OR (C.Fecha_Registro Like '%'+@valor + '%') OR
					(C.Estado Like '%'+@valor + '%')
					ORDER BY C.ID_Categoria
				END
		end


/* ------------------------------- Reportes de Categoria FIN --------------------------------- */
go
/* ------------------------------- Reportes de Rol --------------------------------- */

create PROC SP_ConsultarRol(
@valor varchar(100)
)
as 
	SET NOCOUNT ON;
	if((@valor='0'))
		begin
			SELECT C.ID_Rol, C.Nombre, C.Estado, C.Fecha_Registro
			FROM T_Rol AS C
		end
	Else
		begin
			IF ((ISNUMERIC(@valor)=1))
				 BEGIN
					SELECT C.ID_Rol, C.Nombre, C.Estado,  C.Fecha_Registro 
					FROM T_ROL AS C
					WHERE (C.ID_ROL = @valor) ORDER BY C.ID_Rol
				 END
			ELSE
				BEGIN
					SELECT C.ID_Rol, C.Nombre, C.Estado, C.Fecha_Registro
					FROM T_Rol AS C
					WHERE (C.Nombre Like '%'+@valor + '%') OR
					(C.Estado Like '%'+@valor + '%') OR (C.Fecha_Registro Like '%'+@valor + '%')
					ORDER BY C.ID_Rol
				END
		end


		/* ------------------------------- Reportes de Rol FIN --------------------------------- */


		go
		/* ------------------------------- Reportes de Usuario --------------------------------- */

		create PROC SP_ConsultarUsuario(
		@valor varchar(100)
		)
		as 
			SET NOCOUNT ON;
			if((@valor='0'))
				begin
					SELECT C.ID_Usuario, C.Pass , C.Usuario, C.ID_Empleado, C.ID_Rol, C.Estado, Fecha_Registro
					FROM T_Usuario AS C
				end
			Else
				begin
					IF ((ISNUMERIC(@valor)=1))
						 BEGIN
							SELECT C.ID_Usuario, C.Usuario, C.pass, C.ID_Empleado, C.ID_Rol, C.Estado, Fecha_Registro
							FROM T_Usuario AS C
							WHERE (C.ID_Usuario = @valor) ORDER BY C.ID_Usuario
						 END
					ELSE
						BEGIN
							SELECT C.ID_Usuario,C.Usuario, C.Pass, C.ID_Empleado, C.ID_Rol, C.Estado, Fecha_Registro
							FROM T_Usuario AS C
							WHERE (C.Usuario Like '%'+@valor + '%') OR (C.Pass Like '%'+@valor + '%') OR
							 (C.ID_Empleado Like '%'+@valor + '%') OR (C.ID_Rol Like '%'+@valor + '%') OR
							 (C.Estado Like '%'+@valor + '%') OR (C.Fecha_Registro Like '%'+@valor + '%')
							
							ORDER BY C.ID_Usuario
						END
				end


/* ------------------------------- Reportes de Usuario  FIN--------------------------------- */

go
/* ------------------------------- Reportes de Departamento --------------------------------- */

create PROC SP_ConsultarDepartamento(
@valor varchar(100)
)
as 
	SET NOCOUNT ON;
	if((@valor='0'))
		begin
			SELECT C.ID_Departemento, C.Nombre, C.Descripcion, C.Estado, C.Fecha_Registro
			FROM T_Departameto AS C
		end
	Else
		begin
			IF ((ISNUMERIC(@valor)=1))
				 BEGIN
					SELECT C.ID_Departemento, C.Nombre, C.Descripcion, C.Estado, C.Fecha_Registro
					FROM T_Departameto AS C
					WHERE (C.ID_Departamento = @valor) ORDER BY C.ID_Departamento
				 END
			ELSE
				BEGIN
					SELECT C.ID_Departemento, C.Nombre, C.Descripcion, C.Estado, C.Fecha_Registro
					FROM T_Departameto AS C
					WHERE (C.Nombre Like '%'+@valor + '%') OR
					(C.Descripcion Like '%'+@valor + '%') OR
					(C.Estado Like '%'+@valor + '%') OR
					 (C.Fecha_Registro Like '%'+@valor + '%') 
					ORDER BY C.ID_Departamento
				END
		end


/* ------------------------------- Reportes de Departamento  FIN--------------------------------- */



