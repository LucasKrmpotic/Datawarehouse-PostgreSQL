﻿CREATE OR REPLACE FUNCTION insercionclientes() RETURNS integer AS $$
DECLARE 
i integer;
nombres text[43]:= '{Juan, Maria,Mario,Mariana,Pedro, Josefina,Jose,Franco,Juana, Mirta, Silvia,Celeste, Mariano,Florencia,Raul, Gonzalo,Azul, Damian,Susana,Santiago, Karina,Claudio,Thiago ,Adrian,Rodrigo,Patricia,Javier, Erica, Gustavo,Lorena,Graciela, Mauricio,Laura,Gladys,Guillermo,Nicolas,Oscar,Monica,Viviana,Manuel,Angela,Angel,Luis, Fabricio}';
apellidos text[40]:='{Rodriguez,Perez,Sanchez,Ramirez,Gonzales, Evans, Williams,Roberts, Manrique,Diaz, Lopez, Alvarez,Navarro,Chavez, Riquelme,Torres,Mariqueo ,Quilaqueo,Gomez,Barrientos,Arias,Calfupan,Soto,Sosa,Vargas,Saavedra,Campos,Montesino,Vargas,Santillan,Romero,Hughes,Herrera,Garcia,Espinoza,Muñoz,Gallardo,Cuesta,Silva,Fernandez}';
tipos text[4]:='{Particular, Mayorista, Minorista, Distribuidor}';
direccion text[35]='{Pellegrini ,Rawson ,Belgrano ,San Martin ,Sarmiento ,Rivadavia ,Peron ,Ameghino ,28 de Julio ,25 de Mayo ,Marconi ,Pecoraro ,Centenario ,9 de Julio ,Julio A. Roca ,Vucetich ,Mitre ,Don Bosco ,Italia ,Mitre ,España ,Chile ,Cordoba ,Lewis Jones ,Lopez y Planes,Antartida Argentina ,Yrigoyen ,Rawson ,Edison ,Colombia ,Uruguay ,Lavalle ,Gales ,Urquiza ,Alem }';
BEGIN
FOR i IN 800..804 LOOP
    insert into "Clientes" ("nroCliente","nombre","tipo", "direccion")
    values (
      i, 
      nombres[ (floor(random() * 43 + 1))]||' '||apellidos[((floor(random() *  35+ 1)))],
      tipos[(floor(random() * 4 + 1))],direccion[(floor(random() * 35 + 1))] ||' ' || (floor(random() * 1901 + 100))
    );
	 END LOOP;
	 return 1;
END;
$$LANGUAGE plpgsql;