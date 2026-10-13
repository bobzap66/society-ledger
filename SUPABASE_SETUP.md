# Supabase image storage setup

Society Ledger keeps email/password sign-in and character ledger sync in Firebase. Chronicle scans and portraits use a private Supabase Storage bucket. The browser sends the signed-in Firebase ID token to Supabase; row-level policies limit each account to its own files.

1. Create a Supabase project on the Free plan.
2. In Supabase Dashboard, open **Authentication → Third-Party Auth**, add **Firebase**, and enter Firebase project ID **society-ledger-12bce**.
3. In **Storage**, create a **private** bucket named **society-ledger-files**.
4. Open **SQL Editor** and run the contents of [supabase-storage-policies.sql](supabase-storage-policies.sql).
5. In **Project Settings → API**, copy the Project URL and the **publishable** key (or legacy anon key) into [supabase-config.js](supabase-config.js). Never use a secret or service-role key in the website.
6. Once configured and deployed, sign in to Society Ledger. Existing attachment blobs on this browser will upload automatically; other devices will download them when opened.

Files remain in this browser if Supabase is not configured or is unavailable. Free Supabase projects can pause when inactive, so resume the project in Supabase Dashboard if file sync stops after a long idle period. Check the Supabase dashboard for current storage and egress usage.
