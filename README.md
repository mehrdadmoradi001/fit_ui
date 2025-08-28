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

<div style="text-align: center">
    <table>
        <tr>
            <td style="text-align: center">
                <a href="https://github.com/mehrdadmoradi001/fit_ui/blob/main/example/lib/examples/ecommerce/product_page.dart">
                    <img src="https://raw.githubusercontent.com/mehrdadmoradi001/fit_ui/main/assets/ecammercegif.gif" alt="responsive example"/>
                </a>
            </td>            
        </tr>
    </table>
</div>
<br>

## 🚀 Getting Started

###  🛠 Installation

Add `fit_ui` to your `pubspec.yaml` dependencies:

```bash
dependencies:
  fit_ui: ^1.0.4 # Use the latest version
```
Then, run the following command in your terminal:
```yaml
flutter pub get
```
Now you can import the package in your Dart code:
```dart
import 'package:fit_ui/fit_ui.dart';

```
<br>

##  📖 API Quick Refrence

Here's a quick overview of the core components in `fit_ui` - designed for **component-level responsive UIs**.

## Core Concepts

| Concept                | Description                                                                       | Default Values               |
|------------------------|-----------------------------------------------------------------------------------|------------------------------|
| **AppBreakpoints**     | Defines the width thresholds for switching between screen types                   | `mobile: 600`, `tablet: 950` |
| **DeviceScreenType**   | An enum representing the current screen type: `.mobile`, `.tablet`, or `.desktop` | -                            |
| **BreakpointProvider** | An interface to provide your own custom breakpoint logic                          | `DefaultBreakpointProvider`  |

## Main Widgets

| Widget                      | Purpose                                                                                                          |
|-----------------------------|------------------------------------------------------------------------------------------------------------------|
| **ResponsiveLayout**        | Selects a layout based on available screen width. Uses LayoutBuilder internally for local constraints awareness. |
| **ResponsiveLayoutBuilder** | Provides both `DeviceScreenType` and `BoxConstraints` to builder function for highly custom layouts.             |
| **ResponsiveSlots**         | A slot-based system (header, body, side) that automatically rearranges content based on screen size.             |
| **AdaptiveIndexedStack**    | Maintains state of multiple screen variants and switches between them based on screen type.                      |

## Core Classes & Extensions

| API                           | Description                                                                      |
|-------------------------------|----------------------------------------------------------------------------------|
| **ResponsiveValue\<T>**       | Holds different values for each screen type with intelligent fallback mechanism. |
| **BoxConstraints.value()**    | Extension method to resolve ResponsiveValue based on local constraints.          |
| **BoxConstraints.screenType** | Extension property to get DeviceScreenType from constraints.                     |
<br>

## Key Extension Methods
```dart
// Get screen type from constraints
final screenType = constraints.screenType;

// Resolve responsive values
final padding = constraints.value(ResponsiveValue(16.0, tablet: 24.0));
final columns = constraints.value(ResponsiveValue(2, tablet: 4, desktop: 6));

// Use custom breakpoint provider
final customScreenType = constraints.screenTypeUsing(MyCustomBreakpoints());

```
<br>

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

### 🔹 Slot-Based Layouts
For more complex UIs, `ResponsiveSlots` provides a structured way to rearrange content. The layout automatically adapts, moving the side content in a `Row` on desktop and a `Column` on smaller screens

```dart
import 'package:fit_ui/responsive_ui.dart';
import 'package:flutter/material.dart';

class MyDashboard extends StatelessWidget {
  const MyDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveSlots(
        // You can easily customize the spacing for different layouts!
        desktopSideSpacing: 24.0,
        tabletSideSpacing: 16.0,
        header: (screenType) => Container(
          height: 60,
          color: Colors.blueGrey,
          child: const Center(child: Text('Header')),
        ),
        body: (screenType) => Container(
          color: Colors.white,
          child: const Center(child: Text('Main Body Content')),
        ),
        side: (screenType) => Container(
          color: Colors.grey.shade200,
          child: const Center(child: Text('Side Panel')),
        ),
      ),
    );
  }
}

```

### 🔹 Complex Example: Responsive Product Page

Here's a more complex example showing how to use `fit_ui` in a real-world scenario:

```dart
import 'package:flutter/material.dart';
import 'package:fit_ui/fit_ui.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: ResponsiveLayoutBuilder(
        builder: (screenType, constraints) {
          final padding = constraints.value(
            const ResponsiveValue(16.0, tablet: 24.0, desktop: 32.0),
          );
          final imageSize = constraints.value(
            const ResponsiveValue(150.0, tablet: 200.0, desktop: 250.0),
          );

          return Padding(
            padding: EdgeInsets.all(padding),
            child: screenType == DeviceScreenType.desktop
                ? _buildDesktopLayout(imageSize)
                : _buildMobileTabletLayout(imageSize),
          );
        },
      ),
    );
  }

  Widget _buildDesktopLayout(double imageSize) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Image.asset('assets/product.jpg', width: imageSize, height: imageSize),
        ),
        const SizedBox(width: 24),
        Expanded(
          flex: 3,
          child: _buildProductDetails(),
        ),
      ],
    );
  }

  Widget _buildMobileTabletLayout(double imageSize) {
    return Column(
      children: [
        Image.asset('assets/product.jpg', width: imageSize, height: imageSize),
        const SizedBox(height: 16),
        _buildProductDetails(),
      ],
    );
  }

  Widget _buildProductDetails() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Product Name', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('Product description goes here...'),
        SizedBox(height: 16),
        Text('\$99.99', style: TextStyle(fontSize: 20, color: Colors.green)),
        SizedBox(height: 16),
        ElevatedButton(onPressed: null, child: Text('Add to Cart')),
      ],
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

### 🏛️ Architectural Philosophy
`fit_ui` is built on a simple yet powerful principle: component-level responsiveness.

Instead of making decisions based on the global screen size, every widget adapts to the local constraints provided by its parent. This ensures that your components are truly modular, reusable, and predictable, no matter where you place them in the widget tree.

This approach is achieved by leveraging Flutter's built-in `LayoutBuilder` and providing a clean, declarative API around it.

For a deeper dive into the code structure and design principles, please see our [Architecture Guide](ARCHITECTURE.md).

##

### 🤝 Contributing

We welcome contributions! Please feel free to:

- 🐛 Report bugs by [creating an issue](https://github.com/mehrdadmoradi001/fit_ui/issues/new)
- 💡 Suggest new features by [opening a discussion](https://github.com/mehrdadmoradi001/fit_ui/discussions)
- 🔧 Submit pull requests for bug fixes or new features

Before contributing, please read our [Contributing Guidelines](CONTRIBUTING.md).

##

### 📜 License
This project is licensed under the BSD 3-Clause License - see the [LICENSE](LICENSE) file for details.

##

### ❓ FAQ

### Q: Why should I use fit_ui instead of other responsive packages?
A: fit_ui focuses on component-level responsiveness using constraints rather than screen size, making your components truly reusable in any context.

### Q: Can I use custom breakpoints?
A: Yes! Simply implement the `BreakpointProvider` interface and pass it to any responsive widget.

### Q: Does this work with existing state management solutions?
A: Absolutely! fit_ui works seamlessly with all state management approaches (Provider, Bloc, Riverpod, etc.).

##

### 💬 Support

If you have any questions or need help:
- Check the [API documentation](https://pub.dev/documentation/fit_ui/latest/)
- Look at the [example app](https://github.com/mehrdadmoradi001/fit_ui/tree/main/example)
- [Open an issue](https://github.com/mehrdadmoradi001/fit_ui/issues) for bugs or feature requests

##

### 🧑‍💻 Maintainers

- [MehrdadMoradiNazif](https://github.com/mehrdadmoradi001)

##

### ⭐ Star History

If you find this package useful, please consider giving it a star on GitHub!

[![Star History Chart](https://api.star-history.com/svg?repos=mehrdadmoradi001/fit_ui&type=Date)](https://star-history.com/#mehrdadmoradi001/fit_ui&Date)

##

### 🔗 Links
- [API Documentation](https://pub.dev/documentation/fit_ui/latest/)
- [Example App](https://github.com/mehrdadmoradi001/fit_ui/tree/main/example)


---