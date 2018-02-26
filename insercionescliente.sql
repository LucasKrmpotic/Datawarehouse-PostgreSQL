INSERT INTO "Clientes"
SELECT DISTINCT 
		cdw, 
		"nombreCliente", 
		Tipo
FROM 
		tempventas v, 
		"TeCliente" te
WHERE 
		v."codigoCliente" = te.CSV 
		and v.sucursal= 12  
		AND te.CDW 
			not in (SELECT "IdCliente" from "Clientes");

INSERT INTO "Clientes"
SELECT DISTINCT 
		cdw, 
		"nombreCliente", 
		Tipo
FROM 
		tempventas v, 
		"TeCliente" te
WHERE 
		v."codigoCliente" = te.csn 
		and v.sucursal= 11  
		AND te.CDW not in (SELECT "IdCliente" from "Clientes");

INSERT INTO "Clientes"
SELECT DISTINCT 
		cdw, 
		"nombreCliente", 
		Tipo
FROM 
		tempventas v, 
		"TeCliente" te
WHERE 
		v."codigoCliente" = te.csn 
		and v.sucursal=13 
		AND te.CDW not in (SELECT "IdCliente" from "Clientes");

