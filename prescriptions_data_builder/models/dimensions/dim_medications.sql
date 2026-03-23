{{ config(
    materialized='incremental',
    unique_key='medication_id'
) }}

with source_medications as (
    select *
    from {{ ref('stg_medications') }}
),
dim_medications as (
    select
        md5(medication_name || form || strength || drug_identification_number) as medication_sk,
        medication_id,
        medication_name,
        form,
        strength,
        drug_identification_number,
        current_timestamp as added_at
    from source_medications
    {% if is_incremental() %}
        -- Only insert medications that do NOT already exist
        where medication_id not in (
            select medication_id from {{ this }}
        )
    {% endif %}
)
select * from dim_medications