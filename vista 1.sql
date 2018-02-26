 select t.mes, t.año, s."idSucursal",r."descripcion", cs."nombre"
from "Venta" v , "Clientes" cs, "Sucursal" s, "Provincia" p, "Region" r, "Ciudad" c, "Tiempo" t, "TeCliente" tc
where cs."IdCliente"=v."idCliente"  and v."idTiempo"=t."idFecha" and v."idSucursal"=s."idSucursal" and  s."idCiudad"= c."idCiudad" and c."idProvincia"=p."idProvincia" 
group by rollup(t.mes,t.año), cube(s."idSucursal",(r."idRegion",r.descripcion),(p."idProvincia",p.descripcion),(cs."IdCliente",cs.nombre));