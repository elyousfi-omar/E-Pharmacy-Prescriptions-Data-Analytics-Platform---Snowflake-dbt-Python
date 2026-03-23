-- Extract distinct medications from source, removing prescription context
-- Medications should be dimension data independent of any single prescription
select distinct
    medication_id,
    medication_name,
    form,
    strength,
    lpad(din, 8, '0') as drug_identification_number
from {{ source('source_data', 'medications') }}
order by medication_id