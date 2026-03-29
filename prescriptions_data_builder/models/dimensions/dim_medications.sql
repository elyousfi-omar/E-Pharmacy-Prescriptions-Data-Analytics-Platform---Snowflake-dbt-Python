with deduped_medications as (
    select distinct medication_sk, medication_name, form, strength, drug_identification_number
    from {{ref('stg_prescriptions_orders')}}
),
dim_medications as (
    select
        medication_sk,
        medication_name,
        form,
        strength,
        drug_identification_number,
        current_timestamp as added_at
    from deduped_medications
    {% if is_incremental() %}
        -- Only insert medications that do NOT already exist
        where din not in (
            select din from {{ this }}
        )
    {% endif %}
)
select * from dim_medications