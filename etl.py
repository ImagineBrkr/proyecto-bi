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

sql_server_instance = SQLServer(SERVER_NAME, DATABASE_NAME)
sql_server_instance.connect_to_sql_server()

job_config = bigquery.LoadJobConfig(
    autodetect = True,
    write_disposition = 'WRITE_TRUNCATE'
)

sql_statement = """
SELECT *
FROM v_DimTipoReclamo
"""
columns, records =sql_server_instance.query(sql_statement)
df = pd.DataFrame(records, columns = columns)
target_table_id = 'protean-harbor-374822.BI.dimTipoReclamo'
job = client.load_table_from_dataframe(df, target_table_id, job_config = job_config)

sql_statement = """
SELECT *
FROM v_DimCliente
"""
columns, records =sql_server_instance.query(sql_statement)
df = pd.DataFrame(records, columns = columns)
target_table_id = 'protean-harbor-374822.BI.dimCliente'
job = client.load_table_from_dataframe(df, target_table_id, job_config = job_config)

sql_statement = """
SELECT *
FROM v_DimUbigeo
"""
columns, records =sql_server_instance.query(sql_statement)
df = pd.DataFrame(records, columns = columns)
target_table_id = 'protean-harbor-374822.BI.dimUbigeo'
job = client.load_table_from_dataframe(df, target_table_id, job_config = job_config)

sql_statement = """
SELECT *
FROM v_DimPlan
"""
columns, records =sql_server_instance.query(sql_statement)
df = pd.DataFrame(records, columns = columns)
target_table_id = 'protean-harbor-374822.BI.dimPlan'
job = client.load_table_from_dataframe(df, target_table_id, job_config = job_config)

sql_statement = """
SELECT *
FROM v_DimOferta
"""
columns, records =sql_server_instance.query(sql_statement)
df = pd.DataFrame(records, columns = columns)
target_table_id = 'protean-harbor-374822.BI.dimOferta'
job = client.load_table_from_dataframe(df, target_table_id, job_config = job_config)

sql_statement = """
SELECT *
FROM v_DimTiempo
"""
columns, records =sql_server_instance.query(sql_statement)
df = pd.DataFrame(records, columns = columns)
target_table_id = 'protean-harbor-374822.BI.dimTiempo'
job = client.load_table_from_dataframe(df, target_table_id, job_config = job_config)

sql_statement = """
SELECT *
FROM v_DimPersonal
"""
columns, records =sql_server_instance.query(sql_statement)
df = pd.DataFrame(records, columns = columns)
target_table_id = 'protean-harbor-374822.BI.dimPersonal'
job = client.load_table_from_dataframe(df, target_table_id, job_config = job_config)