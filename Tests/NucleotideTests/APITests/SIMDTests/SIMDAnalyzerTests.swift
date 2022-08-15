//
//  SIMDAnalyzerTests.swift
//  
//
//  Created by rrbox on 2022/08/16.
//

import XCTest
import Nucleotide

class SIMDAnalyzerTests: XCTestCase {
    let seqLength = 100000
    var seq: BaseSequenceSIMD64<DNA>?
    override func setUp() async throws {
        self.seq = BaseSequenceSIMD64<DNA>(seq: BaseSequence<DNA>.init(
            stringLiteral:
                String(repeating: "A",
                       count: self.seqLength/2) + String(repeating: "G",
                                                         count: self.seqLength/2)))
        
    }
    
    func testComplementaryStrand() throws {
        var result: BaseSequenceSIMD64<DNA>?
        let target = BaseSequenceSIMD64<DNA>(seq: BaseSequence<DNA>.init(
            stringLiteral: String(repeating: "T",
                                  count: self.seqLength/2) + String(repeating: "C",
                                                                    count: self.seqLength/2)))
        guard let seq = self.seq else {
            return
        }
        
        self.measure {
            result = seq.complementaryStrand(typeOf: DNA.self)
        }
        
        XCTAssertEqual(result!.description, target.description)
//        計測結果
//        10万塩基: 0.011 sec
//        100万塩基: 0.076 sec
//        1000万 bp: 0.731 sec
        
//        Not SIMD
//        1000万塩基: 2.019 sec
    }

}
