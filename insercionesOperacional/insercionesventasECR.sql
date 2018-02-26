CREATE OR REPLACE FUNCTION insercionventas() RETURNS integer AS $$
DECLARE 
i integer;
pagos text[35]='{Efectivo ,Debito ,Cheque,Tarjeta de Credito}';
aux int;
a integer[5];
producto int;
unidad int;
BEGIN
FOR i IN 1..1000 LOOP
		
    aux=(floor(random() *  100+ 1));
    insert into "Venta" ("FechaVta","IdFactura","codCliente", "nombre","codMedioPago")
    values (((now() - (random() * (now() - date '2011-01-01')))::date),i,aux ,(select nombre from "Clientes" where "codCliente"= aux),(floor(random() * 4 + 1)));
    a= numerorandom();

    for j in 1..5 loop
      producto= a[j];
      unidad=(floor(random() * 100 + 1));
      insert into "detalleVenta" ("idFactura", "codProducto",descripcion, unidad, precio) values 
          ( i,producto,(select nombre from "Producto" where "codProducto"=producto), 
          unidad, 
          (select precioactual from "Producto" where "codProducto"=producto)*unidad);
    end loop;
    
END LOOP;
return 1;
END;
$$LANGUAGE plpgsql;