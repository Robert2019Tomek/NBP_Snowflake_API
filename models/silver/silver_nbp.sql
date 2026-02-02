{% set incremental_col = 'DATE_TIME_START_LOAD' %}

SELECT
    t.DATA_JSON:DateEndAPI::DATE AS DATE_END_API,
    t.DATA_JSON:DateStartAPI::DATE AS DATE_START_API,
    t.DATA_JSON:DateStartLoad::DATE AS DATE_START_LOAD,
    t.DATA_JSON:effectiveDate::DATE AS EFFECTIVE_DATE,
    t.DATA_JSON:no::STRING AS NO_COL,
    t.DATA_JSON:table::STRING AS TABLE_TYPE,
    t.DATA_JSON:tradingDate::DATE   AS TRADING_DATE,
    r.value:code::STRING AS CURRENCY_CODE,
    r.value:currency::STRING AS CURRENCY_NAME,
    r.value:ask::NUMBER(10,6) AS ASK,
    r.value:bid::NUMBER(10,6) AS BID,
    t.DATE_TIME_START_LOAD                   AS DATE_TIME_START_LOAD,
    {{ ct() }}                               AS DateLoadToSilver
FROM 
    {{ ref('bronze_nbp') }} t,
    LATERAL FLATTEN(INPUT => t.DATA_JSON:rates) r
    {% if is_incremental() %}
WHERE 
    {{ incremental_col }} > (SELECT COALESCE(MAX({{ incremental_col }}),'1990-01-01') FROM {{ this }})
    {% endif %}
