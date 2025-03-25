cargo build --release

swift-bridge-cli create-package \
  --bridges-dir ./generated \
  --out-dir SmoothUI \
  --macos target/release/libembed.a \
  --name SmoothUI