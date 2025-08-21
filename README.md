# fit_ui

[![pub package](https://img.shields.io/pub/v/fit_ui.svg)](https://pub.dev/packages/fit_ui)
[![likes](https://img.shields.io/pub/likes/fit_ui)](https://pub.dev/packages/fit_ui/score)
[![points](https://img.shields.io/pub/points/fit_ui)](https://pub.dev/packages/fit_ui/score)

A **powerful, intuitive, and flexible Flutter package** for creating responsive and adaptive UIs that look great on any screen size.

---

## ✨ Features

- 📏 **Component-Level Responsiveness** – adapts to local layout constraints, not just the screen size.
- 🧩 **Declarative API** – define responsive values for padding, font sizes, and more with `ResponsiveValue`.
- 🖼 **Structural Layout Widgets** – easily switch between different layouts for mobile, tablet, and desktop using `ResponsiveLayout`.
- 🔄 **State Preservation** – maintain widget state across layout changes with `AdaptiveIndexedStack`.
- 🎛 **Slot-Based Layouts** – build complex, adaptive UIs with a simple slot system using `ResponsiveSlots`.
- ⚙️ **Customizable Breakpoints** – use the defaults or provide your own for full control.

---

## 🚀 Getting Started

Add `fit_ui` to your `pubspec.yaml` dependencies:

```yaml
dependencies:
  fit_ui: ^1.0.0 # Use the latest version
```
Then, run:
```yaml
flutter pub get
```

## 📖 Usage

### 🔹 Responsive Values
Use `ResponsiveValue` with `LayoutBuilder` or the `BoxConstraints` extension to resolve values based on constraints.

```dart
import 'package:fit_ui/fit_ui.dart';
import 'package:flutter/material.dart';

class MyResponsiveGrid extends StatelessWidget {
  const MyResponsiveGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columnCount = constraints.value(
          const ResponsiveValue(2, tablet: 4, desktop: 6),
        );
        final padding = constraints.value(
          const ResponsiveValue(16.0, tablet: 24.0, desktop: 32.0),
        );

        return Padding(
          padding: EdgeInsets.all(padding),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columnCount,
            ),
            itemBuilder: (context, index) => Container(
              color: Colors.blue,
              child: Center(child: Text('Item $index')),
            ),
          ),
        );
      },
    );
  }
}

```

### 🔹 Responsive Layouts
Use `ResponsiveLayout` for structural changes across screen types.

```dart
import 'package:fit_ui/fit_ui.dart';
import 'package:flutter/material.dart';

class MyPageLayout extends StatelessWidget {
  const MyPageLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobile: MobileView(),
      tablet: TabletView(),
      desktop: DesktopView(),
    );
  }
}

```

### 🔹 Custom Breakpoints
Implement your own `BreakpointProvider` for custom breakpoints.

```dart
class MyBreakpoints implements BreakpointProvider {
  @override
  DeviceScreenType getScreenType(double width) {
    if (width > 1200) return DeviceScreenType.desktop;
    if (width > 600) return DeviceScreenType.tablet;
    return DeviceScreenType.mobile;
  }
}

// Usage
import 'package:fit_ui/fit_ui.dart';
import 'package:flutter/material.dart';

// Assuming MobileView, TabletView, DesktopView, and MyBreakpoints are defined elsewhere

class MyCustomResponsivePage extends StatelessWidget {
  const MyCustomResponsivePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Correct usage:
    return ResponsiveLayout.custom(
      mobile: MobileView(),
      tablet: TabletView(),
      desktop: DesktopView(),
      provider: MyBreakpoints(),
    );
  }
}

```

### 🔹 ResponsiveLayoutBuilder
For maximum flexibility, use `ResponsiveLayoutBuilder` to get the screen type and constraints.

```dart
import 'package:fit_ui/fit_ui.dart';
import 'package:flutter/material.dart';

// Assuming MyCustomLayout is defined elsewhere
class MyResponsivePageWithBuilder extends StatelessWidget {
  const MyResponsivePageWithBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder( // It's returned by the build method
      builder: (screenType, constraints) {
        // Build your UI based on screenType and constraints
        return MyCustomLayout(screenType: screenType /*, constraints: constraints */); // You might want to pass constraints too
      },
    );
  }
}


```

## 

### 🧪 Testing
The package is thoroughly tested. Run tests with:

```bash
flutter test
```

##

### 🤝 Contributing
Contributions are welcome! Please read our [Contributing Guidelines](CONTRIBUTING.md) for details.

##

### 📜 License
This project is licensed under the BSD 3-Clause License - see the [LICENSE](LICENSE) file for details.

##

### 🔗 Links
- [API Documentation](https://pub.dev/documentation/fit_ui/latest/)
- [Example App](https://github.com/mehrdadmoradi001/fit_ui/tree/main/example)


---