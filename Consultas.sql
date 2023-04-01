
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
@ID_Empleado int = 0
)
as 
begin
 set dateformat dmy;
	select TOP 15 p.Codigo, p.Nombre, SUM(vd.Cantidad) as Total_Vendido, c.Nombre as Categoria
	from T_VentaDetalle vd
	inner join T_Producto p on p.ID_Producto = vd.ID_Producto
	inner join T_Categoria c on c.ID_Categoria = p.ID_Categoria
	inner join T_Ventas v on v.ID_Venta = vd.ID_Venta
	inner join T_Empleado e on e.ID_Empleado = v.ID_Empleado
	where CONVERT(date,V.Fecha_Registro) between CONVERT(date, @FechaInicio) and CONVERT(date, @FechaFin)
	and e.ID_Empleado = iif(@ID_Empleado=0,e.ID_Empleado,@ID_Empleado)
	GROUP BY p.Codigo, p.Nombre, c.Nombre

end
go
create PROC SP_ReporteVentasTopCliente(
@FechaInicio varchar(10),
@FechaFin varchar(10),
@ID_Empleado int
)
as 
begin
	set dateformat dmy;
	select TOP 10 c.Cedula, c.Nombre, c.Apellido, SUM(v.Precio_Neto) as Total_Comprado
	from T_Ventas v
	inner join T_Cliente c on c.ID_Cliente = v.ID_Cliente
	inner join T_Empleado e on e.ID_Empleado = v.ID_Empleado
	where CONVERT(date,V.Fecha_Registro) between @FechaInicio and @FechaFin
	and e.ID_Empleado = iif(@ID_Empleado=0,e.ID_Empleado,@ID_Empleado)
	group by c.Cedula, c.Nombre, c.Apellido
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
			ORDER BY C.ID_Cliente
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
			SELECT C.ID_Empleado, C.Nombre, C.Apellido, C.Cedula, C.Telefono, C.Sexo, C.Direccion, C.ID_Departamento,
			D.Nombre as Departamento, C.Fecha_Nacimiento, C.Estado_Civil, C.Estado 
			FROM T_Empleado AS C
			inner join T_Departamento D on D.ID_Departamento = C.ID_Departamento
			ORDER BY C.ID_Empleado
		end
	Else
		begin
			IF ((ISNUMERIC(@valor)=1))
				 BEGIN
					SELECT C.ID_Empleado, C.Nombre, C.Apellido, C.Cedula, C.Telefono, C.Sexo, C.Direccion, C.ID_Departamento,
					D.Nombre as Departamento, C.Fecha_Nacimiento, C.Estado_Civil, C.Estado 
					FROM T_Empleado AS C 
					inner join T_Departamento D on D.ID_Departamento = C.ID_Departamento
					WHERE (C.ID_Empleado = @valor) ORDER BY C.ID_Empleado
				 END
			ELSE
				BEGIN
					SELECT C.ID_Empleado, C.Nombre, C.Apellido, C.Cedula, C.Telefono, C.Sexo, C.Direccion, C.ID_Departamento,
					D.Nombre as Departamento, C.Fecha_Nacimiento, C.Estado_Civil, C.Estado 
					FROM T_Empleado AS C
					inner join T_Departamento D on D.ID_Departamento = C.ID_Departamento
					WHERE (C.Nombre Like '%'+@valor + '%') OR (C.Apellido Like '%'+@valor + '%') OR (C.Cedula Like '%'+@valor + '%') OR
					 (C.Telefono Like '%'+@valor + '%') OR (C.Sexo Like '%'+@valor + '%') OR (D.Nombre Like '%'+@valor + '%') 
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
			SELECT C.ID_Producto, C.Codigo, C.Nombre, C.Cantidad, C.Precio, C.ID_Categoria, cat.Nombre as Categoria, C.Estado, C.Fecha_Registro
			FROM T_Producto AS C
			inner join T_Categoria cat on cat.ID_Categoria = c.ID_Categoria
			ORDER BY C.ID_Producto
		end
	Else
		begin
			IF ((ISNUMERIC(@valor)=1))
				 BEGIN
					SELECT C.ID_Producto, C.Codigo, C.Nombre, C.Cantidad, C.Precio, C.ID_Categoria, cat.Nombre as Categoria, C.Estado, C.Fecha_Registro
					FROM T_Producto AS C
					inner join T_Categoria cat on cat.ID_Categoria = c.ID_Categoria
					WHERE (C.ID_Producto = @valor) ORDER BY C.ID_Producto
				 END
			ELSE
				BEGIN
					SELECT C.ID_Producto, C.Codigo, C.Nombre, C.Cantidad, C.Precio, C.ID_Categoria, cat.Nombre as Categoria, C.Estado, C.Fecha_Registro 
					FROM T_Producto AS C
					inner join T_Categoria cat on cat.ID_Categoria = c.ID_Categoria
					WHERE (C.Codigo Like '%'+@valor + '%') OR
					(C.Nombre Like '%'+@valor + '%') OR
					 (C.Cantidad Like '%'+@valor + '%') OR 
					 (C.Precio Like '%'+@valor + '%') OR 
					 (cat.Nombre Like '%'+@valor + '%') OR
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
	set dateformat dmy;
	if((@valor='0'))
		begin
			SELECT C.ID_Categoria, C.Nombre, C.Estado, C.Fecha_Registro
			FROM T_Categoria AS C
			ORDER BY C.ID_Categoria
		end
	Else
		begin
			IF ((ISNUMERIC(@valor)=1))
				 BEGIN
					SELECT C.ID_Categoria, C.Nombre, C.Estado, C.Fecha_Registro
					FROM T_Categoria AS C
					WHERE (C.ID_Categoria = @valor) ORDER BY C.ID_Categoria
				 END
			ELSE
				BEGIN
					SELECT C.ID_Categoria, C.Nombre, C.Estado, C.Fecha_Registro
					FROM T_Categoria AS C
					WHERE (C.Nombre Like '%'+@valor + '%') OR (C.Estado Like '%'+@valor + '%') OR (CONVERT(date, C.Fecha_Registro) Like '%'+ CONVERT(date, @valor) + '%') OR
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
			order by c.ID_Rol
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
					SELECT u.ID_Usuario, u.Pass , u.Usuario, u.ID_Empleado, CONCAT(e.Nombre, ' ', e.Apellido) as Empleado, u.ID_Rol, r.Nombre as Rol, u.Estado, u.Fecha_Registro
					FROM T_Usuario AS u
					inner join T_Empleado e on e.ID_Empleado = u.ID_Empleado
					inner join T_Rol r on r.ID_Rol = u.ID_Rol
					ORDER BY u.ID_Usuario
				end
			Else
				begin
					IF ((ISNUMERIC(@valor)=1))
						 BEGIN
							SELECT u.ID_Usuario, u.Pass , u.Usuario, u.ID_Empleado, CONCAT(e.Nombre, ' ', e.Apellido) as Empleado, u.ID_Rol, r.Nombre as Rol, u.Estado, u.Fecha_Registro
							FROM T_Usuario AS u
							inner join T_Empleado e on e.ID_Empleado = u.ID_Empleado
							inner join T_Rol r on r.ID_Rol = u.ID_Rol
							WHERE (u.ID_Usuario = @valor) ORDER BY u.ID_Usuario
						 END
					ELSE
						BEGIN
							SELECT u.ID_Usuario, u.Pass , u.Usuario, u.ID_Empleado, CONCAT(e.Nombre, ' ', e.Apellido) as Empleado, u.ID_Rol, r.Nombre as Rol, u.Estado, u.Fecha_Registro
								FROM T_Usuario AS u
								inner join T_Empleado e on e.ID_Empleado = u.ID_Empleado
								inner join T_Rol r on r.ID_Rol = u.ID_Rol
							WHERE (u.Usuario Like '%'+@valor + '%') OR (u.Pass Like '%'+@valor + '%') OR
								(CONCAT(e.Nombre, ' ', e.Apellido) Like '%'+@valor + '%') OR (r.Nombre Like '%'+@valor + '%') OR
							 (u.ID_Empleado Like '%'+@valor + '%') OR (u.ID_Rol Like '%'+@valor + '%') OR
							 (u.Estado Like '%'+@valor + '%') OR (u.Fecha_Registro Like '%'+@valor + '%')
							
							ORDER BY u.ID_Usuario
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
			SELECT C.ID_Departamento, C.Nombre, C.Descripcion, C.Estado, C.Fecha_Registro
			FROM T_Departamento AS C
		end
	Else
		begin
			IF ((ISNUMERIC(@valor)=1))
				 BEGIN
					SELECT C.ID_Departamento, C.Nombre, C.Descripcion, C.Estado, C.Fecha_Registro
					FROM T_Departamento AS C
					WHERE (C.ID_Departamento = @valor) ORDER BY C.ID_Departamento
				 END
			ELSE
				BEGIN
					SELECT C.ID_Departamento, C.Nombre, C.Descripcion, C.Estado, C.Fecha_Registro
					FROM T_Departamento AS C
					WHERE (C.Nombre Like '%'+@valor + '%') OR
					(C.Descripcion Like '%'+@valor + '%') OR
					(C.Estado Like '%'+@valor + '%') OR
					 (C.Fecha_Registro Like '%'+@valor + '%') 
					ORDER BY C.ID_Departamento
				END
		end
/* ------------------------------- Reportes de Departamento  FIN--------------------------------- */

go

create PROC SP_InicioSesion(
@user varchar(50),
@pass varchar(50),
@Resultado int output,
@Mensaje varchar(500) output
)
as 
	
	if not exists (select * from T_Usuario where Usuario = @user and Pass = @pass)
		begin
			set @Resultado = 0
			if not exists (select * from T_Usuario where Usuario = @user)
			begin
				set @Mensaje = 'Este Usuario no se encuentra en la Base de Datos.'
			end
			else
				begin
					if not exists (select * from T_Usuario where Pass = @pass)
						begin
							set @Mensaje = 'La contraseña es incorrecta.'
						end
				end
		end
	set @Resultado = (select ID_Usuario from T_Usuario where Usuario = @user and Pass = @pass)
