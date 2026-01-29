SELECT
    CONCAT(t.DATA_JSON:effectiveDate::DATE ,'_', t.DATA_JSON:tradingDate::DATE ,'_',r.value:code::STRING ) AS UniqueKey,
    t.DATA_JSON:DateEndAPI::DATE               AS date_end_api,
    t.DATA_JSON:DateStartAPI::DATE             AS date_start_api,
    t.DATA_JSON:DateStartLoad::DATE            AS date_start_load,
    t.DATA_JSON:DateTimeStartLoad::TIMESTAMP   AS datetime_start_load,
    t.DATA_JSON:effectiveDate::DATE            AS effective_date,
    t.DATA_JSON:no::STRING                     AS no,
    t.DATA_JSON:table::STRING                  AS table_type,
    t.DATA_JSON:tradingDate::DATE              AS trading_date,

    r.value:code::STRING                  AS currency_code,
    r.value:currency::STRING              AS currency_name,
    r.value:ask::NUMBER(10,6)              AS ask,
    r.value:bid::NUMBER(10,6)              AS bid
    
    
FROM {{ref('bronze_nbp')}} t, 
LATERAL FLATTEN(INPUT => t.DATA_JSON:rates) r