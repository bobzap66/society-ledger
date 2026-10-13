-- Create a PRIVATE bucket named society-ledger-files first.
-- Enable Firebase third-party auth for project society-ledger-12bce in Supabase.
-- The policies scope each file to the verified Firebase issuer, audience, and UID.
create policy "Users can read their own ledger attachments"
on storage.objects for select to anon
using (bucket_id = 'society-ledger-files'
  and (storage.foldername(name))[1] = (auth.jwt() ->> 'sub')
  and auth.jwt() ->> 'iss' = 'https://securetoken.google.com/society-ledger-12bce'
  and auth.jwt() ->> 'aud' = 'society-ledger-12bce');

create policy "Users can upload their own ledger attachments"
on storage.objects for insert to anon
with check (bucket_id = 'society-ledger-files'
  and (storage.foldername(name))[1] = (auth.jwt() ->> 'sub')
  and auth.jwt() ->> 'iss' = 'https://securetoken.google.com/society-ledger-12bce'
  and auth.jwt() ->> 'aud' = 'society-ledger-12bce');

create policy "Users can update their own ledger attachments"
on storage.objects for update to anon
using (bucket_id = 'society-ledger-files'
  and (storage.foldername(name))[1] = (auth.jwt() ->> 'sub')
  and auth.jwt() ->> 'iss' = 'https://securetoken.google.com/society-ledger-12bce'
  and auth.jwt() ->> 'aud' = 'society-ledger-12bce')
with check (bucket_id = 'society-ledger-files'
  and (storage.foldername(name))[1] = (auth.jwt() ->> 'sub')
  and auth.jwt() ->> 'iss' = 'https://securetoken.google.com/society-ledger-12bce'
  and auth.jwt() ->> 'aud' = 'society-ledger-12bce');
