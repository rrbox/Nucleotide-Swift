import XCTest
@testable import Nucleotide

final class HelperTests: XCTestCase {
    func testBitRotate() throws {
        let target = UInt8(0b00000011)
        XCTAssertEqual(target, bitRotateLeft(0b10000001, n: 1))
        XCTAssertEqual(target, bitRotateLeft(0b11000000, n: 2))
        XCTAssertEqual(target, bitRotateLeft(target, n: 8))
    }
    
    func testSIMDBitRotate() throws {
        let target = SIMD64(repeating: UInt8(0b00000011))
        XCTAssertEqual(target, bitRotateLeft(SIMD64(repeating: 0b10000001), n: 1))
        XCTAssertEqual(target, bitRotateLeft(SIMD64(repeating: 0b11000000), n: 2))
        XCTAssertEqual(target, bitRotateLeft(target, n: 8))
        print(target)
    }
    
}
