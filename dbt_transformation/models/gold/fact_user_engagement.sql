{{ config(materialized='table', schema='gold') }}

with silver_streams as (
    select * from {{ ref('stg_tracks') }}
)

select
    user_id,
    -- Count the true event rows using your valid unique column
    count(event_id) as total_streams,
    
    -- Count unique music variety per user
    count(distinct song_id) as unique_songs_listened,
    count(distinct artist_name) as unique_artists_listened

from silver_streams
group by 1