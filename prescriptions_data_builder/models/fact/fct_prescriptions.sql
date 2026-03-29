{{ config(
    materialized='incremental',
    unique_key='fact_sk',
    incremental_strategy='merge'
) }}

with prescriptions as (
    select *
    from {{ ref('stg_prescriptions_orders') }}
),
users as (
    select *
    from {{ ref('dim_users') }}
),
final_fact as (
    select 
        md5(prescription_id || p.dbt_valid_from || medication_id) as fact_sk,
        medication_sk,
        u.user_sk,
        medication_id,
        prescription_id,
        shipping_fee,
        sub_total,
        insured_amount,
        total_amount,
        shipping_partner,
        delivery_status,
        order_date,
        delivery_date,
        p.dbt_scd_id,
        p.dbt_updated_at,
        p.dbt_valid_from,
        p.dbt_valid_to
    from prescriptions p 
    inner join users u
        on p.user_id = u.user_id
)
select * from final_fact