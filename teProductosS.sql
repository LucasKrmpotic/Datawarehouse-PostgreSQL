CREATE OR REPLACE FUNCTION teproductos()
  RETURNS integer AS
$$
DECLARE 
cursorProd CURSOR  FOR SELECT * FROM "TeProducto";
cursor "TeProducto"%rowtype;
nom varchar;
nombrea char varying ;
cod integer;
codigo integer;

BEGIN
	perform dblink_connect('myconn', 'dbname=sucursal-Trelew  user=postgres password=postgres');
	CREATE VIEW vremote AS   SELECT * FROM dblink('myconn','SELECT * FROM "Producto"' )AS 
	t("nroProducto" int, nombre varchar(30), "nroCateg" integer, "precioActual" real); 
	
	perform dblink_connect('myconn1', 'dbname=Sucursal-ComodoroRivadavia user=postgres password=postgres');
	CREATE VIEW vremote1 AS   SELECT * FROM dblink('myconn1','SELECT * FROM "Producto"' )AS b("codProducto" int, nombre varchar(30), "codCategoria" int, "codSubcategoria" integer, precioactual real ); 
	
	open cursorProd;
	
	
	LOOP
		fetch cursorProd into cursor;
		exit when not found;

		nom:=(select distinct nombre from vremote,"TeProducto" where  cursor."csv"=vremote."nroProducto" and cursor."csv" is not null )as d;
		raise notice '%', nom;
		
		
                if ( select count(*) from vremote1 where vremote1.nombre= nom)=1 then 
                cod :=(select  vremote1."codProducto" from vremote1 where vremote1.nombre= nom)limit 1;
               
                raise notice '%', cod;
                     raise notice '%',cursor;
                     update "TeProducto" set  csn= cod   where   "TeProducto".csv= cursor.csv  and csn is null ;                    
                     delete from "TeProducto" where csn=cod and csv is null;
               
                
  raise notice ' d %',codigo;
		end if;
	END LOOP;
	perform  dblink_disconnect('myconn');
	
	perform  dblink_disconnect('myconn1');

	close cursorProd;
	drop view vremote;
	drop view vremote1;
return 1;
end; 
$$
  LANGUAGE plpgsql;