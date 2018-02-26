--Categoría
CREATE TABLE "Categoria" ( 
    "idCategoria" integer NOT NULL,
    "idSubcategoria" integer NOT NULL,
    descripcion character varying,
    CONSTRAINT "pk_idCatSubCat" PRIMARY KEY ("idCategoria", "idSubcategoria")
);

--Producto
CREATE TABLE "Producto"(
  "idProducto" integer NOT NULL,
  nombre character varying,
  "idCategoria" integer,
  "idSubCategoria" integer,
  "precioActual" real,
  CONSTRAINT "pk_idProducto" PRIMARY KEY ("idProducto"),
  CONSTRAINT "fk_idCatSubCat" FOREIGN KEY ("idCategoria", "idSubCategoria") REFERENCES "Categoria" ("idCategoria", "idSubcategoria")
);

--Clientes
CREATE TABLE "Clientes"(
  "IdCliente" integer NOT NULL,
  nombre character varying,
  "idTipo" integer,
  descripcion character varying,
  CONSTRAINT "pk_idCliente" PRIMARY KEY ("IdCliente"),
  CONSTRAINT "fk_idTipo" FOREIGN KEY ("idTipo") REFERENCES "TipoCliente" ("idTipo") 
);

--Medio de Pago
CREATE TABLE "MedioPago"(
  "idMedioPago" integer NOT NULL,
  descripcion character varying,
  valor integer,
  unidad integer,
  "tipoOperacion" integer,
  CONSTRAINT pk_idmediopago PRIMARY KEY ("idMedioPago")
);

--Sucursal
CREATE TABLE "Sucursal"(
  "idSucursal" integer NOT NULL,
  direccion character varying,
  superficie integer,
  "idCiudad" integer,
  CONSTRAINT "pk_idSucursal" PRIMARY KEY ("idSucursal"),
  CONSTRAINT "fk_idCiudad" FOREIGN KEY ("idCiudad") REFERENCES "Ciudad" ("idCiudad")
);

--Ciudad
CREATE TABLE "Ciudad" (
  "idCiudad" integer NOT NULL,
  descripcion character varying,
  "idProvincia" integer,
  CONSTRAINT pk_ciudad PRIMARY KEY ("idCiudad")
  CONSTRAINT fk_provincia FOREIGN KEY ("idProvincia") REFERENCES "Provincia" ("idProvincia")
);

--Provincia
CREATE TABLE "Provincia"(
  "idProvincia" integer NOT NULL,
  descripcion character varying,
  "idRegion" integer,
  CONSTRAINT "pk_idProvincia" PRIMARY KEY ("idProvincia"),
  CONSTRAINT "fk_idRegion" FOREIGN KEY ("idRegion") REFERENCES "Region" ("idRegion")
);

--Región
CREATE TABLE "Region"(
  "idRegion" integer NOT NULL,
  descripcion character varying,
  CONSTRAINT "pk_idRegion" PRIMARY KEY ("idRegion")
);

--Tiempo
CREATE TABLE "Tiempo"(
  "idFecha" integer NOT NULL,
  mes integer,
  "año" integer,
  trimestre integer,
  CONSTRAINT "pk_idFecha" PRIMARY KEY ("idFecha")
);

--Venta
CREATE TABLE venta (
	fecha_vta date,
	"idFecha" integer NOT NULL,
	"idFactura" integer NOT NULL,
	"idCliente" integer NOT NULL,
	"idProducto" integer NOT NULL,
	"idSucursal" integer NOT NULL,
	"idMedioPago" integer NOT NULL,
	"montoVendido" real,
	"cantidadVendida" integer,
	CONSTRAINT fk_id_tiempo FOREIGN KEY ("idFecha") REFERENCES "Tiempo" ("idFecha"),
	CONSTRAINT fk_id_cliente FOREIGN KEY ("idCliente") REFERENCES "Clientes" ("idCliente"),
	CONSTRAINT fk_id_producto FOREIGN KEY ("idProducto") REFERENCES "Producto" ("idProducto"),
	CONSTRAINT fk_id_medio_pago FOREIGN KEY ("idMedioPago") REFERENCES "MedioPago" ("idMedioPago"),
	CONSTRAINT fk_id_sucursal FOREIGN KEY ("idSucursal") REFERENCES "Sucursal" ("idSucursal")
);

