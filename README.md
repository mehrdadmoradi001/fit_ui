# fit_ui

A powerful, intuitive, and flexible Flutter package for creating responsive and adaptive UIs that look great on any screen size.

Features
Component-Level Responsiveness: Adapts to local layout constraints, not just the screen size, making your widgets truly modular.

Declarative API: Define responsive values for padding, font sizes, and more with the clean ResponsiveValue class.

Structural Layout Widgets: Easily switch between different layouts for mobile, tablet, and desktop using ResponsiveLayout.

State Preservation: Maintain widget state across layout changes with AdaptiveIndexedStack.

Slot-Based Layouts: Build complex, adaptive UIs with a simple slot system using ResponsiveSlots.

Customizable Breakpoints: Use the default breakpoints or provide your own for full control.

Getting Started
Add fit_ui to your pubspec.yaml dependencies:yaml
dependencies:
fit_ui: ^1.0.0 # Use the latest version


Then, run `flutter pub get`.

## Usage

The core of `fit_ui` is making decisions based on available width. You can do this for values or for entire widgets.

### Responsive Values

Use `LayoutBuilder` and the `.value()` extension on `BoxConstraints` to select a value that adapts to the available width. This is perfect for things like column counts, padding, or font sizes.

```dart
import 'package:fit_ui/responsive_ui.dart';
import 'package:flutter/material.dart';

class MyResponsiveGrid extends StatelessWidget {
  const MyResponsiveGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Define a responsive value for the number of columns.
        final columnCount = constraints.value(
          const ResponsiveValue(2, tablet: 4, desktop: 6),
        );

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columnCount,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) => Container(
            color: Colors.blue,
            child: Center(child: Text('Item $index')),
          ),
        );
      },
    );
  }
}
Responsive Layouts
For larger structural changes, use the ResponsiveLayout widget to provide different widgets for mobile, tablet, and desktop sizes.

Dart

import 'package:fit_ui/responsive_ui.dart';
import 'package:flutter/material.dart';

class MyPageLayout extends StatelessWidget {
  const MyPageLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobile: MobileView(), // Your widget for mobile
      tablet: TabletView(), // Your widget for tablet
      desktop: DesktopView(), // Your widget for desktop
    );
  }
}
Contributing
Contributions are welcome! Please see the CONTRIBUTING.md file for guidelines.

License
This project is licensed under the BSD 3-Clause License - see the LICENSE file for details.

