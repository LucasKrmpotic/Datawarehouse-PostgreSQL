--Categoria
CREATE TABLE "Categoria"(
  "codCategoria" integer NOT NULL,
  "codSubcategoia" integer NOT NULL,
  "descripción" character varying,
  CONSTRAINT pk_cod PRIMARY KEY ("codCategoria", "codSubcategoia")
);

--Clientes
CREATE TABLE "Clientes"(
  "codCliente" integer NOT NULL,
  nombre character varying,
  "codTipo" integer,
  domicilio character varying,
  CONSTRAINT "pk_codCliente" PRIMARY KEY ("codCliente"),
  CONSTRAINT "fk_codTipo" FOREIGN KEY ("codTipo") REFERENCES "tipoCliente" ("codTipo")
);

--Medio de Pago
CREATE TABLE "MedioPago"(
  "codMedioPago" integer NOT NULL,
  descripcion character varying,
  valor real,
  unidad integer,
  "tipoOperacion" character varying,
  CONSTRAINT "pk_codMedioPago" PRIMARY KEY ("codMedioPago")
);

--Producto
CREATE TABLE "Producto"(
  "codProducto" integer NOT NULL,
  nombre character varying,
  "codCategoria" integer,
  "codSubcategoria" integer NOT NULL,
  precioactual real,
  CONSTRAINT "pk_codProducto" PRIMARY KEY ("codProducto"),
  CONSTRAINT fk_cod FOREIGN KEY ("codCategoria", "codSubcategoria") REFERENCES "Categoria" ("codCategoria", "codSubcategoia")
);

--Venta 
CREATE TABLE "Venta"(
  "FechaVta" date,
  "IdFactura" integer NOT NULL,
  "codCliente" integer,
  nombre character varying,
  "codMedioPago" integer,
  CONSTRAINT "pk_idFactura" PRIMARY KEY ("IdFactura"),
  CONSTRAINT "fk_codCliente" FOREIGN KEY ("codCliente") REFERENCES "Clientes" ("codCliente")
);

--Detalle Venta 
CREATE TABLE "detalleVenta"(
  "idFactura" integer NOT NULL,
  "codProducto" integer NOT NULL,
  descripcion character varying,
  unidad integer,
  precio real,
  CONSTRAINT "pk_idFacturaCodProd" PRIMARY KEY ("idFactura", "codProducto"),
  CONSTRAINT "fk_codProducto" FOREIGN KEY ("codProducto") REFERENCES "Producto" ("codProducto"),
  CONSTRAINT "fk_idFactura" FOREIGN KEY ("idFactura") REFERENCES "Venta" ("IdFactura") 
);

--Tipo Cliente
CREATE TABLE "tipoCliente" (
  "codTipo" integer NOT NULL,
  descripcion character varying,
  CONSTRAINT "pk_codTipo" PRIMARY KEY ("codTipo")
);