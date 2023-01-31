use oltptelefonia
CREATE TABLE Area
( 
	IdArea               integer IDENTITY ( 1,1 ) ,
	Descripcion          varchar(30)  NOT NULL 
)
go



ALTER TABLE Area
	ADD CONSTRAINT XPKArea PRIMARY KEY  CLUSTERED (IdArea ASC)
go



CREATE TABLE Atencion
( 
	IdAtencion           integer IDENTITY ( 1,1 ) ,
	IdMedioAtencion      integer  NOT NULL ,
	IdPersonal           integer  NOT NULL ,
	IdMotivoAtencion     integer  NOT NULL ,
	IdCliente            integer  NOT NULL ,
	Fecha                datetime  NOT NULL 
)
go



ALTER TABLE Atencion
	ADD CONSTRAINT XPKAtencion PRIMARY KEY  CLUSTERED (IdAtencion ASC)
go



CREATE TABLE Cliente
( 
	IdCliente            integer IDENTITY ( 1,1 ) ,
	Nombre               varchar(50)  NOT NULL ,
	TipoDocumento        varchar(50)  NOT NULL 
	CONSTRAINT TipoDocumento_1634350181
		CHECK  ( TipoDocumento in ('DNI', 'RUC', 'Carné de Extranjería' )),
	TipoCliente          varchar(50)  NOT NULL 
	CONSTRAINT TipoCliente_190204358
		CHECK  ( TipoCliente in ('Natural', 'Jurídico') ),
	Sexo                 varchar(9)  NULL 
	CONSTRAINT Sexo_209506733
		CHECK  ( Sexo in ('Masculino', 'Femenino') ),
	NroDocumento         varchar(20)  NOT NULL ,
	IdDistrito           integer  NULL 
)
go



ALTER TABLE Cliente
	ADD CONSTRAINT XPKCliente PRIMARY KEY  CLUSTERED (IdCliente ASC)
go



CREATE TABLE Departamento
( 
	IdDepartamento       integer IDENTITY ( 1,1 ) ,
	Nombre               varchar(50)  NULL ,
	Codigo               varchar(2)  NOT NULL 
)
go



ALTER TABLE Departamento
	ADD CONSTRAINT XPKRegion PRIMARY KEY  CLUSTERED (IdDepartamento ASC)
go



CREATE TABLE DetallesLlamada
( 
	IdDetalle            integer IDENTITY ( 1,1 ) ,
	TipoDestino          varchar(10)  NOT NULL 
	CONSTRAINT TipoDestino_645758482
		CHECK  ( TipoDestino in ('Fijo', 'Movil') ),
	Destino              varchar(13)  NOT NULL 
	CONSTRAINT Destino_104938476
		CHECK  ( Destino in ('Nacional', 'Internacional') ),
	CostoPrepago         money  NOT NULL 
)
go



ALTER TABLE DetallesLlamada
	ADD CONSTRAINT XPKTarifaLlamada PRIMARY KEY  CLUSTERED (IdDetalle ASC)
go



CREATE TABLE DetallesMensaje
( 
	IdDetalle            integer IDENTITY ( 1,1 ) ,
	TipoMensaje          char(3)  NOT NULL 
	CONSTRAINT TipoMensaje_929856292
		CHECK  ( TipoMensaje in ('SMS', 'MMS') ),
	Destino              varchar(13)  NOT NULL 
	CONSTRAINT Destino_120600043
		CHECK  ( Destino in ('Nacional', 'Internacional') ),
	CostoPrepago         money  NOT NULL 
)
go



ALTER TABLE DetallesMensaje
	ADD CONSTRAINT XPKTarifaMensaje PRIMARY KEY  CLUSTERED (IdDetalle ASC)
go



CREATE TABLE DetallesPlan
( 
	IdDetallesPlan       integer IDENTITY ( 1,1 ) ,
	TipoPlan             varchar(30)  NOT NULL 
	CONSTRAINT TipoPlan_1256840958
		CHECK  ( TipoPlan in ('Prepago', 'Pospago', 'Fijo') ),
	CostoMensual         money  NOT NULL ,
	NivelLlamNac         varchar(30)  NOT NULL 
	CONSTRAINT NivelLlamNac_1363592087
		CHECK  ( NivelLlamNac in ('Limitado', 'Ilimitado') ),
	NivelLlamInt         varchar(30)  NOT NULL 
	CONSTRAINT NivelLlamInt_1362943417
		CHECK  ( NivelLlamInt in ('Limitado', 'Ilimitado') ),
	NivelMensajes        varchar(30)  NOT NULL 
	CONSTRAINT NivelMensajes_1715282953
		CHECK  ( NivelMensajes in ('Limitado', 'Ilimitado') ),
	MinutosLlamNac       integer  NULL ,
	MinutosLlamInt       integer  NULL ,
	NroMensajes          integer  NULL ,
	Descripcion          varchar(30)  NOT NULL 
)
go



ALTER TABLE DetallesPlan
	ADD CONSTRAINT XPKDetallesPlan PRIMARY KEY  CLUSTERED (IdDetallesPlan ASC)
go



CREATE TABLE Distrito
( 
	IdDistrito           integer IDENTITY ( 1,1 ) ,
	Nombre               varchar(50)  NOT NULL ,
	IdProvincia          integer  NOT NULL 
)
go



ALTER TABLE Distrito
	ADD CONSTRAINT XPKDistrito PRIMARY KEY  CLUSTERED (IdDistrito ASC)
go



CREATE TABLE Llamada
( 
	IdLlamada            integer IDENTITY ( 1,1 ) ,
	Duracion             integer  NOT NULL ,
	Fecha                datetime  NOT NULL ,
	Numero               varchar(20)  NOT NULL ,
	IdPlan               integer  NOT NULL ,
	CostoPrepago         money  NULL ,
	IdDetalle            integer  NULL ,
	TipoCobro            varchar(13)  NOT NULL 
	CONSTRAINT TipoCobro_2088195722
		 DEFAULT  'No gratuito'
	CONSTRAINT TipoCobro_2088195725
		CHECK  ( TipoCobro in ('No gratuito', 'Gratuito') )
)
go



ALTER TABLE Llamada
	ADD CONSTRAINT XPKLlamada PRIMARY KEY  CLUSTERED (IdPlan ASC,IdLlamada ASC)
go



CREATE TABLE MedioAtencion
( 
	IdMedioAtencion      integer IDENTITY ( 1,1 ) ,
	Descripcion          varchar(30)  NOT NULL 
)
go



ALTER TABLE MedioAtencion
	ADD CONSTRAINT XPKTipoAtencion PRIMARY KEY  CLUSTERED (IdMedioAtencion ASC)
go



CREATE TABLE MedioPago
( 
	IdMedioPago          integer IDENTITY ( 1,1 ) ,
	Nombre               varchar(30)  NOT NULL ,
	IdTipoMedioPago      integer  NOT NULL 
)
go



ALTER TABLE MedioPago
	ADD CONSTRAINT XPKMedioPago PRIMARY KEY  CLUSTERED (IdMedioPago ASC)
go



CREATE TABLE Mensaje
( 
	IdMensaje            integer IDENTITY ( 1,1 ) ,
	Fecha                datetime  NULL ,
	Numero               varchar(20)  NOT NULL ,
	IdPlan               integer  NOT NULL ,
	IdDetalle            integer  NULL ,
	CostoPrepago         money  NULL ,
	TipoCobro            varchar(13)  NOT NULL 
	CONSTRAINT TipoCobro_2072534153
		 DEFAULT  'No gratuito'
	CONSTRAINT TipoCobro_2072534158
		CHECK  ( TipoCobro in ('No gratuito', 'Gratuito') )
)
go



ALTER TABLE Mensaje
	ADD CONSTRAINT XPKMensaje PRIMARY KEY  CLUSTERED (IdMensaje ASC,IdPlan ASC)
go



CREATE TABLE MotivoAtencion
( 
	IdMotivoAtencion     integer IDENTITY ( 1,1 ) ,
	Descripcion          varchar(30)  NOT NULL 
)
go



ALTER TABLE MotivoAtencion
	ADD CONSTRAINT XPKMotivoAtencion PRIMARY KEY  CLUSTERED (IdMotivoAtencion ASC)
go



CREATE TABLE MotivoBaja
( 
	IdMotivoBaja         integer IDENTITY ( 1,1 ) ,
	Descripcion          varchar(30)  NOT NULL 
)
go



ALTER TABLE MotivoBaja
	ADD CONSTRAINT XPKBaja PRIMARY KEY  CLUSTERED (IdMotivoBaja ASC)
go



CREATE TABLE Oferta
( 
	IdOferta             integer IDENTITY ( 1,1 ) ,
	MontoMinimo          money  NOT NULL ,
	FechaInicio          datetime  NOT NULL ,
	FechaFin             datetime  NOT NULL ,
	Meta                 money  NOT NULL ,
	IdTipoOferta         integer  NOT NULL ,
	Descripcion          varchar(30)  NOT NULL 
)
go



ALTER TABLE Oferta
	ADD CONSTRAINT XPKOferta PRIMARY KEY  CLUSTERED (IdOferta ASC)
go



CREATE TABLE Personal
( 
	IdPersonal           integer IDENTITY ( 1,1 ) ,
	Nombres              varchar(50)  NOT NULL ,
	Apellidos            varchar(50)  NOT NULL ,
	Direccion            varchar(50)  NULL ,
	FechaNacimiento      datetime  NOT NULL ,
	Sexo                 varchar(9)  NULL 
	CONSTRAINT Sexo_1721681086
		CHECK  ( Sexo in ('Masculino', 'Femenino') ),
	IdDistrito           integer  NULL ,
	FechaContratacion    datetime  NOT NULL ,
	Estado               varchar(30)  NOT NULL 
	CONSTRAINT DefaultEstado_2019180060
		 DEFAULT  'Activo'
	CONSTRAINT estado_568847837
		CHECK  ( Estado in ('Activo', 'Inactivo') ),
	DNI                  char(8)  NOT NULL ,
	IdPuesto             integer  NOT NULL ,
	FechaFinContratacion datetime  NULL 
)
go



ALTER TABLE Personal
	ADD CONSTRAINT XPKPersonal PRIMARY KEY  CLUSTERED (IdPersonal ASC)
go



CREATE TABLE Plan_Fijo
( 
	IdPlan               integer  NOT NULL ,
	Direccion            varchar(50)  NOT NULL ,
	IdDistrito           integer  NOT NULL ,
	MinutosLlamNac       integer  NOT NULL ,
	MinutosLlamInt       integer  NOT NULL ,
	CostoMensual         money  NOT NULL 
)
go



ALTER TABLE Plan_Fijo
	ADD CONSTRAINT XPKPlan_Fijo PRIMARY KEY  CLUSTERED (IdPlan ASC)
go



CREATE TABLE Plan_Pospago
( 
	IdPlan               integer  NOT NULL ,
	MinutosLlamNac       integer  NOT NULL ,
	NroMensajes          integer  NOT NULL ,
	CostoMensual         money  NOT NULL ,
	MinutosLlamInt       integer  NOT NULL 
)
go



ALTER TABLE Plan_Pospago
	ADD CONSTRAINT XPKPlan_Postpago PRIMARY KEY  CLUSTERED (IdPlan ASC)
go



CREATE TABLE Plan_Prepago
( 
	IdPlan               integer  NOT NULL ,
	Saldo                money  NOT NULL ,
	FechaVencimiento     datetime  NOT NULL 
)
go



ALTER TABLE Plan_Prepago
	ADD CONSTRAINT XPKPlan_Prepago PRIMARY KEY  CLUSTERED (IdPlan ASC)
go



CREATE TABLE PlanContratado
( 
	IdPlan               integer IDENTITY ( 1,1 ) ,
	FechaCreacion        datetime  NOT NULL ,
	Estado               varchar(8)  NOT NULL 
	CONSTRAINT DefaultEstado_1412051579
		 DEFAULT  'Activo'
	CONSTRAINT estado_1653123312
		CHECK  ( Estado in ('Activo', 'Inactivo') ),
	IdCliente            integer  NOT NULL ,
	FechaBaja            datetime  NULL ,
	Numero               varchar(9)  NOT NULL ,
	IdDetallesPlan       integer  NOT NULL ,
	IdMotivoBaja         integer  NULL 
)
go



ALTER TABLE PlanContratado
	ADD CONSTRAINT XPKPlan PRIMARY KEY  CLUSTERED (IdPlan ASC)
go



CREATE TABLE Provincia
( 
	IdProvincia          integer IDENTITY ( 1,1 ) ,
	Nombre               varchar(50)  NOT NULL ,
	IdDepartamento       integer  NOT NULL 
)
go



ALTER TABLE Provincia
	ADD CONSTRAINT XPKProvincia PRIMARY KEY  CLUSTERED (IdProvincia ASC)
go



CREATE TABLE Puesto
( 
	IdPuesto             integer IDENTITY ( 1,1 ) ,
	Descripcion          varchar(30)  NOT NULL ,
	IdArea               integer  NOT NULL 
)
go



ALTER TABLE Puesto
	ADD CONSTRAINT XPKPuesto PRIMARY KEY  CLUSTERED (IdPuesto ASC)
go



CREATE TABLE Recarga
( 
	IdRecarga            integer IDENTITY ( 1,1 ) ,
	IdPlan               integer  NOT NULL ,
	Saldo                money  NOT NULL ,
	FechaRecarga         datetime  NOT NULL ,
	IdOferta             integer  NULL ,
	IdMedioPago          integer  NULL 
)
go



ALTER TABLE Recarga
	ADD CONSTRAINT XPKRecarga PRIMARY KEY  CLUSTERED (IdRecarga ASC,IdPlan ASC)
go



CREATE TABLE Recibo
( 
	IdRecibo             integer IDENTITY ( 1,1 ) ,
	Monto                money  NOT NULL ,
	FechaEmision         datetime  NOT NULL ,
	Estado               varchar(30)  NOT NULL 
	CONSTRAINT Default_Value_1163_2051812101
		 DEFAULT  'Emitido'
	CONSTRAINT EstadoRecibo_914503298
		CHECK  ( Estado in ('Emitido', 'Vencido', 'Pagado') ),
	FechaPago            datetime  NULL ,
	FechaVencimiento     datetime  NOT NULL ,
	IdPlan               integer  NOT NULL ,
	IdMedioPago          integer  NULL 
)
go



ALTER TABLE Recibo
	ADD CONSTRAINT XPKRecibo PRIMARY KEY  CLUSTERED (IdRecibo ASC)
go



CREATE TABLE Reclamo
( 
	IdReclamo            integer IDENTITY ( 1,1 ) ,
	IdPlan               integer  NOT NULL ,
	DetallesReclamo      varchar(1000)  NOT NULL ,
	IdTipoReclamo        integer  NOT NULL ,
	Estado               varchar(20)  NOT NULL 
	CONSTRAINT DefaultEstadoReclamo_1345201524
		 DEFAULT  'En espera'
	CONSTRAINT EstadoReclamo_2093036861
		CHECK  ( Estado in ('En espera', 'Atendido', 'Resuelto') ),
	FechaReclamo         datetime  NOT NULL ,
	FechaAtencion        datetime  NULL ,
	Observaciones        varchar(1000)  NULL ,
	IdPersonal           integer  NULL ,
	IdAtencion           integer  NOT NULL 
)
go
ALTER TABLE Reclamo
	ADD CONSTRAINT XPKReclamo PRIMARY KEY  CLUSTERED (IdReclamo ASC,IdPlan ASC)
go



CREATE TABLE TipoMedioPago
( 
	IdTipoMedioPago      integer IDENTITY ( 1,1 ) ,
	Descripcion          varchar(30)  NOT NULL 
)
go



ALTER TABLE TipoMedioPago
	ADD CONSTRAINT XPKTipoMedioPago PRIMARY KEY  CLUSTERED (IdTipoMedioPago ASC)
go



CREATE TABLE TipoOferta
( 
	IdTipoOferta         integer IDENTITY ( 1,1 ) ,
	TipoOferta           varchar(30)  NOT NULL 
)
go



ALTER TABLE TipoOferta
	ADD CONSTRAINT XPKTipoOferta PRIMARY KEY  CLUSTERED (IdTipoOferta ASC)
go



CREATE TABLE TipoReclamo
( 
	IdTipoReclamo        integer IDENTITY ( 1,1 ) ,
	Descripcion          varchar(30)  NOT NULL 
)
go



ALTER TABLE TipoReclamo
	ADD CONSTRAINT XPKTipoReclamo PRIMARY KEY  CLUSTERED (IdTipoReclamo ASC)
go




ALTER TABLE Atencion
	ADD CONSTRAINT R_50 FOREIGN KEY (IdMedioAtencion) REFERENCES MedioAtencion(IdMedioAtencion)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Atencion
	ADD CONSTRAINT R_51 FOREIGN KEY (IdPersonal) REFERENCES Personal(IdPersonal)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Atencion
	ADD CONSTRAINT R_52 FOREIGN KEY (IdMotivoAtencion) REFERENCES MotivoAtencion(IdMotivoAtencion)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Atencion
	ADD CONSTRAINT R_53 FOREIGN KEY (IdCliente) REFERENCES Cliente(IdCliente)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Cliente
	ADD CONSTRAINT R_56 FOREIGN KEY (IdDistrito) REFERENCES Distrito(IdDistrito)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Distrito
	ADD CONSTRAINT R_27 FOREIGN KEY (IdProvincia) REFERENCES Provincia(IdProvincia)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Llamada
	ADD CONSTRAINT R_37 FOREIGN KEY (IdPlan) REFERENCES PlanContratado(IdPlan)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Llamada
	ADD CONSTRAINT R_39 FOREIGN KEY (IdDetalle) REFERENCES DetallesLlamada(IdDetalle)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE MedioPago
	ADD CONSTRAINT R_61 FOREIGN KEY (IdTipoMedioPago) REFERENCES TipoMedioPago(IdTipoMedioPago)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Mensaje
	ADD CONSTRAINT R_38 FOREIGN KEY (IdPlan) REFERENCES PlanContratado(IdPlan)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Mensaje
	ADD CONSTRAINT R_40 FOREIGN KEY (IdDetalle) REFERENCES DetallesMensaje(IdDetalle)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Oferta
	ADD CONSTRAINT R_44 FOREIGN KEY (IdTipoOferta) REFERENCES TipoOferta(IdTipoOferta)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Personal
	ADD CONSTRAINT R_36 FOREIGN KEY (IdDistrito) REFERENCES Distrito(IdDistrito)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Personal
	ADD CONSTRAINT R_46 FOREIGN KEY (IdPuesto) REFERENCES Puesto(IdPuesto)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Plan_Fijo
	ADD CONSTRAINT R_3 FOREIGN KEY (IdPlan) REFERENCES PlanContratado(IdPlan)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Plan_Fijo
	ADD CONSTRAINT R_28 FOREIGN KEY (IdDistrito) REFERENCES Distrito(IdDistrito)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Plan_Pospago
	ADD CONSTRAINT R_2 FOREIGN KEY (IdPlan) REFERENCES PlanContratado(IdPlan)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Plan_Prepago
	ADD CONSTRAINT R_1 FOREIGN KEY (IdPlan) REFERENCES PlanContratado(IdPlan)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE PlanContratado
	ADD CONSTRAINT R_25 FOREIGN KEY (IdCliente) REFERENCES Cliente(IdCliente)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE PlanContratado
	ADD CONSTRAINT R_57 FOREIGN KEY (IdDetallesPlan) REFERENCES DetallesPlan(IdDetallesPlan)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE PlanContratado
	ADD CONSTRAINT R_58 FOREIGN KEY (IdMotivoBaja) REFERENCES MotivoBaja(IdMotivoBaja)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Provincia
	ADD CONSTRAINT R_26 FOREIGN KEY (IdDepartamento) REFERENCES Departamento(IdDepartamento)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Puesto
	ADD CONSTRAINT R_45 FOREIGN KEY (IdArea) REFERENCES Area(IdArea)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Recarga
	ADD CONSTRAINT R_19 FOREIGN KEY (IdPlan) REFERENCES Plan_Prepago(IdPlan)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Recarga
	ADD CONSTRAINT R_43 FOREIGN KEY (IdOferta) REFERENCES Oferta(IdOferta)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Recarga
	ADD CONSTRAINT R_63 FOREIGN KEY (IdMedioPago) REFERENCES MedioPago(IdMedioPago)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Recibo
	ADD CONSTRAINT R_60 FOREIGN KEY (IdPlan) REFERENCES PlanContratado(IdPlan)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Recibo
	ADD CONSTRAINT R_62 FOREIGN KEY (IdMedioPago) REFERENCES MedioPago(IdMedioPago)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Reclamo
	ADD CONSTRAINT R_17 FOREIGN KEY (IdPlan) REFERENCES Plan_Fijo(IdPlan)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Reclamo
	ADD CONSTRAINT R_20 FOREIGN KEY (IdTipoReclamo) REFERENCES TipoReclamo(IdTipoReclamo)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Reclamo
	ADD CONSTRAINT R_49 FOREIGN KEY (IdPersonal) REFERENCES Personal(IdPersonal)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Reclamo
	ADD CONSTRAINT R_54 FOREIGN KEY (IdAtencion) REFERENCES Atencion(IdAtencion)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go
