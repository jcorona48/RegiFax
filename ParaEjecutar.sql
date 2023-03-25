


CREATE PROC SP_REGISTRAREMPLEADO
(
	@Nombre varchar(50),
	@Apellido varchar(50),
	@Cedula varchar(13),
	@Sexo varchar(50),
	@Telefono varchar(12),
	@Direccion varchar(250),
	@Fecha_Nacimiento date,
	@ID_Departamento int,
	@Estado_Civil varchar(20),
	@Estado bit,
	@Resultado int output,
	@Mensaje varchar(500) output
	)

as 
	begin
		set @Resultado = 0
		if not exists(select * from T_Empleado where Cedula = @Cedula)
		begin
			insert into T_Empleado(Nombre, Apellido, Cedula, Telefono, Sexo, Direccion, Fecha_Nacimiento, ID_Departamento, Estado_Civil, Estado) values 
		(@Nombre, @Apellido, @Cedula, @Telefono, @Sexo, @Direccion, @Fecha_Nacimiento, @ID_Departamento, @Estado_Civil, @Estado )

			set @Resultado = SCOPE_IDENTITY() 
		end
		else 
			set @Mensaje = 'Ya existe este empleado'
	end
