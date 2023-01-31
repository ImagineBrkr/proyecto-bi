use OLAPTelefonia
go

--Poblamiento para dimCliente
MERGE OLAPTelefonia.dbo.dimCliente as dim
using
	( select C.TipoCliente				as TipoCliente,
			 C.Sexo		as Sexo,
			 C.Nombre as Nombre,
			 c.IdCliente as IdCliente,
			 case when datediff(year, (select TOP 1 FechaCreacion from OLTPTelefonia.dbo.PlanContratado where IdCliente = c.IdCliente order by FechaCreacion asc), getdate()) < 3 then 'Nuevo'
			 when datediff(year, (select TOP 1 FechaCreacion from OLTPTelefonia.dbo.PlanContratado where IdCliente = c.IdCliente order by FechaCreacion asc), getdate()) < 5 then 'Medio'
			 when datediff(year, (select TOP 1 FechaCreacion from OLTPTelefonia.dbo.PlanContratado where IdCliente = c.IdCliente order by FechaCreacion asc), getdate()) < 7 then 'Antiguo'
			 else 'Muy antiguo' end as Antiguedad
	 from OLTPTelefonia.dbo.Cliente C
	) as oltp
	on oltp.IdCliente =dim.IdCliente
	when not matched then 
	insert(TipoCliente, Sexo, Nombre, IdCliente, Antiguedad)
	values(TipoCliente, Sexo, Nombre, IdCliente, Antiguedad);
go

--Poblamiento de dimTipoReclamo
MERGE OLAPTelefonia.dbo.dimTipoReclamo as dim
using
	( select descripcion as TipoReclamo,
				IdTipoReclamo as IdTipoReclamo
			from OLTPTelefonia.dbo.TipoReclamo)
		as oltp
	on oltp.IdTipoReclamo=dim.IdTipoReclamo
	when not matched then
	insert(TipoReclamo,IdTipoReclamo) 
	values(TipoReclamo,IdTipoReclamo);
go

--Poblamiento de dimUbigeo
MERGE OLAPTelefonia.dbo.dimUbigeo	as dim
using
	( select	D.Nombre as Distrito,
				P.Nombre as Provincia,
				DO.Nombre as Departamento,
				D.IdDistrito as IdDistrito
			from OLTPTelefonia.dbo.Distrito D
			inner join OLTPTelefonia.dbo.Provincia P on D.IdProvincia=P.IdProvincia
			inner join OLTPTelefonia.dbo.Departamento DO on P.IdDepartamento=DO.IdDepartamento)
		as oltp
		on oltp.IdDistrito=dim.IdDistrito
		when not matched then
		insert(Distrito,Provincia,Departamento, IdDistrito)
		values(Distrito,Provincia,Departamento, IdDistrito);
go

--poblamiento para dimPlan
MERGE OLAPTelefonia.dbo.dimPlan	as dim
using
	( select 
			 PT.NivelLlamNac			as NivelLlamNac,
			 PT.TipoPlan		as TipoPlan,
			 PT.NivelLlamInt		as NivelLlamInt,
			 PT.NivelMensajes as NivelMensajes,
			 PT.Descripcion as Descripcion,
			 PT.IdDetallesPlan as IdPlan		 
	 from OLTPTelefonia.dbo.DetallesPlan PT
	) as oltp
	on oltp.IdPlan=dim.idPlan
	when not matched then 
	insert(NivelLlamNac,TipoPlan,NivelLlamInt, NivelMensajes, Descripcion, IdPlan)
	values(NivelLlamNac,TipoPlan,NivelLlamInt, NivelMensajes, Descripcion, IdPlan);
go

--poblamiento para dimPersonal
MERGE OLAPTelefonia.dbo.dimPersonal as dim
using
	( select a.descripcion	as Area,
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
	) as oltp
	on oltp.IdPersonal =dim.IdPersonal
	when not matched then 
	insert(Area, Puesto, Nombre, Sexo, Antiguedad, IdPersonal)
	values(Area, Puesto, Nombre, Sexo, Antiguedad, IdPersonal);
go

--poblamiento para dimOferta
MERGE OLAPTelefonia.dbo.dimOferta as dim
using
	( select TipoOferta as TipoOferta,
			Descripcion as Descripcion,
			IdOferta as IdOferta
			from OLTPTelefonia.dbo.Oferta o inner join OLTPTelefonia.dbo.TipoOferta t on t.IdTipoOferta = o.IdTipoOferta)
		as oltp
	on oltp.IdOferta=dim.IdOferta
	when not matched then
	insert(TipoOferta,Descripcion, IdOferta) 
	values(TipoOferta,Descripcion, IdOferta);
go

--poblamiento para dimTiempo
MERGE OLAPTelefonia.dbo.dimTiempo as dim
using
 (select distinct FechaReclamo as IdFecha,
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
) as oltp
on oltp.IdFecha=dim.IdFecha
when not matched then
insert (Mensual,Trimestral,Anual,IdFecha)
values (Mensual,Trimestral,Anual,IdFecha);
go


--Poblamiento de hechoReclamo
delete from OLAPTelefonia.dbo.hechoReclamos
insert into OLAPTelefonia.dbo.hechoReclamos(keyubigeo,keytiempo,keytiporeclamo,keyplan,keypersonal,keycliente,ReclamosResueltos,ReclamosRealizados)
select keyUbigeo = du.keyUbigeo,
				keyTiempo = dt.keyTiempo,
				keyTipoReclamo = dr.keyTipoReclamo,
				keyPlan = dp.keyPlan,
				keyPersonal = dpe.keyPersonal,
				keyCliente = dc.keyCliente,
				ReclamosResueltos = count(case when R.Estado = 'Resuelto' then 1 else null end),
				ReclamosRealizados = 0
			from OLTPTelefonia.dbo.Reclamo R
			inner join OLTPTelefonia.dbo.Plan_Fijo PF on R.IdPlan=PF.IdPlan
			inner join OLTPTelefonia.dbo.PlanContratado PC on PF.IdPlan = PC.IdPlan
			inner join OLAPTelefonia.dbo.dimUbigeo du on du.IdDistrito = PF.IdDistrito
			inner join OLAPTelefonia.dbo.dimTiempo dt on dt.IdFecha = R.FechaReclamo
			inner join OLAPTelefonia.dbo.dimTipoReclamo dr on dr.IdTipoReclamo = R.IdTipoReclamo
			inner join OLAPTelefonia.dbo.dimPlan dp on dp.IdPlan = PC.IdDetallesPlan
			inner join OLAPTelefonia.dbo.dimPersonal dpe on dpe.IdPersonal = R.IdPersonal
			inner join OLAPTelefonia.dbo.dimCliente dc on dc.IdCliente = PC.IdCliente
			group by du.keyUbigeo,dt.keyTiempo,dr.keyTipoReclamo,dp.keyPlan, dpe.keyPersonal, dc.keyCliente
			union
			 select keyUbigeo = du.keyUbigeo,
				keyTiempo = dt.keyTiempo,
				keyTipoReclamo = dr.keyTipoReclamo,
				keyPlan = dp.keyPlan,
				keyPersonal = dpe.keyPersonal,
				keyCliente = dc.keyCliente,
				ReclamosResueltos = 0,
				ReclamosRealizados = count(R.IdReclamo)
			from OLTPTelefonia.dbo.Reclamo R
			inner join OLTPTelefonia.dbo.Atencion A on R.IdAtencion = A.IdAtencion
			inner join OLTPTelefonia.dbo.Plan_Fijo PF on R.IdPlan=PF.IdPlan
			inner join OLTPTelefonia.dbo.PlanContratado PC on PF.IdPlan = PC.IdPlan
			inner join OLAPTelefonia.dbo.dimUbigeo du on du.IdDistrito = PF.IdDistrito
			inner join OLAPTelefonia.dbo.dimTiempo dt on dt.IdFecha = R.FechaReclamo
			inner join OLAPTelefonia.dbo.dimTipoReclamo dr on dr.IdTipoReclamo = R.IdTipoReclamo
			inner join OLAPTelefonia.dbo.dimPlan dp on dp.IdPlan = PC.IdDetallesPlan
			inner join OLAPTelefonia.dbo.dimPersonal dpe on dpe.IdPersonal = A.IdPersonal
			inner join OLAPTelefonia.dbo.dimCliente dc on dc.IdCliente = PC.IdCliente
			group by du.keyUbigeo,dt.keyTiempo,dr.keyTipoReclamo,dp.keyPlan, dpe.keyPersonal, dc.keyCliente
go

select sum(reclamosresueltos), sum(reclamosrealizados) from OLAPTelefonia.dbo.hechoReclamos
select count(IdReclamo) from OLTPTelefonia.dbo.Reclamo where estado = 'Resuelto'

--Poblamiento de hechoMetaOferta
delete from OLAPTelefonia.dbo.hechoMetaOferta
insert into OLAPTelefonia.dbo.hechoMetaOferta (keyTiempo, keyOferta, MetaOferta)
select	keyTiempo = dt.keyTiempo,
				keyOferta = do.keyOferta,
				MetaOFERTA = sum(o.Meta)
			from OLTPTelefonia.dbo.Oferta O
			inner join OLAPTelefonia.dbo.dimTiempo dt on dt.IdFecha = o.FechaInicio
			inner join OLAPTelefonia.dbo.dimOferta do on do.IdOferta = o.IdOferta
			group by dt.keyTiempo,do.keyOferta

go

select sum(meta) from OLTPTelefonia.dbo.oferta

select sum(metaoferta) from OLAPTelefonia.dbo.hechoMetaOferta

--Poblamiento de hechoRecargas
delete from OLAPTelefonia.dbo.hechoRecargas
insert into OLAPTelefonia.dbo.hechoRecargas (keyTiempo, keyOferta, keyCliente, MontoRecargaOferta)
select	keyTiempo = dt.keyTiempo,
				keyOferta = do.keyOferta,
				keyCliente = dc.keyCliente,
				MontoRecargaOferta = sum(r.Saldo)
			from OLTPTelefonia.dbo.Recarga r
			inner join OLTPTelefonia.dbo.PlanContratado PC on r.IdPlan = PC.IdPlan
			inner join OLAPTelefonia.dbo.dimTiempo dt on dt.IdFecha = r.FechaRecarga
			inner join OLAPTelefonia.dbo.dimOferta do on do.IdOferta = r.IdOferta
			inner join OLAPTelefonia.dbo.dimCliente dc on dc.IdCliente = PC.IdCliente
			group by dt.keyTiempo,do.keyOferta, dc.keyCliente
go
select sum(montorecargaoferta) from OLAPTelefonia.dbo.hechoRecargas

select sum(saldo) from OLTPTelefonia.dbo.recarga where idoferta is not null

--Poblamiento de hechoPlanes
delete from OLAPTelefonia.dbo.hechoPlanes
insert into OLAPTelefonia.dbo.hechoPlanes (keyCliente, keyTiempo, keyPlan, planesNuevos, PlanesDeBaja, RecibosEmitidos, RecibosPagados)
select	keyCliente =  dc.keyCliente,
				keyTiempo = dt.keyTiempo,
				keyPlan = dp.keyPlan,				
				PlanesNuevos = count(distinct case when PC.FechaCreacion = dt.IdFecha then PC.IdPlan else null end),
				PlanesDeBaja = count(distinct case when PC.Estado = 'Inactivo' and PC.FechaBaja = dt.IdFecha then PC.IdPlan else null end),
				RecibosEmitidos = count(distinct case when R.FechaEmision = dt.IdFecha then R.IdRecibo else null end),
				RecibosPagados = count(distinct case when R.Estado = 'Pagado' and R.FechaEmision = dt.IdFecha then R.IdRecibo else null end)
			from OLTPTelefonia.dbo.PlanContratado PC
			left join OLTPTelefonia.dbo.Recibo R on r.IdPlan = PC.IdPlan
			inner join OLAPTelefonia.dbo.dimTiempo dt on dt.IdFecha = r.FechaEmision or dt.IdFecha = pc.FechaCreacion or dt.IdFecha = pc.FechaBaja
			inner join OLAPTelefonia.dbo.dimPlan dp on dp.IdPlan = PC.IdDetallesPlan
			inner join OLAPTelefonia.dbo.dimCliente dc on dc.IdCliente = PC.IdCliente
			group by dt.keyTiempo,DP.keyPlan, dc.keyCliente
			
go
select count(keyCliente) from hechoPlanes
select SUM(planesNuevos), sum(planesdebaja), sum(recibosemitidos), sum(recibospagados) from hechoPlanes
select count(IdPlan) from OLTPTelefonia.dbo.PlanContratado where estado = 'Inactivo'
select count(IdRecibo) from OLTPTelefonia.dbo.Recibo where estado = 'Pagado'




