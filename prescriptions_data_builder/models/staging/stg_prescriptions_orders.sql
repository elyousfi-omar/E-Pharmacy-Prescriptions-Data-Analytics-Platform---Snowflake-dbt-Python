with medications as (
    select *
    from {{ ref('stg_medications') }}
),
prescriptions as (
    select *
    from {{ ref('stg_prescriptions') }}
),
prescription_orders as (
    select
        md5(
            p.prescription_id ||
            p.dbt_valid_from
        ) as prescription_sk,
        md5(medication_name || form || strength || drug_identification_number) as medication_sk,
        p.prescription_id,
        m.medication_id,
        m.medication_name,
        m.form,
        m.strength,
        m.drug_identification_number,
        p.user_id,
        p.shipping_fee,
        p.sub_total,
        p.insured_amount,
        p.total_amount,
        p.shipping_partner,
        p.delivery_status,
        p.order_date,
        p.delivery_date,
        p.dbt_scd_id,
        p.dbt_updated_at,
        p.dbt_valid_from,
        p.dbt_valid_to
    from prescriptions p
    join medications m
        on p.prescription_id = m.prescription_id
)select * from prescription_orders