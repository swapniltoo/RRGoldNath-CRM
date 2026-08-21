# RR Gold Nath

A browser-ready premium catalogue and About Us experience for RR Gold Nath. Open `index.html` directly to preview it, or serve the folder from any static web server.

## Current workspace

The workspace originally contained only the existing numbered JPEG assets in `Images/`. The public experience uses those assets without modifying or relocating them. Routes are hash-based so the static site works from cPanel without a build step:

- `#/` home
- `#/about` heritage-focused About Us page
- `#/catalogue` Nath & Nose Jewellery catalogue with search, region/style filters, and category navigation
- `#/product/{name}` product detail
- `#/contact` enquiry form
- `#/admin` local About content editor and Nath subcategory manager

The Admin route requires username `RRAdmin` and password `RRAdmin@1234` in this browser prototype. Access is held in `sessionStorage` until the tab is closed. After login, the Nath management panel supports adding, updating, deleting, and hiding/showing categories, subcategories, and products. Changes persist in `localStorage` and active products are reflected in the public catalogue.

The editor and Nath category tree currently use browser `localStorage`; seeded Nath groups, subcategories, product metadata, tags, regions, styles, and materials are represented in the same data flow. The browser login is only a prototype gate; production must replace it with server-side authentication, password hashing, secure sessions, MySQL/MariaDB, server-side search, and server-side persistence.

## cPanel production work

To meet the full CRM brief, add a Node.js API compatible with cPanel Setup Node.js App, MySQL/MariaDB migrations, secure admin authentication, and a `LocalStorageService` rooted at `IMAGE_STORAGE_PATH=./Images`. The API should store relative paths such as `Images/Products/RRG-001/front.webp`, expose `/Images/...` public URLs, validate MIME/type/size/dimensions, and create the requested `Images/Categories`, `Images/Products`, `Images/Collections`, and `Images/Website/About` directories. Keep uploaded files non-executable with an appropriate `.htaccess` rule.

Required production environment variables include `PORT`, `DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER`, `DB_PASSWORD`, `IMAGE_STORAGE_PATH`, `MAX_IMAGE_SIZE_MB`, and `SESSION_SECRET`. Do not commit secrets. Backups must include the database, `Images/`, and configuration.
