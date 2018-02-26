select dblink_connect('myconn', 'dbname=sucursalTW  user=postgres password=postgres');
	
	INSERT INTO "TeCliente" (csv)
	SELECT nro_cliente
	FROM dblink ('myconn', 'SELECT "nroCliente" FROM "Clientes"') as
                          consulta(nro_cliente integer);

	INSERT INTO "TeProducto" (csv)
	SELECT nroprod
	FROM dblink ('myconn', 'SELECT "nroProducto" FROM "Producto"') as
                          consulta(nroprod integer);

select  dblink_disconnect('myconn');




select dblink_connect('myconn', 'dbname=sucursalE  user=postgres password=postgres');

INSERT INTO "TeCliente" (csn)
	SELECT nro_cliente
	FROM dblink ('myconn', 'SELECT "codCliente" FROM "Clientes"') as
                          consulta(nro_cliente integer);

	INSERT INTO "TeProducto" (csn)
	SELECT nroprod
	FROM dblink ('myconn', 'SELECT "codProducto" FROM "Producto"') as
                          consulta(nroprod integer);

select  dblink_disconnect('myconn');

select dblink_connect('myconn', 'dbname=sucursalCR  user=postgres password=postgres');

INSERT INTO "TeCliente" (csn)
	SELECT nro_cliente
	FROM dblink ('myconn', 'SELECT "codCliente" FROM "Clientes"') as
                          consulta(nro_cliente integer);

	INSERT INTO "TeProducto" (csn)
	SELECT nroprod
	FROM dblink ('myconn', 'SELECT "codProducto" FROM "Producto"') as
                          consulta(nroprod integer);

select  dblink_disconnect('myconn');
