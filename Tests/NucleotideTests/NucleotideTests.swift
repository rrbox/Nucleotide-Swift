import XCTest
import Nucleotide

final class NucleotideTests: XCTestCase {
    var seq: BaseSequence<DNA>?
    override func setUp() async throws {
        
    }
    
//    文字列をプログラミング内の配列データに変換する際にかかる時間を計測
    func testStringToSeqData() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        // 1000万塩基分の文字列を変換する時間を計測します.
        self.measure {
            self.seq = .init(stringLiteral: String(repeating: "A", count: 10000000))
        }
//        計測結果
//        10万塩基: 0.008 sec
//        100万塩基: 0.052 sec
//        1000万塩基: 0.480 sec
//        1億塩基: 5.000 sec
        
//        予想
//        10億塩基: 1 min
//        30億塩基: 3 min
        
    }
}

//final class HelperTests: XCTestCase {
//    func testBitRotate() throws {
//        let target = UInt8(0b00000011)
//        XCTAssertEqual(target, bitRotateLeft(0b10000001, n: 1))
//        XCTAssertEqual(target, bitRotateLeft(0b11000000, n: 2))
//        XCTAssertEqual(target, bitRotateLeft(target, n: 8))
//    }
//    
//}
