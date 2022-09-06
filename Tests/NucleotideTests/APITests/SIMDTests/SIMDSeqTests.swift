//
//  SIMDSeqTests.swift
//  
//
//  Created by rrbox on 2022/08/16.
//

import XCTest
import Nucleotide

final class SIMD64SequenceTests: XCTestCase {
    func testPerformanceGenerateSIMD64Seq() throws {
        let seq = BaseSequence<DNA>.init(stringLiteral: String(repeating: "A", count: 100000))
        self.measure {
            _ = BaseSequenceSIMD64<DNA>(seq: seq)
        }
//        結果
//        10万 bp: 0.053 sec
//        100万 bp: 0.497 sec
//        1000万 bp: 4.968 sec
        
        print()
        print(BaseSequenceSIMD64<DNA>(seq: BaseSequence<DNA>.init(stringLiteral: String(repeating: "ATGG", count: 65))))
        print()
        print(BaseSequence<DNA>.init(stringLiteral: String(repeating: "ATGG", count: 65)))
        print()
    }
    
    func testPerformanceDescription() throws {
        let seq = BaseSequence<DNA>.init(stringLiteral: String(repeating: "A", count: 1000000))
        let simdSeq = BaseSequenceSIMD64<DNA>(seq: seq)
        self.measure {
            _ = simdSeq.description
        }
//        100万 bp: 0.376 sec
//        1000万 bp: 3.804 sec
    }
}
