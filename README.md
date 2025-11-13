## Admin Access

Control who sees the Admin Panel using the `VITE_ADMIN_USER_ID` environment variable. Only users whose ID appears in this list will have admin privileges.

- Where to find your User ID: open the app and scroll to the footer. Copy the value shown as "Your User ID".
- Multiple admins: provide a comma‑separated list of IDs.

### Local development

Create a `.env.local` file at the project root:

```
VITE_ADMIN_USER_ID=id-abc123,id-def456
```

Restart the dev server after changing env files.

### Production build / GitHub Pages

Create a `.env.production` file at the project root before building/deploying:

```
VITE_ADMIN_USER_ID=id-abc123,id-def456
```

Then build and deploy:

```powershell
npm run predeploy; npm run deploy
```

Notes:
- The app uses Firebase Anonymous Auth; the displayed User ID is the Firebase `uid` for that browser/device.
- If a user switches devices/browsers, they’ll get a new ID and you’ll need to add it to `VITE_ADMIN_USER_ID` if they should keep admin access.

# Climb CCNY Registration App

A React App made to stream line the registration process for Climb CCNY members. 

This app saves the data of registrants so they don't have to keep filling in the same information for each of our weekly sessions. 

Admins can publish unique events for users to sign up to. Users then press one button to register for said event. 

Live site: https://climb-ccny-registration.vercel.app/