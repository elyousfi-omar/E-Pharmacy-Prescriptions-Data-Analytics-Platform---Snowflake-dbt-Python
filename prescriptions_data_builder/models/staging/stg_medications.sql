select
    medication_id,
    prescription_id,
    medication_name,
    form,
    strength,
    lpad(din, 8, '0') as drug_identification_number
from pharmacy_db.public.medications