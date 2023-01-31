import time
import os
from datetime import datetime
import pandas as pd
from google.cloud import bigquery
import pypyodbc as odbc
from sqlserver import SQLServer
from google.oauth2 import service_account

os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = 'protean-harbor-374822-fd3b6febe176.json'
client = bigquery.Client()

SERVER_NAME = 'localhost'
DATABASE_NAME = 'OLTPTelefonia'
credentials = service_account.Credentials.from_service_account_file( 'protean-harbor-374822-fd3b6febe176.json')
project_id = "protean-harbor-374822"
dateset_ref = "BI"

sql_server_instance = SQLServer(SERVER_NAME, DATABASE_NAME)
sql_server_instance.connect_to_sql_server()

job_config = bigquery.LoadJobConfig(
    autodetect = True,
    write_disposition = 'WRITE_TRUNCATE'
)

query = "select idfecha, keytiempo from protean-harbor-374822.BI.dimTiempo"
df_Tiempo = pd.read_gbq(query,project_id,"idfecha",credentials=credentials)

credentials = service_account.Credentials.from_service_account_file( 'protean-harbor-374822-fd3b6febe176.json')
query = "select idoferta, keyoferta from protean-harbor-374822.BI.dimOferta"
df_Oferta = pd.read_gbq(query,project_id,"idoferta",credentials=credentials)

query = "select idpersonal, keypersonal from protean-harbor-374822.BI.dimPersonal"
df_Personal = pd.read_gbq(query,project_id,"idpersonal",credentials=credentials)

query = "select idplan, keyplan from protean-harbor-374822.BI.dimPlan"
df_Plan = pd.read_gbq(query,project_id,"idplan",credentials=credentials)

query = "select idcliente, keycliente from protean-harbor-374822.BI.dimCliente"
df_Cliente = pd.read_gbq(query,project_id,"idcliente",credentials=credentials)

query = "select idtiporeclamo, keytiporeclamo from protean-harbor-374822.BI.dimTipoReclamo"
df_TipoReclamo = pd.read_gbq(query,project_id,"idtiporeclamo",credentials=credentials)

query = "select iddistrito, keyubigeo from protean-harbor-374822.BI.dimUbigeo"
df_Ubigeo = pd.read_gbq(query,project_id,"iddistrito",credentials=credentials)

#HECHOMETAOFERTA

sql_statement = """
SELECT *
FROM v_HechoMetaOferta
"""
target_table_id = 'protean-harbor-374822.BI.hechoMetaOferta'

columns, records =sql_server_instance.query(sql_statement)
df = pd.DataFrame(records, columns = columns)
df = df.merge(df_Tiempo, how='left', on='idfecha')
df = df.merge(df_Oferta, how='left', on='idoferta')
df = df.drop('idfecha', 1)
df = df.drop('idoferta', 1)

job = client.load_table_from_dataframe(df, target_table_id, job_config = job_config)

#HECHORECARGAS

sql_statement = """
SELECT *
FROM v_HechoRecargas
"""
target_table_id = 'protean-harbor-374822.BI.hechoRecargas'

columns, records =sql_server_instance.query(sql_statement)
df = pd.DataFrame(records, columns = columns)
df = df.merge(df_Tiempo, how='left', on='idfecha')
df = df.merge(df_Oferta, how='left', on='idoferta')
df = df.merge(df_Cliente, how='left', on='idcliente')
df = df.drop('idfecha', 1)
df = df.drop('idoferta', 1)
df = df.drop('idcliente', 1)

job = client.load_table_from_dataframe(df, target_table_id, job_config = job_config)

#HECHORECARGAS

sql_statement = """
SELECT *
FROM v_HechoReclamos
"""
target_table_id = 'protean-harbor-374822.BI.hechoReclamos'

columns, records =sql_server_instance.query(sql_statement)
df = pd.DataFrame(records, columns = columns)
df = df.merge(df_Tiempo, how='left', on='idfecha')
df = df.merge(df_Ubigeo, how='left', on='iddistrito')
df = df.merge(df_Cliente, how='left', on='idcliente')
df = df.merge(df_TipoReclamo, how='left', on='idtiporeclamo')
df = df.merge(df_Plan, how='left', on='idplan')
df = df.drop('idfecha', 1)
df = df.drop('iddistrito', 1)
df = df.drop('idcliente', 1)
df = df.drop('idtiporeclamo', 1)
df = df.drop('idplan', 1)
df = df.merge(df_Personal, how='left', on='idpersonal')
df = df.drop('idpersonal', 1)

job = client.load_table_from_dataframe(df, target_table_id, job_config = job_config)

#HECHOPLANES

sql_statement = """
SELECT *
FROM v_HechoPlan
"""
target_table_id = 'protean-harbor-374822.BI.hechoPlanes'

columns, records =sql_server_instance.query(sql_statement)
df = pd.DataFrame(records, columns = columns)
df = df.merge(df_Tiempo, how='left', on='idfecha')
df = df.merge(df_Cliente, how='left', on='idcliente')
df = df.merge(df_Plan, how='left', on='idplan')
df = df.drop('idfecha', 1)
df = df.drop('idcliente', 1)
df = df.drop('idplan', 1)

job = client.load_table_from_dataframe(df, target_table_id, job_config = job_config)


#target_table_id = 'protean-harbor-374822.BI.hechoMetaOferta'
#job = client.load_table_from_dataframe(df, target_table_id, job_config = job_config)