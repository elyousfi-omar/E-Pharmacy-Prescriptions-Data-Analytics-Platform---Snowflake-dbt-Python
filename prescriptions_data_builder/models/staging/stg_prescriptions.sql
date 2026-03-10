with base_data as (
    select * from {{ref('prescriptions_snapshot')}}
)
select 
        md5(prescription_id || order_date) as prescription_sk,
       prescription_id,
       user_id,
       shipping_fee,
       sub_total,
       insured_amount,
       round(total_amount, 2) as total_amount,
       shipping_partner,
       delivery_status,
       order_date,
       delivery_date,
       dbt_scd_id,
       dbt_updated_at,
       dbt_valid_from,
       dbt_valid_to
from base_data
