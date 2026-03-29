select fact_sk, count(*) 
from {{ ref('fct_prescriptions') }}
group by fact_sk having count(*) > 1