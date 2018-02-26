
INSERT INTO "Venta"
SELECT distinct 
		v."fechaVenta", 
		v."nroFactura", 
		c.CDW,
		v."nombreCliente",  
		v."codmediopago", 
		v."sucursal", 
		t."idFecha",
		v.montovendido, 
		v.cantidadvendida, 
		p.cdw
FROM 
		tempventas v, 
		"TeCliente" c, 
		"TeProducto" p, 
		"Tiempo" t
WHERE 
		v."codigoCliente" = c.csv  
		and t.mes= v.mes 
		and t.año= v.año 
		and v.sucursal=12 
		and v."codigoProducto"=p.csv 
		and c.cdw not in (select "nroFactura" from "Venta");



