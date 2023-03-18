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

