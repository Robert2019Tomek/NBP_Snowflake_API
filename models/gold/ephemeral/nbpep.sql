{{
  config(
    materialized = 'ephemeral',
    )
}}

WITH CTE 
AS
(
SELECT 
    UNIQUEKEY,
    UNIQUEKEY2
    DATE_END_API,
    DATE_START_API,
    DATE_START_LOAD,
    DATETIME_START_LOAD,
    EFFECTIVE_DATE,
    NO,
    TABLE_TYPE,
    TRADING_DATE,
    CURRENCY_CODE,
    CURRENCY_NAME,
    ASK,
    BID
FROM
    {{ref('obt_nbp')}}


)
SELECT * FROM CTE