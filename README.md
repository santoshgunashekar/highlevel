# highlevel

Flutter demo app focused on a **gamification** feature: profile XP and leveling, badges, challenges, mock activity events, and a **leaderboard** (global scope, paginated). UI copy is wired through **gen-l10n** (ARB).

## Features

- **Dashboard** — level, XP to next level, streaks, badges, weekly-style challenges.
- **Simulate activity** — mock events (lesson completed, comments, posts, tasks, daily login, etc.) with optimistic updates and duplicate detection.
- **Leaderboard** — open from the app bar; loads ranked entries with XP and rank-change hints; supports “load more” when the backend reports another page.
- **Bloc observer** — `AppBlocObserver` logs bloc transitions in debug builds (`lib/app_bloc_observer.dart`, registered in `main.dart`).

## Stack

| Area | Choice |
|------|--------|
| UI / state | `flutter_bloc` |
| DI | `get_it` (`lib/init.dart`, `lib/gamification/gamification_di.dart`) |
| Local DB (gamification) | Drift (`lib/gamification/data/database/`) |
| Networking | `http` (shared client in `lib/network/`) |

## Project layout

Gamification code lives under `lib/gamification/` using a layered layout: `domain/` (models, rules, repository contracts, use cases), `data/`, and `presentation/` (blocs, screens).

## Requirements

- [Flutter](https://docs.flutter.dev/get-started/install) (Dart SDK **^3.11.5** as in `pubspec.yaml`)

## Run

```bash
flutter pub get
flutter gen-l10n   # optional; often run automatically when building
flutter run
```

## Code generation

When you change Drift tables, JSON-serializable DTOs, or similar:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Quality checks

```bash
flutter analyze
flutter test
```

## Repository

Remote layout uses `main` as the default branch. Configure `origin` to your Git host as usual (`git remote add origin …`, `git push -u origin main`).
