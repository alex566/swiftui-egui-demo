# Intro
This project is demonstrating how egui can be embedded into swiftui project. An article can be found [here](https://medium.com/@djalex566/fast-fluid-integrating-rust-egui-into-swiftui-30a218c502c1)

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

# Real projects showcase
- [DataScout](https://apps.apple.com/us/app/datascout-for-sqlite-swiftdata/id6737813684) - Embedded databases debugging tool for macOS
