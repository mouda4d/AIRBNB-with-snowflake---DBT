{{
  config(
    materialized = 'view',
  )
}}

WITH src_hosts AS (
    SELECT 
        *    
    FROM 
        {{ ref('src_hosts') }}
)

SELECT 
    host_id,
    NVL(host_name, 'Anonymous') AS host_name,
    is_superhost,
    created_at_timestamp,
    updated_at_timestamp
FROM
    src_hosts