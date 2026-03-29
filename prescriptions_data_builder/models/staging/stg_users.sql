with base_users as (
    select * from {{ ref('users_snapshot') }}
)
select
    md5(user_id || email) as user_sk,
    user_id,
    name as full_name,
    email,
    phone as phone_number,
    address,
    joined_at,
    dbt_scd_id,
    dbt_updated_at,
    dbt_valid_from,
    dbt_valid_to
from 
    base_users