# Intro
This project is demonstrating how egui can be embedded into swiftui project

# Structure
- SmoothChat - Xcode project with swiftui implementation
- smooth-ui - Rust package with egui implementation
- smooth-ui/SmoothUI - SPM package with compiled egui implementation as XCFramework

# Build instructions
In order to build the project you need to build XCFramework for egui first 

```Bash
cd smooth-ui
sh scripts/build_debug.sh
```

After that you can open the project from SmoothChat folder in Xcode and run

# Dependencies
- swift-bridge - For communication between swift and rust code bases
- egui - The UI implementation in rust
- wgpu - The graphics library for rendering egui in a metal view
- font-kit - For dynamically loading system fonts
