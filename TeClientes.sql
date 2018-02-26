CREATE OR REPLACE FUNCTION teclientes2() RETURNS integer AS$$
DECLARE 

    cursor "TeCliente"%rowtype;
    nom char varying;
    nombrea char varying ;
    cod integer;
    codigo integer;
BEGIN
    perform dblink_connect('myconn', 'dbname=sucursal-Trelew  user=dblinktest password=prueba');
    CREATE VIEW vremote AS   SELECT * FROM dblink('myconn','SELECT * FROM "Clientes"' )AS t("nroCliente" int, nombre varchar(30), "tipo" varchar(30), "direccion" varchar(30)); 
    
    perform dblink_connect('myconn1', 'dbname=Sucursal-ComodoroRivadavia user=dblinktest password=prueba');
    CREATE VIEW vremote1 AS   SELECT * FROM dblink('myconn1','SELECT * FROM "Clientes"' )AS b("codCliente" int, nombre varchar(30), "codTipo" int, domicilio varchar(30) ); 

    perform dblink_connect('myconn2', 'dbname=sucursal-Esquel user=dblinktest password=prueba');
    CREATE VIEW vremote2 AS   SELECT * FROM dblink('myconn2','SELECT * FROM "Clientes"' )AS c("codCliente" int, nombre varchar(30), "codTipo" int, domicilio varchar(30) ); 
    
    open cursorCliente;
    
    LOOP
        fetch cursorCliente into cursor;
        exit when not found;

        nom:=(select distinct nombre 
            from 
                vremote,
                "TeCliente" 
            where  
                cursor."csv"=vremote."nroCliente" 
                and cursor."csv" is not null )as d;
        
        
        if ( select  
                count(*) 
            from 
                vremote1 
            where 
                vremote1.nombre= nom)=1 then

                cod :=(
                    select 
                        vremote1."codCliente" 
                    from vremote1 
                        where vremote1.nombre= nom)limit 1;
            
                    update 
                        "TeCliente" 
                    set  
                        csn= cod   
                    where   
                        "TeCliente".csv= cursor.csv  
                        and csn is null ;                    
            
                    delete from "TeCliente" 
                    where csn=cod and csv is null;        
        end if;

        if (select 
                count(*) 
            from 
                vremote2 
            where vremote2.nombre= nom)=1 then 
            cod :=(select  vremote2."codCliente" from vremote2 where vremote2.nombre= nom);
            update "TeCliente" set  csn= cod   where   "TeCliente".csv= cursor.csv  and csn is null ;                    
            delete from "TeCliente" where csn=cod and csv is null;        
    
        end if;
        
    END LOOP;
    perform  dblink_disconnect('myconn');   
    perform  dblink_disconnect('myconn1');
    perform  dblink_disconnect('myconn2');
    close cursorCliente;
    drop view vremote;
    drop view vremote1;
    drop view vremote2;
    return 1;
    
end; 
$$LANGUAGE plpgsql;
