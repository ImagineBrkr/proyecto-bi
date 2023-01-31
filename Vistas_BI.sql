create view v_DimCliente as
select ROW_NUMBER() OVER (ORDER BY IdCliente) AS keyCliente, C.TipoCliente as TipoCliente,
			 C.Sexo	as Sexo,
			 C.Nombre as Nombre,
			 c.IdCliente as IdCliente,
			 case when datediff(year, (select TOP 1 FechaCreacion from OLTPTelefonia.dbo.PlanContratado where IdCliente = c.IdCliente order by FechaCreacion asc), getdate()) < 3 then 'Nuevo'
			 when datediff(year, (select TOP 1 FechaCreacion from OLTPTelefonia.dbo.PlanContratado where IdCliente = c.IdCliente order by FechaCreacion asc), getdate()) < 5 then 'Medio'
			 when datediff(year, (select TOP 1 FechaCreacion from OLTPTelefonia.dbo.PlanContratado where IdCliente = c.IdCliente order by FechaCreacion asc), getdate()) < 7 then 'Antiguo'
			 else 'Muy antiguo' end as Antiguedad
	 from OLTPTelefonia.dbo.Cliente C
go


create view v_DimTipoReclamo as
select ROW_NUMBER() OVER (ORDER BY IdTipoReclamo) AS keyTipoReclamo,
		 descripcion as TipoReclamo,
			IdTipoReclamo as IdTipoReclamo
		from TipoReclamo
go


create view v_DimUbigeo as
select	ROW_NUMBER() OVER (ORDER BY IdDistrito) AS keyubigeo,
		D.Nombre as Distrito,
				P.Nombre as Provincia,
				DO.Nombre as Departamento,
				D.IdDistrito as IdDistrito
			from OLTPTelefonia.dbo.Distrito D
			inner join OLTPTelefonia.dbo.Provincia P on D.IdProvincia=P.IdProvincia
			inner join OLTPTelefonia.dbo.Departamento DO on P.IdDepartamento=DO.IdDepartamento
go

create view v_DimPlan as
select ROW_NUMBER() OVER (ORDER BY IdDetallesPlan) AS keyPlan,
			 PT.NivelLlamNac			as NivelLlamNac,
			 PT.TipoPlan		as TipoPlan,
			 PT.NivelLlamInt		as NivelLlamInt,
			 PT.NivelMensajes as NivelMensajes,
			 PT.Descripcion as Descripcion,
			 PT.IdDetallesPlan as IdPlan		 
	 from OLTPTelefonia.dbo.DetallesPlan PT
go

create view v_DimPersonal as
select ROW_NUMBER() OVER (ORDER BY IdPersonal) AS keyPersonal, a.descripcion	as Area,
			 Pu.descripcion		as Puesto,
			 P.Nombres + ' ' + p.Apellidos as Nombre,
			 p.SEXO AS Sexo,
			 P.IdPersonal as IdPersonal,
			 case when datediff(year, (select FechaContratacion from OLTPTelefonia.dbo.Personal where IdPersonal = p.IdPersonal), getdate()) < 3 then 'Nuevo'
			 when datediff(year, (select FechaContratacion from OLTPTelefonia.dbo.Personal where IdPersonal = p.IdPersonal), getdate()) < 5 then 'Medio'
			 when datediff(year, (select FechaContratacion from OLTPTelefonia.dbo.Personal where IdPersonal = p.IdPersonal), getdate()) < 7 then 'Antiguo'
			 else 'Muy antiguo' end as Antiguedad
	 from OLTPTelefonia.dbo.Personal P
	 inner join OLTPTelefonia.dbo.Puesto pu on pu.IdPuesto = P.IdPuesto
	 inner join OLTPTelefonia.dbo.Area a on a.IdArea = pu.IdArea
go

create view v_DimOferta as
select ROW_NUMBER() OVER (ORDER BY IdOferta) AS keyOferta, TipoOferta as TipoOferta,
			Descripcion as Descripcion,
			IdOferta as IdOferta
			from OLTPTelefonia.dbo.Oferta o inner join OLTPTelefonia.dbo.TipoOferta t on t.IdTipoOferta = o.IdTipoOferta
go

create view v_DimTiempoAux as

select 	distinct FechaReclamo as IdFecha,
		datename(mm,R.FechaReclamo)	as Mensual,
		 CONCAT('Q', datepart(quarter,R.FechaReclamo))		as	Trimestral,
			year(R.FechaReclamo)	as Anual
				from OLTPTelefonia.dbo.Reclamo R
	UNION
		select distinct FechaInicio as IdFecha,
		datename(mm,FechaInicio) as Mensual,
		CONCAT('Q', datepart(quarter,FechaInicio)) as Trimestral,
		year(FechaInicio) as Anual
	from OLTPTelefonia.dbo.Oferta 
	UNION
		select distinct FechaEmision as IdFecha,
		datename(mm,FechaEmision) as Mensual,
		CONCAT('Q', datepart(quarter,FechaEmision)) as Trimestral,
		year(FechaEmision) as Anual
	from OLTPTelefonia.dbo.Recibo 
		UNION
		select distinct FechaRecarga as IdFecha,
		datename(mm,FechaRecarga) as Mensual,
		CONCAT('Q', datepart(quarter,FechaRecarga)) as Trimestral,
		year(FechaRecarga) as Anual
	from OLTPTelefonia.dbo.Recarga
	UNION
		select distinct FechaCreacion as IdFecha,
		datename(mm,FechaCreacion) as Mensual,
		CONCAT('Q', datepart(quarter,FechaCreacion)) as Trimestral,
		year(FechaCreacion) as Anual
	from OLTPTelefonia.dbo.PlanContratado
		UNION
		select distinct FechaBaja as IdFecha,
		datename(mm,FechaBaja) as Mensual,
		CONCAT('Q', datepart(quarter,FechaBaja)) as Trimestral,
		year(FechaBaja) as Anual
	from OLTPTelefonia.dbo.PlanContratado where FechaBaja is not null
go

create view v_DimTiempo as
select *, ROW_NUMBER() OVER (ORDER BY IdFecha) AS keyTiempo from v_DimTiempoAux
go

create view v_HechoMetaOferta as
select	IdOferta as idoferta,
		FechaInicio as idfecha,
		metaoferta = sum(o.Meta)
			from OLTPTelefonia.dbo.Oferta O
			group by FechaInicio,IdOferta
go

select sum(meta) from oferta

select sum(metaoferta) from v_hechometaoferta
go

create view v_HechoRecargas as
select	R.FechaRecarga as idfecha,
				R.idoferta as idoferta,
				PC.idcliente as idcliente,
				montorecargaoferta = sum(r.Saldo)
			from OLTPTelefonia.dbo.Recarga r
			inner join OLTPTelefonia.dbo.PlanContratado PC on r.IdPlan = PC.IdPlan
			where R.idoferta is not null
			group by FechaRecarga,idoferta, idcliente
go

select sum(montorecargaoferta) from v_HechoRecargas

select sum(saldo) from recarga where idoferta is not null

create view v_HechoReclamos as
select iddistrito as iddistrito,
				fechareclamo as idfecha,
				idtiporeclamo as idtiporeclamo,
				iddetallesplan as idplan,
				R.idpersonal as idpersonal, 
				pc.idcliente as idcliente,
				ReclamosResueltos = count(case when R.Estado = 'Resuelto' then 1 else null end),
				ReclamosRealizados = 0
			from OLTPTelefonia.dbo.Reclamo R
			inner join OLTPTelefonia.dbo.Plan_Fijo PF on R.IdPlan=PF.IdPlan
			inner join OLTPTelefonia.dbo.PlanContratado PC on PF.IdPlan = PC.IdPlan
			where R.estado= 'Resuelto'
			group by iddistrito,fechareclamo,idtiporeclamo,iddetallesplan, R.idpersonal, pc.idcliente
			union
		select iddistrito as iddistrito,
				fechareclamo as idfecha,
				idtiporeclamo as idtiporeclamo,
				iddetallesplan as idplan,
				A.idpersonal as idpersonal, 
				pc.idcliente as idcliente,
				ReclamosResueltos = 0,
				ReclamosRealizados = count(R.IdReclamo)
			from OLTPTelefonia.dbo.Reclamo R
			inner join OLTPTelefonia.dbo.Atencion A on R.IdAtencion = A.IdAtencion
			inner join OLTPTelefonia.dbo.Plan_Fijo PF on R.IdPlan=PF.IdPlan
			inner join OLTPTelefonia.dbo.PlanContratado PC on PF.IdPlan = PC.IdPlan
			group by iddistrito,fechareclamo,idtiporeclamo,iddetallesplan, A.idpersonal, pc.idcliente
go

select * from v_HechoReclamos

select sum(reclamosresueltos), sum(reclamosrealizados) from v_HechoReclamos
select count(IdReclamo) from Reclamo where estado = 'Resuelto'

CREATE view v_HechoPlanAux as
select pc.idplan as id,	pc.idcliente as idcliente,
				idfecha = PC.FechaCreacion,
				iddetallesplan as idplan,				
				PlanesNuevos = count(distinct case when PC.FechaCreacion = PC.FechaCreacion then PC.IdPlan else null end),
				PlanesDeBaja = count(distinct case when PC.Estado = 'Inactivo' and PC.FechaBaja = PC.FechaCreacion then PC.IdPlan else null end),
				RecibosEmitidos = count(distinct case when R.FechaEmision = PC.FechaCreacion then R.IdRecibo else null end),
				RecibosPagados = count(distinct case when R.Estado = 'Pagado' and R.FechaEmision = PC.FechaCreacion then R.IdRecibo else null end)
			from OLTPTelefonia.dbo.PlanContratado PC
			left join OLTPTelefonia.dbo.Recibo R on r.IdPlan = PC.IdPlan
			group by pc.idcliente,iddetallesplan, PC.FechaCreacion, pc.idplan
			union
select pc.idplan as id,	pc.idcliente as idcliente,
				idfecha = PC.FechaBaja,
				iddetallesplan as idplan,				
				PlanesNuevos = count(distinct case when PC.FechaCreacion = PC.FechaBaja then PC.IdPlan else null end),
				PlanesDeBaja = count(distinct case when PC.Estado = 'Inactivo' and PC.FechaBaja = PC.FechaBaja then PC.IdPlan else null end),
				RecibosEmitidos = count(distinct case when R.FechaEmision = PC.FechaBaja then R.IdRecibo else null end),
				RecibosPagados = count(distinct case when R.Estado = 'Pagado' and R.FechaEmision = PC.FechaBaja then R.IdRecibo else null end)
			from OLTPTelefonia.dbo.PlanContratado PC
			left join OLTPTelefonia.dbo.Recibo R on r.IdPlan = PC.IdPlan
			WHERE Pc.FechaBaja is not null
			group by pc.idcliente,iddetallesplan, PC.FechaBaja, pc.idplan
			union
select pc.idplan as id,	pc.idcliente as idcliente,
				idfecha = R.FechaEmision,
				iddetallesplan as idplan,				
				PlanesNuevos = count(distinct case when PC.FechaCreacion = R.FechaEmision then PC.IdPlan else null end),
				PlanesDeBaja = count(distinct case when PC.Estado = 'Inactivo' and PC.FechaBaja = R.FechaEmision then PC.IdPlan else null end),
				RecibosEmitidos = count(distinct case when R.FechaEmision = R.FechaEmision then R.IdRecibo else null end),
				RecibosPagados = count(distinct case when R.Estado = 'Pagado' and R.FechaEmision = R.FechaEmision then R.IdRecibo else null end)
			from OLTPTelefonia.dbo.PlanContratado PC
			left join OLTPTelefonia.dbo.Recibo R on r.IdPlan = PC.IdPlan
			where r.FechaEmision is not null
			group by pc.idcliente,iddetallesplan, R.FechaEmision, pc.idplan
go

alter view v_HechoPlan as
select idcliente, 
	idfecha, 
	idplan, 
	sum(planesnuevos) as planesnuevos, 
	sum(planesdebaja) as planesdebaja, 
	sum(recibosemitidos) as recibosemitidos,
	sum(recibospagados) as recibospagados
	from v_HechoPlanAux
	group by  idcliente,idplan, idfecha
go


select SUM(planesNuevos), sum(planesdebaja), sum(recibosemitidos), sum(recibospagados) from v_HechoPlan
select count(IdPlan) from OLTPTelefonia.dbo.PlanContratado where estado = 'Inactivo'
select count(IdRecibo) from OLTPTelefonia.dbo.Recibo where estado = 'Pagado'

