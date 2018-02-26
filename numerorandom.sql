CREATE OR REPLACE FUNCTION numerorandom()
  RETURNS integer[] AS
$$
declare 
arreglo integer[5];
i integer;
seed real;
valor integer;
begin
seed=(random() * 1 + (-1)); 	
select array( SELECT round(random()*(22)+1)::int r_num
    FROM   generate_series(1,15) 
    GROUP  by 1 
    LIMIT  5)
    into arreglo;
  return arreglo;

   end;
$$
  LANGUAGE plpgsql;