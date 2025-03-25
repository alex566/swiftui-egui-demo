cargo build

swift-bridge-cli create-package \
  --bridges-dir ./generated \
  --out-dir SmoothUI \
  --macos target/debug/libembed.a \
  --name SmoothUI