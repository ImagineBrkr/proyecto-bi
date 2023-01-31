 IF NOT EXISTS(SELECT name FROM sys.databases WHERE name = 'OLAPTelefonia')
  BEGIN
    CREATE DATABASE OLAPTelefonia
   END

   use OLAPTelefonia

CREATE TABLE dimCliente
( 
	keyCliente           integer IDENTITY ( 1,1 ) ,
	TipoCliente          varchar(30)  NOT NULL ,
	Sexo                 varchar(9)  NOT NULL ,
	Antiguedad           varchar(30)  NOT NULL ,
	Nombre               varchar(60)  NOT NULL ,
	IdCliente            integer  NOT NULL 
)
go




ALTER TABLE dimCliente
	ADD CONSTRAINT XPKdimCliente PRIMARY KEY  CLUSTERED (keyCliente ASC)
go



CREATE TABLE dimOferta
( 
	keyOferta            integer IDENTITY ( 1,1 ) ,
	TipoOferta           varchar(30)  NOT NULL ,
	Descripcion          varchar(30)  NOT NULL ,
	IdOferta             integer  NOT NULL 
)
go



ALTER TABLE dimOferta
	ADD CONSTRAINT XPKdimOferta PRIMARY KEY  CLUSTERED (keyOferta ASC)
go



CREATE TABLE dimPersonal
( 
	keyPersonal          integer IDENTITY ( 1,1 ) ,
	Puesto               varchar(30)  NOT NULL ,
	Antiguedad           varchar(30)  NOT NULL ,
	Sexo                 varchar(30)  NOT NULL ,
	Nombre               varchar(100)  NOT NULL ,
	Area                 varchar(30)  NOT NULL ,
	IdPersonal           integer  NOT NULL 
)
go



ALTER TABLE dimPersonal
	ADD CONSTRAINT XPKdimPersonal PRIMARY KEY  CLUSTERED (keyPersonal ASC)
go



CREATE TABLE dimPlan
( 
	keyPlan              integer IDENTITY ( 1,1 ) ,
	TipoPlan             varchar(30)  NOT NULL ,
	NivelLlamNac         varchar(30)  NOT NULL ,
	NivelLlamInt         varchar(30)  NOT NULL ,
	NivelMensajes        varchar(30)  NOT NULL ,
	Descripcion          varchar(30)  NOT NULL ,
	IdPlan               integer  NOT NULL 
)
go



ALTER TABLE dimPlan
	ADD CONSTRAINT XPKdimPlan PRIMARY KEY  CLUSTERED (keyPlan ASC)
go



CREATE TABLE dimTiempo
( 
	keyTiempo            integer IDENTITY ( 1,1 ) ,
	Mensual              varchar(20)  NOT NULL ,
	Trimestral           char(2)  NOT NULL ,
	Anual                char(4)  NOT NULL ,
	IdFecha              datetime  NOT NULL 
)
go



ALTER TABLE dimTiempo
	ADD CONSTRAINT XPKdimTiempo PRIMARY KEY  CLUSTERED (keyTiempo ASC)
go



CREATE TABLE dimTipoReclamo
( 
	keyTipoReclamo       integer IDENTITY ( 1,1 ) ,
	TipoReclamo          varchar(30)  NOT NULL ,
	IdTipoReclamo        integer  NOT NULL 
)
go



ALTER TABLE dimTipoReclamo
	ADD CONSTRAINT XPKdiTipoReclamo PRIMARY KEY  CLUSTERED (keyTipoReclamo ASC)
go



CREATE TABLE dimUbigeo
( 
	keyUbigeo            integer IDENTITY ( 1,1 ) ,
	Distrito             varchar(50)  NOT NULL ,
	Provincia            varchar(50)  NOT NULL ,
	Departamento         varchar(50)  NOT NULL ,
	IdDistrito           integer  NOT NULL 
)
go



ALTER TABLE dimUbigeo
	ADD CONSTRAINT XPKdimUbigeo PRIMARY KEY  CLUSTERED (keyUbigeo ASC)
go



CREATE TABLE hechoMetaOferta
( 
	MetaOferta           money  NOT NULL ,
	keyOferta            integer  NOT NULL ,
	keyTiempo            integer  NOT NULL 
)
go



ALTER TABLE hechoMetaOferta
	ADD CONSTRAINT XPKhechoMetaOferta PRIMARY KEY  CLUSTERED (keyOferta ASC,keyTiempo ASC)
go



CREATE TABLE hechoPlanes
( 
	PlanesNuevos        integer  NOT NULL ,
	keyCliente           integer  NOT NULL ,
	keyPlan              integer  NOT NULL ,
	keyTiempo            integer  NOT NULL ,
	RecibosEmitidos      integer  NOT NULL ,
	RecibosPagados       integer  NOT NULL ,
	PlanesDeBaja         integer  NOT NULL 
)
go



ALTER TABLE hechoPlanes
	ADD CONSTRAINT XPKhechoPlanes PRIMARY KEY  CLUSTERED (keyCliente ASC,keyPlan ASC,keyTiempo ASC)
go



CREATE TABLE hechoRecargas
( 
	MontoRecargaOferta   money  NOT NULL ,
	keyTiempo            integer  NOT NULL ,
	keyCliente           integer  NOT NULL ,
	keyOferta            integer  NOT NULL 
)
go



ALTER TABLE hechoRecargas
	ADD CONSTRAINT XPKhechoRecargass PRIMARY KEY  CLUSTERED (keyTiempo ASC,keyCliente ASC,keyOferta ASC)
go



CREATE TABLE hechoReclamos
( 
	ReclamosResueltos    integer  NOT NULL ,
	keyPersonal          integer  NOT NULL ,
	keyCliente           integer  NOT NULL ,
	keyPlan              integer  NOT NULL ,
	keyUbigeo            integer  NOT NULL ,
	keyTipoReclamo       integer  NOT NULL ,
	keyTiempo            integer  NOT NULL ,
	ReclamosRealizados   integer  NOT NULL 
)
go



ALTER TABLE hechoReclamos
	ADD CONSTRAINT XPKhechoReclamos PRIMARY KEY  CLUSTERED (keyPersonal ASC,keyCliente ASC,keyPlan ASC,keyUbigeo ASC,keyTipoReclamo ASC,keyTiempo ASC)
go




ALTER TABLE hechoMetaOferta
	ADD CONSTRAINT R_36 FOREIGN KEY (keyOferta) REFERENCES dimOferta(keyOferta)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE hechoMetaOferta
	ADD CONSTRAINT R_46 FOREIGN KEY (keyTiempo) REFERENCES dimTiempo(keyTiempo)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE hechoPlanes
	ADD CONSTRAINT R_65 FOREIGN KEY (keyCliente) REFERENCES dimCliente(keyCliente)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE hechoPlanes
	ADD CONSTRAINT R_66 FOREIGN KEY (keyPlan) REFERENCES dimPlan(keyPlan)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE hechoPlanes
	ADD CONSTRAINT R_67 FOREIGN KEY (keyTiempo) REFERENCES dimTiempo(keyTiempo)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE hechoRecargas
	ADD CONSTRAINT R_33 FOREIGN KEY (keyTiempo) REFERENCES dimTiempo(keyTiempo)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE hechoRecargas
	ADD CONSTRAINT R_34 FOREIGN KEY (keyCliente) REFERENCES dimCliente(keyCliente)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE hechoRecargas
	ADD CONSTRAINT R_47 FOREIGN KEY (keyOferta) REFERENCES dimOferta(keyOferta)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE hechoReclamos
	ADD CONSTRAINT R_27 FOREIGN KEY (keyPersonal) REFERENCES dimPersonal(keyPersonal)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE hechoReclamos
	ADD CONSTRAINT R_28 FOREIGN KEY (keyCliente) REFERENCES dimCliente(keyCliente)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE hechoReclamos
	ADD CONSTRAINT R_29 FOREIGN KEY (keyPlan) REFERENCES dimPlan(keyPlan)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE hechoReclamos
	ADD CONSTRAINT R_30 FOREIGN KEY (keyUbigeo) REFERENCES dimUbigeo(keyUbigeo)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE hechoReclamos
	ADD CONSTRAINT R_31 FOREIGN KEY (keyTipoReclamo) REFERENCES dimTipoReclamo(keyTipoReclamo)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE hechoReclamos
	ADD CONSTRAINT R_32 FOREIGN KEY (keyTiempo) REFERENCES dimTiempo(keyTiempo)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


