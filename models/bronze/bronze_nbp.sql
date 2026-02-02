
{% set target_relation = adapter.get_relation(
      database=this.database,
      schema=this.schema,
      identifier=this.name) %}
{% set table_non_exists=target_relation is  none %}


{% set incremental_col = 'DATE_TIME_START_LOAD' %}

{% if table_non_exists %}
    SELECT 
        *
        ,{{ct()}} AS DateLoadToBronze
    FROM 
        {{source('raw','nbp_raw_data')}}
{% else %}
    {{ config(materialized='incremental')}}
    SELECT 
        * 
        ,{{ct()}} AS DateLoadToBronze
    FROM
        {{source('raw','nbp_raw_data')}}
    {% if is_incremental() %}
        WHERE 
        {{incremental_col}} > (SELECT COALESCE(MAX({{incremental_col}}),'1990-01-01') FROM {{this}})
    {% endif %}
{% endif %}