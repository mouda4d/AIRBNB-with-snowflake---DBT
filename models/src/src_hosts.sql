WITH raw_hosts AS (
    SELECT * FROM {{ source('airbnb', 'hosts') }}
)

SELECT 
    ID AS host_id,
    name AS host_name,
    is_superhost,
    created_at AS created_at_timestamp,
    updated_at AS updated_at_timestamp
FROM
    raw_hosts