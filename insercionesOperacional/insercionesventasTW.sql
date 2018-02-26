CREATE OR REPLACE FUNCTION insercionventas() RETURNS integer AS $$
DECLARE 
i integer;
j int;
pagos text[35]='{Efectivo ,Debito ,Cheque,Tarjeta de Credito}';
aux int;
producto int;
unidad int;
seed real;
a integer[5];
BEGIN

FOR i IN 1..1000 LOOP
		
    aux=(floor(random() *  100 + 1));
    insert into "Venta" ("fechaVta","nroFactura","nroCliente", "nombre","formaPago")
    values (((now() - (random() * (now() - date '2009-12-01')))::date),
    i,aux ,
    (select nombre 
      from "Clientes" 
      where "nroCliente"= aux),pagos[(floor(random() * 4 + 1))]);
    a= numerorandom();

   for j in 1..5 loop
      producto= a[j];
      unidad=(floor(random() * 100 + 1));
      insert into "detalleVenta" 
          ( "nroFactura", "nroProducto","descripcion", "unidad", "precio" ) 
      values ( i,
        producto,
        (select nombre from "Producto" where "nroProducto"=producto), 
        unidad,
        (select "precioActual" from "Producto" where "nroProducto"=j)*unidad );
    end loop;
	 END LOOP;
	 return 1;
END;
$$LANGUAGE plpgsql;