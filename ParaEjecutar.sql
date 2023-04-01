/*
create PROC SP_ReporteVentasTopProducto(
@FechaInicio varchar(10),
@FechaFin varchar(10),
@ID_Empleado int = 0
)
as 
begin
	select TOP 15 p.Codigo as Codigo, p.Nombre, SUM(p.Cantidad) as Total_Vendido, c.Nombre as Categoria
	from T_VentaDetalle vd
	inner join T_Producto as p on p.ID_Producto = vd.ID_Producto
	inner join T_Categoria c on c.ID_Categoria = p.ID_Categoria
	inner join T_Ventas v on v.ID_Venta = vd.ID_Venta
	inner join T_Empleado e on e.ID_Empleado = v.ID_Empleado
	where CONVERT(date,V.Fecha_Registro) between @FechaInicio and @FechaFin
	and e.ID_Empleado = iif(@ID_Empleado=0,e.ID_Empleado,@ID_Empleado)
	group by p.Codigo, p.Nombre, c.Nombre
end

*/

--insert into T_VentaDetalle(ID_Venta, ID_Producto, Cantidad, Precio_Venta)
--values(3, 1, 3, 400)
/*
declare @FechaInicio varchar(50);
declare @FechaFin varchar(50);
declare @ID_Empleado int;
set @FechaInicio = '30/03/2023';
set @FechaFin = '30/03/2023';
set @ID_Empleado = 0;
set dateformat dmy;

	select TOP 10 c.Cedula, c.Nombre, c.Apellido, SUM(v.Precio_Neto) as Total_Comprado
	from T_Ventas v
	inner join T_Cliente c on c.ID_Cliente = v.ID_Cliente
	inner join T_Empleado e on e.ID_Empleado = v.ID_Empleado
	where CONVERT(date,V.Fecha_Registro) between @FechaInicio and @FechaFin
	and e.ID_Empleado = iif(@ID_Empleado=0,e.ID_Empleado,@ID_Empleado)
	group by c.Cedula, c.Nombre, c.Apellido
	*/
