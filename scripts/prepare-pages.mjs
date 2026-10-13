import { cp, mkdir, rm, writeFile } from 'node:fs/promises';
import { dirname, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';

const root = resolve(dirname(fileURLToPath(import.meta.url)), '..');
const site = resolve(root, 'site');
const publicFiles = [
  'index.html',
  'styles.css',
  'app.js',
  'manifest.webmanifest',
  'service-worker.js',
];

await rm(site, { recursive: true, force: true });
await mkdir(site, { recursive: true });
for (const file of publicFiles) {
  await cp(resolve(root, file), resolve(site, file));
}
await writeFile(resolve(site, '.nojekyll'), '', 'utf8');
console.log(`Prepared ${publicFiles.length} public app files in site/.`);
