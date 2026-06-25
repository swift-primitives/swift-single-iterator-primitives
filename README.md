# Single Iterator Primitives

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

The iterator-domain face of `Single`: conforms the one-element container to `Iterable`, vending a single-shot `Once` as its iterator.

---

## Quick Start

`Single` holds exactly one element. Importing this package conforms it to `Iterable`, so the one-element container participates in iterator-generic code — it yields its element exactly once, then ends.

```swift
import Single_Iterator_Primitives

// `Single` holds exactly one element. This package adds the `Iterable` conformance.
let single = Single(42)

// Iterate it like any other Iterable — it yields its element exactly once.
single.forEach { print($0) }   // 42

// `makeIterator()` only borrows the container, so it stays multipass.
var collected: [Int] = []
single.forEach { collected.append($0) }
single.forEach { collected.append($0) }
print(collected)   // [42, 42]
```

The conformance requires `Element: Copyable`, because `makeIterator()` only *borrows* the container and must copy the element into the owned `Iterator.Once`. Move-only / borrowing iteration of a `Single` is a separate, collection-domain concern.

---

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-primitives/swift-single-iterator-primitives.git", branch: "main")
]
```

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "Single Iterator Primitives", package: "swift-single-iterator-primitives"),
    ]
)
```

---

## Architecture

One library product. It declares no types of its own — only the retroactive conformance bridging `swift-single-primitives` (the `Single` container) to `swift-iterator-primitives` (`Iterable` and `Iterator.Once`).

| Product | Target | Purpose |
|---------|--------|---------|
| `Single Iterator Primitives` | `Sources/Single Iterator Primitives/` | The retroactive `Single: Iterable` conformance and its `Iterator` typealias — `Iterator.Once` wrapped in the span-materializing adapter. |

Foundation-free.

---

## Platform Support

| Platform | Status |
|----------|--------|
| macOS 26 | Full support |
| Linux | Full support |
| Windows | Full support |
| iOS / tvOS / watchOS / visionOS | Supported |

---

## Community

<!-- BEGIN: discussion -->
<!-- Discussion thread created at publication. -->
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
