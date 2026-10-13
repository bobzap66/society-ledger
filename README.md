# Society Ledger

A mobile-friendly first workflow for Pathfinder Society (second edition) character records. This prototype saves structured data in browser local storage and attachments in IndexedDB. Starfinder 2e is a later phase.

## Current prototype

- Character profiles with Organized Play IDs, character numbers, factions, and portraits.
- PFS chronicle intake for photos and PDFs, with browser OCR/text extraction and an editable confirmation form.
- Confirmed XP, gold, and faction reputation changes update the character ledger. PFS level is derived from running XP at 12 XP per level.
- Structured records are kept in browser local storage and can sync to the signed-in Firebase account. Chronicle attachments and portraits remain in browser IndexedDB on this device.
- Permanent and limited-use boon tracking, including use and reset controls.
- A purchase ledger records buys made between chronicles and deducts their cost from current gold.
- An optional private migration import can seed character balances and ledger history, then associate entries with Paizo session history.
- Google Sheet gear and purchase notes are preserved as notes. They are not treated as completed purchases or deducted a second time.

## Privacy

Personal source exports are ignored by Git and excluded from the Pages upload by an explicit public-file allowlist in `scripts/prepare-pages.mjs`. Keep those exports private. The site contains app assets only. Character records sync to each signed-in user's Firestore account; scans and portraits remain in that browser.

## Local run

Serve this folder with any static file server, then open the local URL. Camera capture and service-worker installation require HTTPS or localhost. OCR and PDF text extraction load their libraries from public CDNs.

To load a private migration, open Characters, choose **Import character data**, and select the JSON export. The import is safe to repeat: imported ledger rows and Paizo sessions use stable identifiers. Existing imported records can be refreshed by re-importing the file.

## GitHub Pages

The workflow at `.github/workflows/pages.yml` deploys on pushes to `main`. It builds `site/` from an explicit list of public app files, so private JSON exports and local Firebase CLI configuration are not uploaded. In the GitHub repository settings, set **Pages → Build and deployment → Source** to **GitHub Actions**. The project source is published in a public repository.

## Firebase

Email/password sign-in and Firestore sync are connected to project `society-ledger-12bce`. A first sign-in creates the private ledger document under that account's UID and uploads existing local structured records. Later saves sync automatically. If local and cloud copies both changed since the last sync, the app asks which copy to keep. This is whole-ledger sync; make one copy the source of truth when resolving a conflict. Chronicle scans and portraits remain in the browser's IndexedDB and are not synced to other devices yet. Firebase's browser SDK config is public client configuration; never commit service-account keys. Cloud Storage uploads are a later step because this Firebase project needs the Blaze plan for Storage.

## PFS advancement

The tracker uses the Pathfinder Society rule of one level for every 12 XP; XP remains a running total. See Paizo's [Pathfinder Society guide](https://lorespire.paizo.com/tiki-index.php?page=Guide-to-Organized-Play%3A-Pathfinder-Society---Second-Edition).
