# Deployment Guide

Flutter portfolio hosted on Firebase Hosting at
**https://flutter-portfolio-7e0c1.web.app**

---

## Prerequisites

Make sure these are installed and configured once:

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Firebase CLI](https://firebase.google.com/docs/cli) — `npm install -g firebase-tools`
- Logged in to Firebase — `firebase login`

---

## Deploy Latest Changes

Every time you want to push an update to production, run these two commands from the project root:

```bash
# 1. Build optimized release bundle
flutter build web --release

# 2. Deploy to Firebase Hosting
firebase deploy --only hosting
```

That's it. Firebase will upload the contents of `build/web` and release the new version.

---

## Local Development

Run the app in Chrome with hot-restart enabled:

```bash
flutter run -d chrome
```

- Press `r` to hot reload
- Press `R` to hot restart
- Press `q` to quit

---

## Project Structure

```
lib/
├── main.dart                        # App entry point + AppTheme constants
├── data/
│   ├── models.dart                  # ProjectModel, ExperienceModel
│   └── portfolio_data.dart          # All portfolio content (projects, skills, experience)
├── state/
│   └── scroll_state.dart            # PortfolioScrollState (ChangeNotifier)
├── pages/
│   └── portfolio_page.dart          # Root page — scroll controller, cursor tracking
└── widgets/
    ├── nav_bar.dart                  # Top navigation with active section highlight
    ├── hero_section.dart             # Hero with typewriter animation
    ├── stats_row.dart                # Animated stats (4+ yrs, 1M+ users, etc.)
    ├── project_grid.dart             # Project cards grid
    ├── experience_section.dart       # TCS experience with highlights
    ├── skills_section.dart           # Skills grouped by category
    ├── contact_section.dart          # Contact links and CTA buttons
    ├── content_layer.dart            # Main scroll layout — assembles all sections
    └── shared/
        ├── buttons.dart              # CTAButton, OutlineButton, PulsingDot, BlinkingCursor
        ├── particle_background.dart  # Animated canvas particle system
        └── spotlight_overlay.dart    # Cursor spotlight effect
```

---

## Firebase Config

| File | Purpose |
|---|---|
| `firebase.json` | Hosting config — serves from `build/web`, rewrites to `index.html` |
| `.firebaserc` | Links project to Firebase project ID `flutter-portfolio-7e0c1` |

No changes to Firebase config are needed for routine deployments.

---

## Update Portfolio Content

All content is in one place — `lib/data/portfolio_data.dart`:

- **Projects** — edit the `projects` list
- **Experience** — edit the `experience` object
- **Skills** — edit the `skillGroups` map
- **Roles (typewriter)** — edit the `roles` list

After editing, rebuild and redeploy using the two commands above.

---

## Git Workflow

```bash
# Stage and commit changes
git add .
git commit -m "your message"

# Push to main
git push origin main
```

Repository: **https://github.com/gitSujeet/flutter-portfolio**
