--Categoría
CREATE TABLE "Categoria"(
  "nroCateg" integer NOT NULL,
  descripcion character varying,
  CONSTRAINT "pk_nroCateg" PRIMARY KEY ("nroCateg")
);

--Clientes
CREATE TABLE "Clientes"(
  "nroCliente" integer NOT NULL,
  nombre character varying,
  tipo character varying,
  direccion character varying,
  CONSTRAINT "pk_nroCliente" PRIMARY KEY ("nroCliente")
);

--Producto
CREATE TABLE "Producto"(
  "nroProducto" integer NOT NULL,
  nombre character varying,
  "nroCateg" integer,
  "precioActual" real,
  CONSTRAINT "pk_nroProducto" PRIMARY KEY ("nroProducto"),
  CONSTRAINT "fk_nroCateg" FOREIGN KEY ("nroCateg") REFERENCES "Categoria" ("nroCateg")
);

--Venta
CREATE TABLE "Venta"(
  "fechaVta" date,
  "nroFactura" integer NOT NULL,
  "nroCliente" integer,
  nombre character varying,
  "formaPago" character varying,
  CONSTRAINT "pk_NroFactura" PRIMARY KEY ("nroFactura"),
  CONSTRAINT "fk_nroCliente" FOREIGN KEY ("nroCliente") REFERENCES "Clientes" ("nroCliente")
);

--Detalle Venta
CREATE TABLE "detalleVenta"(
  "nroFactura" integer NOT NULL,
  descripcion character varying,
  precio real,
  "nroProducto" integer NOT NULL,
  unidad integer,
  CONSTRAINT pk_detalle PRIMARY KEY ("nroFactura", "nroProducto"),
  CONSTRAINT "fk_nroFactura" FOREIGN KEY ("nroFactura") REFERENCES "Venta" ("nroFactura") 
  CONSTRAINT "fk_nroProducto" FOREIGN KEY ("nroProducto") REFERENCES "Producto" ("nroProducto") 
);

