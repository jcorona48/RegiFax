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