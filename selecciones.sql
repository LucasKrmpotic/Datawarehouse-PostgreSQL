CREATE OR REPLACE FUNCTION etl(sucursal integer, mes integer, "año" integer) 
RETURNS integer AS $$
DECLARE 
	nom char varying;
	nombrea char varying;
BEGIN
	if ( sucursal=11) then 
    	perform dblink_connect('myconn', 'dbname=sucursalCR  user=postgres password=postgres');
	else if (sucursal=12) then 
		perform dblink_connect('myconn', 'dbname=sucursalTW  user=postgres password=postgres');
		else if (sucursal=13) then 
   			perform dblink_connect('myconn', 'dbname=sucursalE  user=postgres password=postgres');
    	  	else 
        		raise notice 'error  sucursal inexistente % ', sucursal; 
        		return -1;
      		end if; 
  		end if; 
 	end if; 

if ( sucursal= 11 or sucursal=13) then 

insert  into tempventas select * from dblink ('myconn',
    'SELECT 
        "FechaVta", 
        "IdFactura", 
        v."codCliente", 
        dv."codProducto", 
        ' || sucursal ||  'as idSucursal,
        '|| mes||' as mes,
        '|| año||'as año, 
        "codMedioPago", 
        unidad * precioactual as montovendido, 
        unidad as cantidadvendida, 
        p.nombre, 
        p."codCategoria", 
        p."codSubcategoria", 
        p.precioactual, 
        c.nombre, 
        c."codTipo"	
FROM 
        "Venta" v, 
        "detalleVenta" dv, 
        "Clientes" c, 
        "Producto" p
WHERE 
        v."IdFactura" = dv."idFactura" 
        and v."codCliente" = c."codCliente"
        and dv."codProducto" = p."codProducto"
        and (select (date_part( ''month'',"FechaVta")))=  '|| mes || '
        and (select (date_part(''year'',"FechaVta"))) = ' || año  )
        as t 
            ("FechaVta" date, 
              "nroFactura" integer, 
              "codigoCliente" integer, 
              "codigoProducto" integer, 
              sucursal integer, 
              mes integer, 
              año integer, 
              cod_medio_pago integer, 
              montovendido real, 
              cantidadvendida integer,
              "nombreProducto" varchar(30), 
              "idCategoria" integer, 
              idsubcategoria integer, 
              precio real, 
              "nombreCliente" varchar(30), 
              tipo integer) ;
end if; 


if ( sucursal =12) then 
insert into tempventas  select *  from dblink ('myconn','SELECT "fechaVta", v."nroFactura", v."nroCliente", dv."nroProducto", ' || sucursal ||  
'as idSucursal,'|| mes||' as mes,'|| año||'as año ,null, (unidad * "precioActual") as montovendido, unidad, 
p.nombre, p."nroCateg",null, p."precioActual", c.nombre, null	
FROM "Venta" v, "detalleVenta" dv, "Clientes" c, "Producto" p
WHERE v."nroFactura" = dv."nroFactura" and
             v."nroCliente" = c."nroCliente"
            and dv."nroProducto" = p."nroProducto"
            and   (select date_part( ''month'',v."fechaVta" ))=' || mes||  '
            and  (select date_part (''year'', v."fechaVta"))= ' || año  )
as t ("fechaVenta" date, "nroFactura" integer, "codigoCliente" integer, "codigoProducto" integer, sucursal integer, mes integer, a�o integer, codigo integer,  montovendido real, unidad integer,"nombreProducto" varchar(30), "idCategoria" integer, subcategoria integer,  precio real, "nombreCliente" varchar(30), tipo integer) ;
end if; 

perform  dblink_disconnect('myconn');
return 1;
	

END;
$$LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION selecciones() RETURNS integer AS$$
DECLARE 
nom char varying;
nombrea char varying ;
i integer;
j integer;
sucursal integer:=11;
mes integer=12 ;
año integer:=2009;
l integer;
codigo integer:=1;
BEGIN
 for l in 1..8 loop
	año=año+1;
	sucursal=11;
        for j in  1..3 loop
			for mes in 1..12 loop
				perform etl(sucursal,mes,año);
				if (sucursal=13)  then 
				insert into "Tiempo" values (codigo,mes,año);
				codigo= codigo+1;
				end if;
	         end loop;
		sucursal=sucursal+1;
	end loop;
end loop;
return 1;
END;
$$LANGUAGE plpgsql;





