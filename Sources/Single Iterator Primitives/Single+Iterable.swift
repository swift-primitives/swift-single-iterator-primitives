//
//  Single+Iterable.swift
//  swift-single-iterator-primitives
//

// `Single` vends `Once` as its iterator: the container lends a *copy* of its element to a fresh
// owned single-shot iterator. This is the container's owned-iteration face, available only when
// `Element: Copyable` — `makeIterator()` only *borrows* the container, so the element must be
// copied into the owned `Once`. A move-only element cannot be reached out of a borrow, so the
// move-only / borrowing iteration of a `Single` is a separate (collection-domain) concern.
//
// `@_lifetime(borrow self)` satisfies `Iterable.makeIterator()`'s contract: `Once` is ~Escapable,
// so the vended iterator's lifetime is tied to the container — it borrows `self` and may not
// outlive it. (`copy self` is rejected here because `Single<Element>` is `Escapable` when `Element`
// is.) `@retroactive`: this bridge owns neither `Single` (single-primitives) nor `Iterable`
// (iterator-primitives), so the cross-package conformance is retroactive by definition.
extension Single: @retroactive Iterable where Element: Copyable {
    @inlinable
    @_lifetime(borrow self)
    public borrowing func makeIterator() -> Once<Element> {
        Once(element)
    }
}
