public import Iterator_Chunk_Primitives

extension Single: @retroactive Iterable where Element: Copyable {

    public typealias Iterator = Iterator_Primitive.Iterator.Materializing<
        Iterator_Primitive.Iterator.Once<Element>
    >

    @inlinable
    @_lifetime(borrow self)
    public borrowing func makeIterator()
        -> Iterator_Primitive.Iterator.Materializing<Iterator_Primitive.Iterator.Once<Element>>
    {
        Iterator_Primitive.Iterator.Materializing(Iterator_Primitive.Iterator.Once(element))
    }
}
