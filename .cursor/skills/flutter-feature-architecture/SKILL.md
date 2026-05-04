---
name: flutter-feature-architecture
description: >-
  Defines Flutter feature clean architecture — folder layout under lib/<feature>/,
  flutter_bloc, get_it, json_serializable DTOs, plain domain models, repository
  pattern, and strict UI→Bloc→UseCase→Repository→DataSource flow. Use when
  designing or implementing a new feature, scaffolding feature folders, reviewing
  layer boundaries, or when the user mentions this architecture, BLoC + GetIt
  features, or clean architecture for Flutter.
disable-model-invocation: true
---

# Flutter feature architecture

When designing or implementing a **feature**, use exactly this layout under `lib/<feature>/`. Do **not** add extra files (no barrel files, helpers, or alternate folders unless the user explicitly asks).

```text
lib/
  <feature>/
    data/
      datasources/
        <feature>_remote_data_source.dart
        <feature>_local_data_source.dart
      repository/
        <feature>_repository_impl.dart
      dtos/
        <feature>_dto.dart   # json_serializable + json_annotation; mappers to domain models live here
    domain/
      repository/
        <feature>_repository.dart
      use_case/
        <one dart file per use case / piece of functionality>.dart
      model/
        <relevant models>.dart
    presentation/
      bloc/
        <feature>_bloc.dart
        <feature>_event.dart
        <feature>_state.dart
      ui/
        <feature>_screen.dart   # and/or route as needed
        widgets/
```

## Stack and layer rules

- **State:** `flutter_bloc` — UI talks only to the feature bloc (events in, states out).
- **DI:** `get_it` — register repository, data sources, use cases, bloc as appropriate.
- **DTOs:** `json_serializable` + `json_annotation`; mapping **DTO ↔ domain model** belongs with the DTO (or in that DTO file), not scattered.
- **Domain models:** Plain data holders — constructors (and fields/getters) only; **no** business logic, serialization, or framework types.
- **Repository (domain):** Abstract contract in `domain/repository/`.
- **Repository impl (data):** Implements that contract; inject and call **remote** and/or **local** data sources as the feature requires.

## Data flow (strict)

One direction for actions and results:

`presentation (UI) → Bloc → UseCase → Repository → DataSource`  
and back: `DataSource → Repository → UseCase → Bloc → UI`

Do not skip layers (e.g. UI must not call repositories or data sources directly).

## Naming

Replace `<feature>` with the feature name (e.g. `auth`, `profile`). Use the same prefix for bloc, repository, DTO, and data source file names for that feature.
