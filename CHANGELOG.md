## [0.0.1] - Initial Release

### Added
- 🏗️ **Core Architecture:** Initial scaffolding of the `design_kit` package using the Adapter Pattern over Material 3.
- 🎨 **Theming Engine:** Introduced `DkTheme` and `DkTypography` factories for full Inversion of Control, allowing consuming apps to inject their own `ColorScheme` and `TextTheme`.
- 🧩 **Design Tokens:** Implemented `ThemeExtension` classes for scalable UI properties:
  - `DkSemanticColors` (Success, Warning, Info).
  - `DkSpacing` (xs, sm, md, lg, xl, xxl).
  - `DkRadii` (sm, md, lg, pill).
- 🧱 **Components:** - `DkButton`: Added `.filled()`, `.text()`, and `.outlined()` variants with built-in `isLoading` state management.
  - `DkTextField`: Base input wrapper mapped to global theme radii and colors.
- 🌍 **i18n Ready:** Enforced architecture with zero hardcoded strings.
- 🧪 **Testing:** 100% initial widget test coverage for components and theme extensions.