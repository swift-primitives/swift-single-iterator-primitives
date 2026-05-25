import Testing
import Single_Iterator_Primitives

@Suite("Single Iterator Tests")
struct SingleIteratorTests {
    @Suite struct Unit {}
}

extension SingleIteratorTests.Unit {
    @Test
    func `single vends a once iterator yielding its element`() {
        let single = Single(42)
        var iterator = single.makeIterator()
        #expect(iterator.next() == 42)
        #expect(iterator.next() == nil)
    }

    @Test
    func `makeIterator borrows, so the container stays multipass`() {
        let single = Single("x")
        var first = single.makeIterator()
        var second = single.makeIterator()
        #expect(first.next() == "x")
        #expect(first.next() == nil)
        // The container was only borrowed, never consumed: a second iterator still yields.
        #expect(second.next() == "x")
        #expect(second.next() == nil)
    }
}
