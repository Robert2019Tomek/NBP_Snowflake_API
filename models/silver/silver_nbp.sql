{{
    config(
        materialized='incremental',
        unique_key='UNIQUEKEY'
    )
}}


SELECT
    CONCAT(t.DATA_JSON:effectiveDate::DATE ,'_', t.DATA_JSON:tradingDate::DATE ,'_',r.value:code::STRING,'_',t.DATA_JSON:DateTimeStartLoad::TIMESTAMP) AS UNIQUEKEY,
    CONCAT(t.DATA_JSON:effectiveDate::DATE ,'_', t.DATA_JSON:tradingDate::DATE ,'_',r.value:code::STRING) AS UNIQUEKEY2,
    t.DATA_JSON:DateEndAPI::DATE               AS DATE_END_API,
    t.DATA_JSON:DateStartAPI::DATE             AS DATE_START_API,
    t.DATA_JSON:DateStartLoad::DATE            AS DATE_START_LOAD,
    t.DATA_JSON:DateTimeStartLoad::TIMESTAMP   AS DATETIME_START_LOAD,
    t.DATA_JSON:effectiveDate::DATE            AS EFFECTIVE_DATE,
    t.DATA_JSON:no::STRING                     AS NO,
    t.DATA_JSON:table::STRING                  AS TABLE_TYPE,
    t.DATA_JSON:tradingDate::DATE              AS TRADING_DATE,

    r.value:code::STRING                  AS CURRENCY_CODE,
    r.value:currency::STRING              AS CURRENCY_NAME,
    r.value:ask::NUMBER(10,6)              AS ASK,
    r.value:bid::NUMBER(10,6)              AS BID
    
    
FROM {{ref('bronze_nbp')}} t, 
LATERAL FLATTEN(INPUT => t.DATA_JSON:rates) r