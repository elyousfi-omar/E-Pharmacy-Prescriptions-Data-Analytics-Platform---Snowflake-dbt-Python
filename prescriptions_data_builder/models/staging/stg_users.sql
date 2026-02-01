select
    md5(user_id || email) as user_sk,
    user_id,
    name as full_name,
    email,
    phone as phone_number,
    address,
    joined_at
from 
    pharmacy_db.public.users