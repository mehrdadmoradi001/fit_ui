# Architecture of `fit_ui`

This document provides a deep dive into the architecture, code structure, and design principles behind the fit_ui package.

Key Principles
Our architecture is guided by the following principles:

Local Responsiveness over Global: Widgets should be self-contained and react to their own available space (BoxConstraints), not the global MediaQuery. This makes them highly reusable and testable.

Declarative and Intuitive API: The API should be easy to read and use. ResponsiveValue is a prime example, allowing developers to define responsive values in a single line.

Extensibility: The core logic is built around the BreakpointProvider abstraction, allowing users to easily inject their own custom breakpoint logic without modifying the package.

Zero Dependencies: The package relies only on the core Flutter SDK to remain lightweight and avoid dependency conflicts.

File Structure
The lib directory is organized to separate the public API from the internal implementation details.


## 📁 Project Structure

```

fit_ui/

├── lib/

│   ├── src/

│   │   ├── extensions/

│   │   │   └── box_constraints_ext.dart

│   │   ├── breakpoints.dart

│   │   ├── device_screen_type.dart

│   │   ├── responsive_value.dart

│   │   ├── responsive_layout.dart

│   │   ├── responsive_layout_builder.dart

│   │   ├── adaptive_indexed_stack.dart

│   │   └── responsive_slots.dart

│   └── fit_ui.dart

├── test/

│   ├── responsive_value_test.dart

│   ├── responsive_layout_test.dart

│   ├── responsive_layout_builder_test.dart

│   ├── adaptive_indexed_stack_test.dart

│   ├── responsive_slots_test.dart

│   └── box_constraints_ext_test.dart

├── example/
|   |-- lib
|   |   |-- examples
|   |   |   '-- ecommerce
|   |   |       |-- product_model.dart
|   |   |       '-- product_page.dart
|   |   '-- main.dart
|   |-- pubspec.yaml
|   '-- web
|       |-- favicon.png
|       |-- icons
|       |-- index.html
|       |-- analysis_options.yaml
|       '-- manifest.json 

├── ARCHITECTURE.md

├── CHANGELOG.md

├── CONTRIBUTING.md

├── LICENSE

├── pubspec.yaml

└── README.md

```


## Logic and Data Flow

The core logic of the package revolves around a simple flow:

1.  A responsive widget (like `ResponsiveLayout` or `ResponsiveLayoutBuilder`) uses a `LayoutBuilder` to get the current `BoxConstraints`.
2.  The `maxWidth` from the `BoxConstraints` is passed to a `BreakpointProvider` (either the default or a custom one).
3.  The `BreakpointProvider` returns a `DeviceScreenType` enum (`.mobile`, `.tablet`, or `.desktop`).
4.  This `DeviceScreenType` is then used to:
    -   Select the correct widget in `ResponsiveLayout`.
    -   Resolve the correct value from a `ResponsiveValue` object.
    -   Be passed to the builder function in `ResponsiveLayoutBuilder`.

This clean and predictable flow ensures that all responsive logic is consistent across the entire package.