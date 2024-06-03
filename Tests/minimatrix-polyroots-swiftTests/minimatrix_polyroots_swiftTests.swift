import XCTest
@testable import minimatrix_polyroots_swift

final class minimatrix_polyroots_swiftTests: XCTestCase {
    func test1() throws {
        let roots = getCubicRoots(A: 1, B: -6, C: 11, D: -6)
                        .sorted(by: { $0.real < $1.real })
        XCTAssertEqual(roots.count, 3)
        XCTAssertEqual(roots[0].real, 1.0, accuracy: 1e-15)
        XCTAssertEqual(roots[0].imag, 0, accuracy: 1e-15)
        XCTAssertEqual(roots[1].real, 2.0, accuracy: 1e-15)
        XCTAssertEqual(roots[1].imag, 0, accuracy: 1e-15)
        XCTAssertEqual(roots[2].real, 3.0, accuracy: 1e-15)
        XCTAssertEqual(roots[2].imag, 0, accuracy: 1e-15)
    }
    func test2() throws {
        let roots = getCubicRoots(A: 1, B: 0, C: 0, D: 1)
                        .sorted(by: { $0.real < $1.real || ( $0.real == $1.real && $0.imag < $1.imag) })
        XCTAssertEqual(roots.count, 3)
        XCTAssertEqual(roots[0].real, -1, accuracy: 1e-15)
        XCTAssertEqual(roots[0].imag, 0, accuracy: 1e-15)
        XCTAssertEqual(roots[1].real, 0.5, accuracy: 1e-15)
        XCTAssertEqual(roots[1].imag, -sqrt(0.75), accuracy: 1e-15)
        XCTAssertEqual(roots[2].real, 0.5, accuracy: 1e-15)
        XCTAssertEqual(roots[2].imag, sqrt(0.75), accuracy: 1e-15)
    }
    func test3() throws {
        let roots = getCubicRoots(A: 1, B: 0, C: 0, D: -1)
                        .sorted(by: { $0.real < $1.real || ( $0.real == $1.real && $0.imag < $1.imag) })
        XCTAssertEqual(roots.count, 3)
        XCTAssertEqual(roots[0].real, -0.5, accuracy: 1e-15)
        XCTAssertEqual(roots[0].imag, -sqrt(0.75), accuracy: 1e-15)
        XCTAssertEqual(roots[1].real, -0.5, accuracy: 1e-15)
        XCTAssertEqual(roots[1].imag, sqrt(0.75), accuracy: 1e-15)
        XCTAssertEqual(roots[2].real, 1, accuracy: 1e-15)
        XCTAssertEqual(roots[2].imag, 0, accuracy: 1e-15)
    }
    func test4() throws {
        let roots = getCubicRoots(A: 0, B: 1, C: 3, D: 2)
                        .sorted(by: { $0.real < $1.real || ( $0.real == $1.real && $0.imag < $1.imag) })
        XCTAssertEqual(roots.count, 2)
        XCTAssertEqual(roots[0].real, -2, accuracy: 1e-15)
        XCTAssertEqual(roots[0].imag, 0, accuracy: 1e-15)
        XCTAssertEqual(roots[1].real, -1, accuracy: 1e-15)
        XCTAssertEqual(roots[1].imag, 0, accuracy: 1e-15)
    }
    func test5() throws {
        let roots = getCubicRoots(A: 1, B: -3, C: 2, D: 0)
                        .sorted(by: { $0.real < $1.real || ( $0.real == $1.real && $0.imag < $1.imag) })
        XCTAssertEqual(roots.count, 3)
        XCTAssertEqual(roots[0].real, 0, accuracy: 1e-15)
        XCTAssertEqual(roots[0].imag, 0, accuracy: 1e-15)
        XCTAssertEqual(roots[1].real, 1, accuracy: 1e-15)
        XCTAssertEqual(roots[1].imag, 0, accuracy: 1e-15)
        XCTAssertEqual(roots[2].real, 2, accuracy: 1e-15)
        XCTAssertEqual(roots[2].imag, 0, accuracy: 1e-15)
    }
    func test6() throws {
        let roots = getCubicRoots(A: 1, B: 3, C: 3, D: 1)
                        .sorted(by: { $0.real < $1.real || ( $0.real == $1.real && $0.imag < $1.imag) })
        XCTAssertEqual(roots.count, 3)
        XCTAssertEqual(roots[0].real, -1, accuracy: 1e-15)
        XCTAssertEqual(roots[0].imag, 0, accuracy: 1e-15)
        XCTAssertEqual(roots[1].real, -1, accuracy: 1e-15)
        XCTAssertEqual(roots[1].imag, 0, accuracy: 1e-15)
        XCTAssertEqual(roots[2].real, -1, accuracy: 1e-15)
        XCTAssertEqual(roots[2].imag, 0, accuracy: 1e-15)
    }
    func test7() throws {
        let roots = getCubicRoots(A: 1, B: -30, C: 299, D: -1980)
                        .sorted(by: { $0.real < $1.real || ( $0.real == $1.real && $0.imag < $1.imag) })
        XCTAssertEqual(roots.count, 3)
        XCTAssertEqual(roots[0].real, 5, accuracy: 1e-15)
        XCTAssertEqual(roots[0].imag, -sqrt(74), accuracy: 1e-15)
        XCTAssertEqual(roots[1].real, 5, accuracy: 1e-15)
        XCTAssertEqual(roots[1].imag, sqrt(74), accuracy: 1e-15)
        XCTAssertEqual(roots[2].real, 20, accuracy: 1e-15)
        XCTAssertEqual(roots[2].imag, 0, accuracy: 1e-15)
    }
    func testQuartic1() throws {
        let roots = getQuarticRoots(A: 1, B: -4, C: -1, D: 10, E: 0)
            .sorted(by: {$0.real < $1.real || ($0.real == $1.real && $0.imag < $1.imag)})
        XCTAssertEqual(roots.count, 4)
        
        XCTAssertEqual(roots[0].real, 1 - sqrt(6), accuracy: 1e-15)
        XCTAssertEqual(roots[0].imag, 0, accuracy: 1e-15)
        XCTAssertEqual(roots[1].real, 0, accuracy: 1e-15)
        XCTAssertEqual(roots[1].imag, 0, accuracy: 1e-15)
        XCTAssertEqual(roots[2].real, 2, accuracy: 1e-15)
        XCTAssertEqual(roots[2].imag, 0, accuracy: 1e-15)
        XCTAssertEqual(roots[3].real, 1 + sqrt(6), accuracy: 1e-15)
        XCTAssertEqual(roots[3].imag, 0, accuracy: 1e-15)
    }
    func testQuartic2() throws {
        let roots = getQuarticRoots(A: 3, B: 6, C: -123, D: -126, E: 1080)
            .sorted(by: {$0.real < $1.real || ($0.real == $1.real && $0.imag < $1.imag)})
        XCTAssertEqual(roots.count, 4)
        
        XCTAssertEqual(roots[0].real, -6, accuracy: 1e-15)
        XCTAssertEqual(roots[0].imag, 0, accuracy: 1e-15)
        XCTAssertEqual(roots[1].real, -4, accuracy: 1e-15)
        XCTAssertEqual(roots[1].imag, 0, accuracy: 1e-15)
        XCTAssertEqual(roots[2].real, 3, accuracy: 1e-15)
        XCTAssertEqual(roots[2].imag, 0, accuracy: 1e-15)
        XCTAssertEqual(roots[3].real, 5, accuracy: 1e-15)
        XCTAssertEqual(roots[3].imag, 0, accuracy: 1e-15)
    }
    
    func testQuartic3() throws {
        let roots = getQuarticRoots(A: -20, B: 5, C: 17, D: -29, E: 87)
            .sorted(by: {$0.real < $1.real || ($0.real == $1.real && $0.imag < $1.imag)})
        XCTAssertEqual(roots.count, 4)
        
        XCTAssertEqual(roots[0].real, -1.6820039265853493, accuracy: 1e-15)
        XCTAssertEqual(roots[0].imag, 0, accuracy: 1e-15)
        XCTAssertEqual(roots[1].real, 0.22221040812421872, accuracy: 1e-15)
        XCTAssertEqual(roots[1].imag, -1.2996721990882234, accuracy: 1e-15)
        XCTAssertEqual(roots[2].real, 0.22221040812421872, accuracy: 1e-15)
        XCTAssertEqual(roots[2].imag, 1.2996721990882234, accuracy: 1e-15)
        XCTAssertEqual(roots[3].real, 1.487583110336912, accuracy: 1e-15)
        XCTAssertEqual(roots[3].imag, 0, accuracy: 1e-15)
    }
}
