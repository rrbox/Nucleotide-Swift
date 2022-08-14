//
//  SequenceTests.swift
//  
//
//  Created by rrbox on 2022/08/15.
//

import XCTest
import Nucleotide

class SequenceTests: XCTestCase {
    func testPerformanceGenerateSequence() throws {
        // 1000万塩基分の文字列を変換する時間を計測します.
        self.measure {
            _ = BaseSequence<DNA>.init(stringLiteral: String(repeating: "A", count: 10000000))
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
