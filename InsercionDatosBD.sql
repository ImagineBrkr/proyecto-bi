insert into Departamento(Nombre, Codigo) values
('Amazonas', '41'),
('Ancash', '43'),
('Apurimac', '83'),
('Arequipa', '54'),
('Ayacucho', '66'),
('Cajamarca', '76'),
('Callao', '1'),
('Cusco', '84'),
('Huancavelica', '67'),
('Huanuco', '62'),
('Ica', '56'),
('Junin', '64'),
('La Libertad', '44'),
('Lambayeque', '74'),
('Lima', '1'),
('Loreto', '65'),
('Madre de Dios', '82'),
('Moquegua', '53'),
('Pasco', '63'),
('Piura', '73'),
('Puno', '51'),
('San Martin', '42'),
('Tacna', '52'),
('Tumbes', '72'),
('Ucayali', '61');
go

insert into Provincia(Nombre, IdDepartamento) values
('Chachapoyas', 1),
('Bagua', 1),
('Huaraz', 2),
('Bolognesi', 2),
('Abancay', 3),
('Grau', 3),
('Arequipa', 4),
('Castilla', 4),
('Huamanga', 5),
('Sucre', 5),
('Cajamarca', 6),
('Chota', 6),
('Callao', 7),
('Cusco', 8),
('Urubamba', 8),
('Huancavelica', 9),
('Angaraes', 9),
('Huanuco', 10),
('Huamalies', 10),
('Ica', 11),
('Chincha', 11),
('Nazca', 11),
('Pisco', 11),
('Huancayo', 12),
('Jauja', 12),
('Trujillo', 13),
('Ascope', 13),
('Otuzco', 13),
('Pacasmayo', 13),
('Pataz', 13),
('Viru', 13),
('Chiclayo', 14),
('Lambayeque', 14),
('Lima', 15),
('Barranca', 15),
('Cañete', 15),
('Huaral', 15),
('Maynas', 16),
('Ucayali', 16),
('Tambopata', 17),
('Mariscal Nieto', 18),
('Pasco', 19),
('Piura', 20),
('Talara', 20),
('Puno', 21),
('Melgar', 21),
('Moyobamba', 22),
('Lambas', 22),
('Tacna', 23),
('Tarata', 23),
('Tumbes', 24),
('Coronel Portillo', 25);
go

insert into Distrito(Nombre, IdProvincia) values
('Chachapoyas', 1),
('Bagua', 2),
('Huaraz', 3),
('La Libertad', 3),
('Chiquian', 4),
('Abancay', 5),
('Chuquibambilla', 6),
('Arequipa', 7),
('Mariano Melgar', 7),
('Aplao', 8),
('Ayacucho', 9),
('Querobamba', 10),
('Cajamarca', 11),
('San Juan', 11),
('Chota', 12),
('Callao', 13),
('Bellavista', 13),
('Cusco', 14),
('Urubamba', 15),
('Huancavelica', 16),
('Lircay', 17),
('Huanuco', 18),
('Llata', 19),
('Ica', 20),
('Salas', 20),
('Chincha Alta', 21),
('Chavin', 21),
('Nazca', 22),
('Pisco', 23),
('Huancayo', 24),
('Jauja', 25),
('Trujillo', 26),
('El Porvenir', 26),
('Huanchaco', 26),
('La Esperanza', 26),
('Moche', 26),
('Salaverry', 26),
('Victor Larco Herrera', 26),
('Ascope', 27),
('Chicama', 27),
('Otuzco', 28),
('Mache', 28),
('San Pedro de Lloc', 29),
('Guadalupe', 29),
('Tayabamba', 30),
('Chillia', 30),
('Viru', 31),
('Chao', 31),
('Chiclayo', 32),
('Lambayeque', 33),
('Lima', 34),
('La Victoria', 34),
('Miraflores', 34),
('Barranca', 35),
('Supe', 35),
('San Vicente de Cañete', 36),
('Huaral', 37),
('Iquitos', 38),
('Contamana', 39),
('Tambopata', 40),
('Moquegua', 41),
('Chaupimarca', 42),
('Piura', 43),
('Pariñas', 44),
('Puno', 45),
('Ayaviri', 46),
('Moyobamba', 47),
('Lamas', 48),
('Tacna', 49),
('Sama', 49),
('Tarata', 50),
('Tumbes', 51),
('Calleria', 52);
go

insert into TipoReclamo(Descripcion) values
('Avería'),
('Mantenimiento'),
('Desperfecto'),
('Beneficios incompletos'),
('Otros')
go

insert into DetallesLlamada(TipoDestino, Destino, CostoPrepago) values
('Movil', 'Nacional', 0.39),
('Movil', 'Internacional', 0.49),
('Fijo', 'Nacional', 0.49),
('Fijo', 'Internacional', 0.59);
go

insert into DetallesMensaje(TipoMensaje, Destino, CostoPrepago) values
('SMS', 'Nacional', 0.10),
('SMS', 'Internacional', 0.25),
('MMS', 'Nacional', 0.25),
('MMS', 'Internacional', 0.35);
go

INSERT INTO MedioAtencion(descripcion) values
('Web'),
('Llamada'),
('Atención presencial'),
('Chatbot')
go

INSERT INTO MotivoAtencion(descripcion) values
('Reclamo'),
('Ofrecimiento'),
('Consultas')
go

Insert into Area(descripcion) values
('Atención al cliente'),
('Servicio técnico')
go

Insert into Puesto(descripcion, idArea) values
('Operador', 1),
('Técnico', 2)
go

Insert into MotivoBaja(descripcion) values
('Suspensión'),
('Cancelación'),
('Migración'),
('Nuevo plan')
go

Insert into TipoOferta(TipoOferta) values
('Nro de mensajes'),
('Llamadas nacionales'),
('Llamadas internacionales'),
('Llamadas'),
('Todo en uno')
go

Insert into TipoMedioPago(descripcion) values
('Banco'),
('Web'),
('Bodega'),
('Yape')
go

insert into MedioPago(Nombre, IdTipoMedioPago) values
('BCP', 1),
('BBVA', 1),
('ScotiaBank', 1),
('Plataforma web', 2),
('Bodega 1', 3),
('Bodega 2', 3),
('Cuenta Yape', 4)
go

insert into DetallesPlan(TipoPlan, Descripcion, CostoMensual, NivelLlamInt, NivelLlamNac, NivelMensajes, MinutosLlamInt, MinutosLlamNac, NroMensajes) values
('Prepago', 'Plan prepago', 0, 'Limitado', 'Limitado', 'Limitado', 0, 0, 0),
('Pospago', 'Plan pospago 1', 20, 'Limitado', 'Limitado', 'Limitado', 0, 250, 1000),
('Pospago', 'Plan pospago 2', 30, 'Limitado', 'Limitado', 'Limitado', 100, 400, 1000),
('Pospago', 'Plan pospago 3', 40, 'Limitado', 'Limitado', 'Limitado', 200, 400, 1500),
('Pospago', 'Nacional ilimitado', 50, 'Limitado', 'Ilimitado', 'Limitado', 200, 0, 1500),
('Pospago', 'Internacional ilimitado', 60, 'Ilimitado', 'Ilimitado', 'Limitado', 0, 0, 1500),
('Pospago', 'Todo ilimitado', 70, 'Ilimitado', 'Ilimitado', 'Ilimitado', 0, 0, 0),
('Fijo', 'Plan fijo 1', 20, 'Limitado', 'Limitado', 'Limitado', 0, 250, 0),
('Fijo', 'Plan fijo 2', 30, 'Limitado', 'Limitado', 'Limitado', 100, 300, 0),
('Fijo', 'Plan fijo 3', 40, 'Limitado', 'Limitado', 'Limitado', 200, 400, 0),
('Fijo', 'Fijo Nacional ilimitado', 50, 'Limitado', 'Ilimitado', 'Limitado', 200, 0, 0),
('Fijo', 'Fijo Internacional ilimitado', 60, 'Ilimitado', 'Ilimitado', 'Limitado', 0, 0, 0)
go

drop procedure if exists sp_insertaPlanPrepago
go

create procedure sp_insertaPlanPrepago
@FechaCreacion datetime,
@IdCliente integer,
@Numero varchar(9),
@Estado varchar(13) = 'Activo',
@FechaBaja datetime = null,
@Saldo money = 0,
@FechaVencimiento datetime,
@TipoPlan integer = 1
as
begin
	
	IF (@FechaBaja IS NULL OR (@FechaBaja > @FechaCreacion)) And (@FechaVencimiento > @FechaCreacion)
	BEGIN
	BEGIN TRAN T1
		insert into PlanContratado(FechaCreacion,Numero,Estado,FechaBaja,IdDetallesPlan,IdCliente) values
		(@FechaCreacion, @Numero, @Estado, @FechaBaja, @TipoPlan, @IdCliente)
		insert into Plan_Prepago(IdPlan, Saldo, FechaVencimiento) values
		(@@IDENTITY, @Saldo, @FechaVencimiento)
		COMMIT TRAN T1
	END	
end
go

drop procedure if exists sp_insertaPlanPospago
go

create procedure sp_insertaPlanPospago
@FechaCreacion datetime,
@IdCliente integer,
@Numero varchar(9),
@Estado varchar(13) = 'Activo',
@FechaBaja datetime = null,
@TipoPlan integer
as
begin
	IF (@FechaBaja IS NULL OR (@FechaBaja > @FechaCreacion))
	BEGIN
	BEGIN TRAN T1
		insert into PlanContratado(FechaCreacion,Numero,Estado,FechaBaja,IdDetallesPlan,IdCliente) values
		(@FechaCreacion, @Numero, @Estado, @FechaBaja, @TipoPlan, @IdCliente)
		insert into Plan_Pospago(IdPlan, MinutosLlamNac, MinutosLlamInt, NroMensajes, CostoMensual)
		select @@IDENTITY, MinutosLlamNac, MinutosLlamInt, NroMensajes, CostoMensual
		from DetallesPlan where IdDetallesPlan = @TipoPlan
		COMMIT TRAN T1
	END	
end
go

drop procedure if exists sp_insertaPlanFijo
go

create procedure sp_insertaPlanFijo
@FechaCreacion datetime,
@IdCliente integer,
@Numero varchar(9),
@Estado varchar(13) = 'Activo',
@FechaBaja datetime = null,
@Direccion varchar(50),
@IdDistrito integer,
@TipoPlan integer 
as
begin
	IF (@FechaBaja IS NULL OR (@FechaBaja > @FechaCreacion))
	BEGIN
	BEGIN TRAN T1
		insert into PlanContratado(FechaCreacion,Numero,Estado,FechaBaja,IdDetallesPlan,IdCliente) values
		(@FechaCreacion, @Numero, @Estado, @FechaBaja, @TipoPlan, @IdCliente)
		insert into Plan_Fijo(IdPlan, MinutosLlamNac, MinutosLlamInt, CostoMensual, IdDistrito, Direccion)
		select @@IDENTITY, MinutosLlamNac, MinutosLlamInt, CostoMensual, @IdDistrito, @Direccion
		from DetallesPlan where IdDetallesPlan = @TipoPlan
		COMMIT TRAN T1
	END
end
go

drop procedure if exists sp_insertaRecarga
go
select count(IdRecibo) from Recibo
create procedure sp_insertaRecarga
@Fecha datetime,
@IdPlan integer,
@IdOferta integer = NULL,
@IdMedioPago integer,
@Saldo money
as
begin	
	if (select FechaCreacion from PlanContratado where IdPlan = @IdPlan) <= @Fecha AND 
		((select FechaBaja from PlanContratado where IdPlan = @IdPlan) IS NULL OR
		(select FechaBaja from PlanContratado where IdPlan = @IdPlan) >= @Fecha) AND
		(@IdOferta is null or 
		((select FechaInicio from Oferta where IdOferta = @IdOferta) <= @Fecha) AND
		(select FechaFin from Oferta where IdOferta = @IdOferta) >= @Fecha) AND
		(select d.TipoPlan from PlanContratado p inner join DetallesPlan d on p.IdDetallesPlan = d.IdDetallesPlan where IdPlan = @IdPlan) = 'Prepago'
		begin
		insert into Recarga(IdPlan, Saldo, FechaRecarga, IdOferta, IdMedioPago) values
		(@IdPlan, @Saldo, @Fecha, @IdOferta, @IdMedioPago)
		end
end
go

drop procedure if exists sp_insertaLlamada
go

create procedure sp_insertaLlamada
@Fecha datetime,
@IdPlan integer,
@TipoCobro varchar(20) = 'No gratuito',
@Duracion integer,
@IdDetalle integer,
@Numero varchar(20)
as
begin	
	if (select FechaCreacion from PlanContratado where IdPlan = @IdPlan) <= @Fecha AND 
		((select FechaBaja from PlanContratado where IdPlan = @IdPlan) IS NULL OR
		(select FechaBaja from PlanContratado where IdPlan = @IdPlan) >= @Fecha)
		begin
		insert into	Llamada(Duracion, Fecha, Numero, IdPlan, CostoPrepago, IdDetalle, TipoCobro) values
		(@Duracion, @Fecha, @Numero, @IdPlan, (select CostoPrepago from DetallesLlamada where IdDetalle = @IdDetalle), @IdDetalle, @TipoCobro)
		end
end
go

drop procedure if exists sp_insertaMensaje
go

create procedure sp_insertaMensaje
@Fecha datetime,
@IdPlan integer,
@TipoCobro varchar(20) = 'No gratuito',
@IdDetalle integer,
@Numero varchar(20)
as
begin	
	if (select FechaCreacion from PlanContratado where IdPlan = @IdPlan) <= @Fecha AND 
		((select FechaBaja from PlanContratado where IdPlan = @IdPlan) IS NULL OR
		(select FechaBaja from PlanContratado where IdPlan = @IdPlan) >= @Fecha)
		begin
		insert into	Mensaje(Fecha, Numero, IdPlan, CostoPrepago, IdDetalle, TipoCobro) values
		(@Fecha, @Numero, @IdPlan, (select CostoPrepago from DetallesMensaje where IdDetalle = @IdDetalle), @IdDetalle, @TipoCobro)
		end
end
go

drop procedure if exists sp_insertaReclamo
go

create procedure sp_insertaReclamo
@FechaReclamo datetime,
@Detalles varchar(1000),
@IdPlan integer,
@IdTipo integer,
@IdAtencion integer = NUll
as
begin	
	if (select FechaCreacion from PlanContratado where IdPlan = @IdPlan) <= @FechaReclamo AND 
		((select FechaBaja from PlanContratado where IdPlan = @IdPlan) IS NULL OR
		(select FechaBaja from PlanContratado where IdPlan = @IdPlan) >= @FechaReclamo) AND
		(select d.TipoPlan from PlanContratado p inner join DetallesPlan d on p.IdDetallesPlan = d.IdDetallesPlan where IdPlan = @IdPlan) = 'Fijo'
		begin
		BEGIN TRAN T1
		if @IdAtencion is null
		begin
			insert into Atencion(IdMotivoAtencion, IdCliente, Fecha, IdMedioAtencion, IdPersonal) values
			(1, (select IdCliente from PlanContratado where IdPlan = @IdPlan), @FechaReclamo, 1, 3002)
			set @IdAtencion = @@IDENTITY
		end
		insert into Reclamo(IdPlan, DetallesReclamo, FechaReclamo, IdTipoReclamo, IdAtencion) values
		(@IdPlan, @Detalles, @FechaReclamo, @IdTipo, @IdAtencion)
		COMMIT TRAN T1
		end
end
go

drop procedure if exists sp_ResuelveReclamo
go

create procedure sp_ResuelveReclamo
@IdReclamo integer,
@FechaAtencion datetime,
@Observaciones varchar(1000),
@IdPersonal integer
as
begin
	if (select FechaContratacion from Personal where IdPersonal = @IdPersonal) <= @FechaAtencion AND 
		((select FechaFinContratacion from Personal where IdPersonal = @IdPersonal) IS NULL OR
		(select FechaFinContratacion from Personal where IdPersonal = @IdPersonal) >= @FechaAtencion) AND
		(select Estado from Reclamo where IdReclamo = @IdReclamo) != 'Resuelto' AND
		(select p.Descripcion from Personal pe inner join Puesto p on p.IdPuesto = pe.IdPuesto where IdPersonal = @IdPersonal) = 'Técnico'
		begin
			update Reclamo set FechaAtencion = @FechaAtencion, Observaciones = @Observaciones, IdPersonal = @IdPersonal, Estado = 'Resuelto' where IdReclamo = @IdReclamo
		end

end
go

drop procedure if exists sp_insertaOferta
go
select * from TipoOferta
create procedure sp_insertaOferta
@FechaInicio datetime,
@Descripcion varchar(30),
@MontoMinimo money,
@Meta money,
@IdTipoOferta integer
as
begin	
	BEGIN TRAN T1
		insert into Oferta(FechaInicio, Descripcion, MontoMinimo, Meta, IdTipoOferta, FechaFin) values
		(@FechaInicio, @Descripcion, @MontoMinimo, @Meta, @IdTipoOferta, EOMONTH(@FechaInicio))
	COMMIT TRAN T1
end
go

drop procedure if exists sp_generarRecibos
go

create procedure sp_generarRecibos
as
begin
	declare @IdPlan integer, @FechaCreacion datetime, @FechaBaja datetime, @FechaEmision datetime
	declare cursor_ID CURSOR for
	select IdPlan, FechaCreacion, FechaBaja from PlanContratado p
	inner join DetallesPlan d on d.IdDetallesPlan = p.IdDetallesPlan
	where D.TipoPlan ='Fijo' or d.TipoPlan = 'Pospago'

	open cursor_ID

	FETCH NEXT from cursor_ID into @IdPlan, @FechaCreacion, @FechaBaja
	while @@FETCH_STATUS=0
		begin
		set @FechaEmision = DATEADD(month, 1, @FechaCreacion)
		While @FechaEmision < @FechaBaja or @FechaEmision < getdate()
			begin
				insert into Recibo(Monto, FechaEmision, FechaVencimiento, IdPlan) values
				((select CostoMensual from PlanContratado p
			inner join DetallesPlan d on d.IdDetallesPlan = p.IdDetallesPlan where p.IdPlan = @IdPlan), @FechaEmision, DATEADD(month, 1, @FechaEmision), @IdPlan)
				set @FechaEmision = DATEADD(month, 1, @FechaEmision)
			end
		FETCH NEXT from cursor_ID into @IdPlan, @FechaCreacion, @FechaBaja
		end
	close cursor_ID
	deallocate cursor_ID
end
go

drop procedure if exists sp_BajaPlan
go

create procedure sp_BajaPlan
@FechaBaja datetime,
@IdMotivoBaja integer,
@IdPlan integer
as
begin
	if (select FechaCreacion from PlanContratado where IdPlan = @IdPlan) < @FechaBaja and (select Estado from PlanContratado where IdPlan = @IdPlan) = 'Activo'
	begin
		update PlanContratado set FechaBaja = @FechaBaja, IdMotivoBaja = @IdMotivoBaja, Estado = 'Inactivo'
		where IdPlan = @IdPlan 
	end
end
go

drop procedure if exists sp_PagarRecibo
go

create procedure sp_PagarRecibo
@FechaPago datetime,
@IdMedioPago integer,
@IdRecibo integer
as
begin
	if (select FechaEmision from Recibo where IdRecibo = @IdRecibo) < @FechaPago AND 
		(select Estado from Recibo where IdRecibo = @IdRecibo) != 'Pagado'
	begin
		update Recibo set FechaPago = @FechaPago, IdMedioPago = @IdMedioPago, Estado = 'Pagado'
		where IdRecibo = @IdRecibo 
	end
end
go

drop procedure if exists sp_PagarReciboRapido
go

create procedure sp_PagarReciboRapido
@FechaPago integer,
@IdMedioPago integer,
@IdRecibo integer
as
begin
	if (select Estado from Recibo where IdRecibo = @IdRecibo) != 'Pagado'
	begin
		update Recibo set FechaPago = dateadd(day,@FechaPago, FechaEmision), IdMedioPago = @IdMedioPago, Estado = 'Pagado'
		where IdRecibo = @IdRecibo 
	end
end
go

create index idx_recibo on Recibo(IdRecibo,FechaEmision,Estado)

drop procedure if exists sp_VencerRecibos
go

create procedure sp_VencerRecibos
as
begin
	begin
		update Recibo set Estado = 'Vencido'
		where FechaPago = NULL AND FechaVencimiento < getdate() 
	end
end
go




