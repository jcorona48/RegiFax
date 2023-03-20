/* ----------------------------------- PROCEDIMIENTOS CATEGORIA -----------------------------------*/


/* -------------- GUARDAR CATEGORIA --------------*/
go
CREATE PROC SP_REGISTRARCATEGORIA
(
	@Nombre varchar(50),
	@Estado bit,
	@Resultado int output,
	@Mensaje varchar(500) output
	)

as 
	begin
		set @Resultado = 0
		if not exists(select * from T_Categoria where Nombre = @Nombre)
		begin
			insert into T_Categoria(Nombre, Estado) values
			(@Nombre, @Estado)

			set @Resultado = SCOPE_IDENTITY() 
		end
		else 
			set @Mensaje = 'Ya existe esta categoria'
	end

---------------EDITAR CATEGORIA ---------------

go
CREATE PROC SP_EDITARCATEGORIA
(
	@ID_Categoria int,
	@Nombre varchar(50),
	@Estado bit,
	@Resultado bit output,
	@Mensaje varchar(500) output
	)

as 
	begin
		set @Resultado = 1
		if not exists(select * from T_Categoria where Nombre = @Nombre and ID_Categoria != @ID_Categoria)
		begin
			update T_Categoria set
			Nombre = @Nombre,
			Estado = @Estado
			where ID_Categoria = @ID_Categoria

		end
		else 
			begin
				set @Resultado = 0
				set @Mensaje = 'Ya existe esta categoria'
			end
	end


---------------ELIMINAR CATEGORIA ---------------

go
CREATE PROC SP_ELIMINARCATEGORIA
(
	@ID_Categoria int,
	@Resultado bit output,
	@Mensaje varchar(500) output
	)

as 
	begin
		set @Resultado = 1
		if not exists(select * from T_Categoria c 
		inner join T_Producto p on p.ID_Categoria = c.ID_Categoria
		where c.ID_Categoria = @ID_Categoria)
		begin
			delete top (1) from T_Categoria where ID_Categoria = @ID_Categoria
		end
		else 
			begin
				set @Resultado = 0
				set @Mensaje = 'No se puede eliminar esta categoria, esta relacionada con un producto'
			end
	end

/* -------------------------------- FIN PROCEDIMIENTOS CATEGORIA --------------------------------*/
go

/* -------------------------------- PROCEDIMIENTOS DE CLIENTE ------------------------------- */

CREATE PROC SP_REGISTRARCLIENTE(

@Nombre varchar(50), --
@Apellido varchar(50),--
@Cedula varchar(13), --
@Telefono varchar(12), --
@Sexo varchar(50), --
@Direccion varchar(250), --
@Fecha_Nacimiento varchar(50),
@Estado_Civil varchar(20),
@Estado bit,
@Resultado int output,
@Mensaje varchar(500) output

)

as 

begin
	set @Resultado = 0
	if not exists(select * from T_Cliente where Cedula = @Cedula)
	begin 
		insert into T_Cliente(Nombre, Apellido, Cedula, Telefono, Sexo, Direccion, Fecha_Nacimiento, Estado_Civil, Estado) values 
		(@Nombre, @Apellido, @Cedula, @Telefono, @Sexo, @Direccion, @Fecha_Nacimiento, @Estado_Civil, @Estado)
		set @Resultado = SCOPE_IDENTITY() 
	end 
	else
		set @Mensaje = 'Ya existe un cliente con esta identificacion'
end


go


CREATE PROC SP_EDITARCLIENTE(
@ID_Cliente int,

@Nombre varchar(50), --
@Apellido varchar(50),--
@Cedula varchar(13), --
@Telefono varchar(12), --
@Sexo varchar(50), --
@Direccion varchar(250), --
@Fecha_Nacimiento varchar(50),
@Estado_Civil varchar(20),
@Estado bit,
@Resultado bit output,
@Mensaje varchar(500) output 

)

as 

begin
	set @Resultado = 1
	set @Mensaje = ''
	if not exists(select * from T_Cliente where Cedula = @Cedula and ID_Cliente != @ID_Cliente)
	begin
		update T_Cliente set 
		Nombre = @Nombre, 
		Apellido = @Apellido, 
		Cedula = @Cedula, 
		Telefono = @Telefono, 
		Sexo = @Sexo,
		Direccion = @Direccion,  
		Fecha_Nacimiento = CAST(@Fecha_Nacimiento as date), 
		Estado_Civil = @Estado_Civil, 
		Estado = @Estado
		where ID_Cliente = @ID_Cliente
	end
	else 
		begin
			set @Resultado = 0
			set @Mensaje = 'Esta identificacion ya existe, pruebe con otra...'
		end
end


go

/* -------------------------------- FIN PROCEDIMIENTOS CLIENTE --------------------------------*/

/* -------------------------------- PROCEDIMIENTOS DE ROL ------------------------------- */
go
CREATE PROC SP_REGISTRARROL
(
	@Nombre varchar(50),
	@Estado bit,
	@Resultado int output,
	@Mensaje varchar(500) output
	)

as 
	begin
		set @Resultado = 0
		if not exists(select * from T_Rol where Nombre = @Nombre)
		begin
			insert into T_Rol(Nombre, Estado) values
			(@Nombre, @Estado)

			set @Resultado = SCOPE_IDENTITY() 
		end
		else 
			set @Mensaje = 'Ya existe este rol'
	end



go
CREATE PROC SP_EDITARROL
(
	@ID_Rol int,
	@Nombre varchar(50),
	@Estado bit,
	@Resultado bit output,
	@Mensaje varchar(500) output
	)

as 
	begin
		set @Resultado = 1
		if not exists(select * from T_Rol where Nombre = @Nombre and ID_Rol != @ID_Rol)
		begin
			update T_Rol set
			Nombre = @Nombre,
			Estado = @Estado
			where ID_Rol = @ID_Rol

		end
		else 
			begin
				set @Resultado = 0
				set @Mensaje = 'Ya existe este rol'
			end
	end

	go
CREATE PROC SP_ELIMINARROL
(
	@ID_Rol int,
	@Resultado bit output,
	@Mensaje varchar(500) output
	)

as 
	begin
		set @Resultado = 1
		if not exists(select * from T_Rol r 
		inner join T_Usuario u on u.ID_Rol = r.ID_Rol
		where r.ID_Rol = @ID_Rol)
		begin
			delete top (1) from T_Rol where ID_Rol = @ID_Rol
		end
		else 
			begin
				set @Resultado = 0
				set @Mensaje = 'No se puede eliminar este rol, esta relacionada con un usuario'
			end
	end

	/* -------------------------------- FIN PROCEDIMIENTOS ROL --------------------------------*/

	/* ----------------------------------- PROCEDIMIENTOS DEPARTAMENTO -----------------------------------*/


go
CREATE PROC SP_REGISTRARDEPARTAMENTO
(
	@Nombre varchar(50),
	@Descripcion varchar (250),
	@Estado bit,
	@Resultado int output,
	@Mensaje varchar(500) output
	)

as 
	begin
		set @Resultado = 0
		if not exists(select * from T_Departamento where Nombre = @Nombre)
		begin
			insert into T_Departamento(Nombre, Estado, Descripcion) values
			(@Nombre, @Estado, @Descripcion)

			set @Resultado = SCOPE_IDENTITY() 
		end
		else 
			set @Mensaje = 'Ya existe este departamento'
	end

go

CREATE PROC SP_EDITARDEPARTAMENTO
(
	@ID_Departamento int,
	@Nombre varchar(50),
	@Descripcion varchar(250),
	@Estado bit,
	@Resultado bit output,
	@Mensaje varchar(500) output
	)

as 
	begin
		set @Resultado = 1
		if not exists(select * from T_Departamento where Nombre = @Nombre and ID_Departamento != @ID_Departamento)
		begin
			update T_Departamento set
			Nombre = @Nombre,
			Descripcion = @Descripcion,
			Estado = @Estado
			where ID_Categoria = @ID_Categoria

		end
		else 
			begin
				set @Resultado = 0
				set @Mensaje = 'Ya existe este departamento'
			end
	end

go

CREATE PROC SP_ELIMINARDEPARTAMENTO
(
	@ID_Departamento int,
	@Resultado bit output,
	@Mensaje varchar(500) output
	)
	 
as 
	begin
		set @Resultado = 1
		if not exists(select * from T_Departamento d 
		inner join T_Empleado e on e.ID_Departamento = d.ID_Departamento
		where d.ID_Departamento = @ID_Departamento)
		begin
			delete top (1) from T_Departamento where ID_Departamento = @ID_Departamento
		end
		else 
			begin
				set @Resultado = 0
				set @Mensaje = 'No se puede eliminar este departamento, esta relacionada con un empleado'
			end
	end

/* ------------------------------- FIN PROCEDIMIENTOS DEPARTAMENTO -------------------------------*/

/* -------------------------------- INICIO PROCEDIMIENTOS EMPLEADO --------------------------------*/

/* -------------- GUARDAR EMPLEADO --------------*/
go
CREATE PROC SP_REGISTRAREMPLEADO
(
	@Nombre varchar(50),
	@Apellido varchar(50),
	@Cedula varchar(13),
	@Telefono varchar(12),
	@sexo varchar(5),
	@Direccion varchar(250),
	@Fecha_Nacimiento date,
	@ID_Departamento int,
	@Estado_Civil varchar(20),
	@Estado bit,
	@Fecha_Registro datetime
	)

as 
	begin
		set @Resultado = 0
		if not exists(select * from T_Empleado where Nombre = @Nombre)
		begin
			insert into T_Emplado(Nombre, Apellido, Cedula, Telefono, Sexo, Direccion, Fecha_Nacimiento, ID_Departamento, Estado_Civil, Estado, Fecha_Registro) values 
		(@Nombre, @Apellido, @Cedula, @Telefono, @Sexo, @Direccion, @Fecha_Nacimiento, @ID_Departamento, @Estado_Civil, @Estado, @Fecha_Registro )

			set @Resultado = SCOPE_IDENTITY() 
		end
		else 
			set @Mensaje = 'Ya existe este empleado'
	end

---------------EDITAR EMPLEADO ---------------

go
CREATE PROC SP_EDITAREMPLEADO
(
	@ID_Empleado int,
	@Nombre varchar(50),
	@Apellido varchar(50),
	@Cedula varchar(13),
	@Telefono varchar(12),
	@Direccion varchar(250),
	@Fecha_Nacimiento date,
	@ID_Departamento int,
	@Estado_Civil varchar(20),
	@Estado bit,
	@Fecha_Registro datetime
	)

as 
	begin
		set @Resultado = 1
		if not exists(select * from T_Empleado where Nombre = @Nombre and ID_Empleado != @ID_Empleado)
		begin
			update T_Empleado set
			Nombre = @Nombre,
			Apellido = @Apellido,
			Cedula = @Cedula,
			Telefono = @Telefono,
			Direccion = @Direccion,
			Feha_Nacimiento = @Fecha_Nacimiento,
			ID_Departamento = @ID_Departamento,
			Estado_Civil = @Estado_Civil,
			Estado = @Estado,
			Fecha_Registro = @Fecha_Registro
			
			where ID_Empleado = @ID_Empleado

		end
		else 
			begin
				set @Resultado = 0
				set @Mensaje = 'Ya existe este empleado'
			end
	end

---------------ELIMINAR EMPLEADO ---------------
go
CREATE PROC SP_ELIMINAREMPLEADO
(
	@ID_Empleado int,
	@Nombre varchar(50),
	@Apellido varchar(50),
	@Cedula varchar(13),
	@Telefono varchar(12),
	@Direccion varchar(250),
	@Fecha_Nacimiento date,
	@ID_Departamento int,
	@Estado_Civil varchar(20),
	@Estado bit,
	@Fecha_Registro datetime
	)

as 
	begin
		set @Resultado = 1
		if not exists(select * from T_Empleado c 
		inner join T_Departamento p on p.ID_Empleado = c.ID_Empleado
		where c.ID_Empleado = @ID_Empleado)
		begin
			delete top (1) from T_Empleado where ID_Empleado = @ID_Empleado
		end
		else 
			begin
				set @Resultado = 0
				set @Mensaje = 'No se puede eliminar este empleado, esta relacionada con un departamento'
			end
	end
/* -------------------------------- FIN PROCEDIMIENTOS EMPLEADO --------------------------------*/

/* -------------------------------- INICIO PROCEDIMIENTOS PRODUCTO --------------------------------*/

/* -------------- GUARDAR PRODUCTO --------------*/
go


CREATE PROC SP_REGISTRARPRODUCTO
(
	@Codigo varchar (30),
	@Nombre varchar(50),
	@Precio decimal(10,2),
	@ID_Categoria int,
	@Estado bit,
	@Fecha_Registro datetime
	)

as 
	begin
		set @Resultado = 0
		if not exists(select * from T_Producto where Nombre = @Nombre)
		begin
			insert into T_Produco(Nombre, Precio, ID_Categoria, Estado) values
			(@Nombre, @Precio, @ID_Categproa, @Estado)

			set @Resultado = SCOPE_IDENTITY() 
		end
		else 
			set @Mensaje = 'Ya existe este producto'
	end

---------------EDITAR PRODUCTO ---------------

go
CREATE PROC SP_EDITARPRODUCTO
(
	@ID_Proucto int,
	@Codigo varchar (30),
	@Nombre varchar(50),
	@Precio decimal(10,2),
	@ID_Categoria int,
	@Estado bit,
	@Fecha_Registro datetime
	)

as 
	begin
		set @Resultado = 1
		if not exists(select * from T_Producto where Nombre = @Nombre and ID_Producto != @ID_Producto)
		begin
			update T_Producto set
			Codigo = @Codigo,
			Nombre = @Nombre,
			Precio = @Precio,
			ID_Categoria= @ID_Categoria,
			Estado = @Estado,
			Fecha_Registro = @Fecha_Registro
			
			where ID_Producto = @ID_Producto

		end
		else 
			begin
				set @Resultado = 0
				set @Mensaje = 'Ya existe este Producto'
			end
	end

---------------ELIMINAR PRODUCTO ---------------
go
CREATE PROC SP_ELIMINARPRODUCTO
(
	@ID_Proucto int,
	@Codigo varchar (30),
	@Nombre varchar(50),
	@Precio desimal(10,2),
	@ID_Categoria int,
	@Estado bit,
	@Fecha_Registro datetime
	)
as 
	begin
		set @Resultado = 1
		if not exists(select * from T_Producto c 
		inner join T_Categoria p on p.ID_Producto = c.ID_Producto
		where c.ID_Producto = @ID_Producto)
		begin
			delete top (1) from T_Producto where ID_Producto = @ID_Producto
		end
		else 
			begin
				set @Resultado = 0
				set @Mensaje = 'No se puede eliminar este producto, esta relacionada con una categoria'
			end
	end
/* -------------------------------- FIN PROCEDIMIENTOS PRODUCTO --------------------------------*/

