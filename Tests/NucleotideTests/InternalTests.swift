import XCTest
@testable import Nucleotide

final class HelperTests: XCTestCase {
    func testBitRotate() throws {
        let target = UInt8(0b00000011)
        XCTAssertEqual(target, bitRotateLeft(0b10000001, n: 1))
        XCTAssertEqual(target, bitRotateLeft(0b11000000, n: 2))
        XCTAssertEqual(target, bitRotateLeft(target, n: 8))
    }
    
}

final class SIMD64SequenceTests: XCTestCase {
    func testPerformanceGenerateSIMD64Seq() throws {
        let seq = BaseSequence<DNA>.init(stringLiteral: String(repeating: "A", count: 1000000))
        self.measure {
            _ = BaseSequenceSIMD64<DNA>(sequence: seq.sequence)
        }
//        結果
//        10万 bp: 0.065 sec
//        1000万 bp: 0.497 sec
//        4000万 bp: 1.988 sec
        
        print()
        print(BaseSequenceSIMD64<DNA>(sequence: BaseSequence<DNA>.init(stringLiteral: String(repeating: "ATGG", count: 65)).sequence))
        print()
        print(BaseSequence<DNA>.init(stringLiteral: String(repeating: "ATGG", count: 65)))
        print()
    }
    
    func testPerformanceDescription() throws {
        let seq = BaseSequence<DNA>.init(stringLiteral: String(repeating: "A", count: 1000000))
        let simdSeq = BaseSequenceSIMD64<DNA>(sequence: seq.sequence)
        self.measure {
            _ = simdSeq.description
        }
//        1000万 pb: 0.376 sec
    }
}
