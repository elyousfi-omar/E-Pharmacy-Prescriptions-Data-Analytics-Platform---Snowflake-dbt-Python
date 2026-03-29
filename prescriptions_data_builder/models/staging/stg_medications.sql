
select 
    medication_id,
    medication_name,
    form,
    strength,
    lpad(din, 8, '0') as drug_identification_number,
    prescription_id
from {{ source('source_data', 'medications') }}
order by medication_id