//
//  File.swift
//  
//
//  Created by rrbox on 2022/08/14.
//

import XCTest
import Nucleotide

final class AnalyzeTests: XCTestCase {
    func testTotalContent() throws {
        let count = 10000000
        let seq = BaseSequence<DNA>.init(stringLiteral: String(repeating: "A", count: count/2)+String(repeating: "G", count: count/2))
        var result = 0
        self.measure {
            result = seq.contentTotal([.s])
        }
        print(result)
//        計測結果
//        10万塩基: 0.011 sec
//        100万塩基: 0.110 sec
//        1000万塩基: 1.065 sec
//        予想
//        1億塩基: 10 sec
//        10億塩基: 100 sec
    }
    
}
