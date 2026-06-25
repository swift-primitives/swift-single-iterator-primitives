//
//  Single+Iterable.swift
//  swift-single-iterator-primitives
//

public import Iterator_Chunk_Primitives

// `Single` vends `Iterator.Once` as its iterator: the container lends a *copy* of its element to a
// fresh owned single-shot iterator. This is the container's owned-iteration face, available only
// when `Element: Copyable` — `makeIterator()` only *borrows* the container, so the element must be
// copied into the owned `Iterator.Once`. A move-only element cannot be reached out of a borrow, so
// the move-only / borrowing iteration of a `Single` is a separate (collection-domain) concern.
//
// `@_lifetime(borrow self)` satisfies `Iterable.makeIterator()`'s contract: `Iterator.Once` is
// ~Escapable, so the vended iterator's lifetime is tied to the container — it borrows `self` and
// may not outlive it. (`copy self` is rejected here because `Single<Element>` is `Escapable` when
// `Element` is.) `@retroactive`: this bridge owns neither `Single` (single-primitives) nor
// `Iterable` (iterator-primitives), so the cross-package conformance is retroactive by definition.
extension Single: @retroactive Iterable where Element: Copyable {
    // Span-primitive (SE-0516): the scalar `Iterator.Once` is wrapped in the generator
    // materialize adapter so `Iterable.Iterator` is a `__IteratorChunkProtocol`. `Single` is
    // Iterable-only (no Swift.Sequence/Sequenceable here), so no @_implements split is needed.
    /// The iterator `Single` vends: a single-shot `Iterator.Once` wrapped in the span-materializing adapter.
    public typealias Iterator = Iterator_Primitive.Iterator.Materializing<Iterator_Primitive.Iterator.Once<Element>>

    /// Returns a single-shot iterator that yields a copy of the contained element exactly once.
    @inlinable
    @_lifetime(borrow self)
    public borrowing func makeIterator() -> Iterator_Primitive.Iterator.Materializing<Iterator_Primitive.Iterator.Once<Element>> {
        Iterator_Primitive.Iterator.Materializing(Iterator_Primitive.Iterator.Once(element))
    }
}
