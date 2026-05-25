# swift-single-iterator-primitives

The iterator-domain face of `Single` — conforms the one-element container to `Iterable`, vending
`Once` as its iterator.

This is an integration package: it declares no types of its own, only the conformance bridging
`swift-single-primitives` (`Single`, the container) to `swift-iterator-primitives` (`Iterable` and
`Once`). `Single` vends `Once` by lending a *copy* of its element to a fresh owned single-shot
iterator. The conformance requires `Element: Copyable` because `makeIterator()` only *borrows* the
container, so the element must be copied into the owned iterator; move-only / borrowing iteration
of a `Single` is a separate, collection-domain concern.

    import Single_Iterator_Primitives

    let one = Single(42)
    var iterator = one.makeIterator()
    // iterator.next() == 42, then nil

## License

Apache 2.0.
