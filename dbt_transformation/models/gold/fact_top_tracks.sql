{{ config(materialized='table', schema='gold') }}

with clean_staging as (
    select * from {{ ref('stg_tracks') }}
)

select 
    song_name,
    artist_name,
    -- Filters to only count actual "play" events from your simulator
    count(case when event_type = 'play' then 1 end) as total_plays,
    count(case when event_type = 'skip' then 1 end) as total_skips,
    count(distinct user_id) as unique_listeners
from clean_staging
group by 1, 2
order by total_plays desc