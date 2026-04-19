# 🏗️ Design Kit (`design_kit`)

![Flutter](https://img.shields.io/badge/Flutter-%E2%9D%A4-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?logo=dart)
![Coverage](https://img.shields.io/badge/Coverage-100%25-brightgreen)

A highly scalable, testable, and theme-agnostic Design System package built for Flutter. 

The `design_kit` is not a monolithic UI library; it is a smart wrapper around **Material 3**. It uses the **Adapter Pattern** and **Inversion of Control** to provide a consistent API for components while allowing the consuming application to dictate 100% of the visual identity (Colors, Typography, Spacing, and Radii).

## ✨ Core Philosophy

1. **Material 3 Foundation:** We don't reinvent the wheel. We wrap M3 widgets to get accessibility, keyboard navigation, and native animations.
2. **Inversion of Control:** The kit hardcodes **zero** colors or fonts. The consuming app injects a full `ColorScheme` and `TextTheme` via the `DkTheme` factory.
3. **i18n Ready (No Hardcoded Strings):** Components are completely agnostic to language. All text labels, hints, and error messages must be provided by the consumer.
4. **Theme Extensions:** We use robust `ThemeExtension` classes (`DkSemanticColors`, `DkSpacing`, `DkRadii`) to handle design tokens that Material 3 doesn't support natively.

---

## 📦 Installation
Choose the method that best fits your project structure:

### Option 1: Git Repository (Remote Usage)
Use this method to share the Design Kit across different apps and repositories. If the package is located inside a subfolder of your repository, you must specify the path.

```yaml
dependencies:
  design_kit:
    git:
      url: https://github.com/YOUR_USERNAME/YOUR_REPOSITORY.git
      ref: main # Branch, tag, or commit hash
      path: packages/design_kit # Path to the package inside the repo
Option 2: Local Path (Monorepo Usage)
Ideal for development within the same workspace to ensure instant updates.

```yaml
dependencies:
  design_kit:
    path: ../../packages/design_kit
```

Then, run the following command in your terminal:

```bash
flutter pub get