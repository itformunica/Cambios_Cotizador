

 CREATE TABLE fnica.fmlTransporte(
	IDTransporte INT IDENTITY(1,1) NOT NULL,
	Nombre NVARCHAR(254) NOT NULL,
	RazonSocial NVARCHAR(254) NOT NULL,
	RUC NVARCHAR(256),
	CodigoProveedor NVARCHAR(20),
	Activo BIT,
	FechaIngreso DATETIME,
	UsuarioIngreso NVARCHAR(20),
	FechaUpdate DATETIME,
	UsuarioActualizacion NVARCHAR(20)
 CONSTRAINT [pkfmlTransporte] PRIMARY KEY CLUSTERED 
(
	IDTransporte ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE fnica.fmlTransporte WITH CHECK ADD  CONSTRAINT fkTransporte_CodigoProveedor FOREIGN KEY(CodigoProveedor)
REFERENCES fnica.PROVEEDOR (IdProveedor)


GO

CREATE TABLE fnica.fmlTransorteConductor(
	IDConductor INT IDENTITY(1,1) NOT NULL,
	IDTransporte INT NOT NULL,
	Nombre NVARCHAR(254) NOT NULL,
	Telefono NVARCHAR(254) NOT NULL,
	Activo BIT,
	FechaIngreso DATETIME,
	UsuarioIngreso NVARCHAR(20),
	FechaUpdate DATETIME,
	UsuarioActualizacion NVARCHAR(20)
 CONSTRAINT pkfmlTransporteConductor PRIMARY KEY CLUSTERED 
(
	IDConductor ASC,
	IDTransporte asc
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE fnica.fmlTransorteConductor WITH CHECK ADD  CONSTRAINT fkTransporter_Conductor FOREIGN KEY(IDTransporte)
REFERENCES fnica.fmlTransporte (IDTransporte)

GO

CREATE TABLE fnica.fmlTransporteVehiculo(
	IDVehiculo INT IDENTITY(1,1) NOT NULL,
	IDConductor INT  NOT NULL,
	IDTransporte INT NOT NULL,
	Placa NVARCHAR(254) NOT NULL,
	Capacidad DECIMAL(28,4) DEFAULT 0 NOT NULL,
	Disponible BIT,
	Activo BIT,
	FechaIngreso DATETIME,
	UsuarioIngreso NVARCHAR(20),
	FechaUpdate DATETIME,
	UsuarioActualizacion NVARCHAR(20)
 CONSTRAINT pkfmlTransporteConductor PRIMARY KEY CLUSTERED 
(
	IDVehiculo ASC,
	IDConductor ASC,
	IDTransporte asc
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE fnica.fmlTransporteVehiculo WITH CHECK ADD  CONSTRAINT fkVehiculo_Transporte FOREIGN KEY(IDTransporte)
REFERENCES fnica.fmlTransporte (IDTransporte)

GO


ALTER TABLE fnica.fmlTransporteVehiculo WITH CHECK ADD  CONSTRAINT fkVehiculo_Conductor FOREIGN KEY(IDTransporte,IDVehiculo)
REFERENCES fnica.fmlTransorteConductor (IDTransporte,IDVehiculo)

GO

CREATE TABLE fnica.fmlEstdoPlanProduccion(
	IDEstado INT NOT NULL,
	Descr  NVARCHAR(250) NOT NULL,
	Activo BIT
CONSTRAINT pkfmlEstadoPlanProduccion PRIMARY KEY CLUSTERED
(
	IDEstado asc
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE fnica.fmlPlanProduccion(
	IDDetalleEntragaParcial INT,
	IDEntregaParcial INT  NOT NULL,
	IDFormula INT NOT NULL,
	Estado INT NOT NULL,
	Cantidad DECIMAL(28,4) DEFAULT 0 NOT NULL,
	OrdenProducción NVARCHAR(20),
	OrdenTrasladoMP NVARCHAR(20),
	FechaIngreso DATETIME,
	UsuarioIngreso NVARCHAR(20),
	FechaUpdate DATETIME,
	UsuarioActualizacion NVARCHAR(20)
 CONSTRAINT pkfmlTransporteConductor PRIMARY KEY CLUSTERED 
(
	IDDetalleEntragaParcial ASC,
	IDEntregaParcial ASC,
	IDFormula asc
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


GO

CREATE TABLE fnica.fmlGuiaTraslado(
	IDGuiaTraslado INT NOT NULL IDENTITY(1,1),
	OrdenTraslado NVARCHAR(20) NOT NULL,
	IDTransporte INT not NULL,
	IDVehiculo INT NOT NULL,
	IDConductor INT NOT NULL,
	Direccion NVARCHAR(256)
 CONSTRAINT pkfmlGuiaTraslado PRIMARY KEY CLUSTERED 
(
	IDGuiaTraslado ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE fnica.fmlGuiaTraslado WITH CHECK ADD  CONSTRAINT fmlGuiaTraslado_Transporte FOREIGN KEY (IDTransporte,IDVehiculo)
REFERENCES fnica.fmlVehiculoTransporte (IDTransporte,IDVehiculo)

GO

ALTER TABLE fnica.fmlGuiaTraslado WITH CHECK ADD  CONSTRAINT fmlGuiaTraslado_Vehiculo FOREIGN KEY (IDTransporte,IDConductor)
REFERENCES fnica.fmlTransorteConductor (IDTransporte,IDConductor)
