{{ config(materialized='table', schema='silver') }}

with raw_source as (
    select * from {{ source('minio_raw', 'raw_tracks') }}
)

select
    cast(event_id as varchar) as event_id,
    cast(user_id as varchar) as user_id,
    cast(song_id as varchar) as song_id,
    cast(song_name as varchar) as song_name,
    cast(artist_name as varchar) as artist_name,
    cast(event_type as varchar) as event_type,
    cast(device_type as varchar) as device_type,
    cast(country as varchar) as country,
    -- Converts your producer's ISO timestamp string directly into a standard DuckDB timestamp
    cast(timestamp as timestamp) as event_timestamp
from raw_source
where event_id is not null