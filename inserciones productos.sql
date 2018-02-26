INSERT INTO "Producto"
SELECT  cdw, 
	v."nombreProducto",
	v."idCategoria", 
	v."idsubcategoria",  
	v."precio"
FROM 
	tempventas v, 
	"TeProducto" te
WHERE 
	v."codigoProducto"= te.csv  
	or v."codigoProducto"=te.csn   
	and  te.CDW not in (SELECT "idProducto" from "Producto") 
	on conflict ("idProducto") do nothing;
