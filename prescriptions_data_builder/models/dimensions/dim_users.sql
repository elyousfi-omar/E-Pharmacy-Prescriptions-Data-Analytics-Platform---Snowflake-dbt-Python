with dim_users as (
    select * from {{ref('stg_users')}}
)select * from dim_users