//
//  File.swift
//  
//
//  Created by rrbox on 2022/08/14.
//

import XCTest
import Nucleotide

final class AnalyzeTests: XCTestCase {
    // N を含まない配列での塩基含有量計算テスト. 実行時間も計測.
    func testTotalContentNotContainNSeq() throws {
        let total = 1000000
        let seq = BaseSequence<DNA>.init(
            stringLiteral:
                String(repeating: "A",
                       count: total/2) + String(repeating: "G",
                                                count: total/2))
        var result = 0
        self.measure {
            result = seq.contentTotal([.s], containN: true)
        }
        XCTAssertEqual(total/2, result)
//        計測結果
//        10万塩基: 0.011 sec
//        100万塩基: 0.110 sec
//        1000万塩基: 1.065 sec
//        予想
//        1億塩基: 10 sec
//        10億塩基: 100 sec
    }
    
    // N を含む配列での塩基含有量計算テスト. 実行時間は計測しない.
    func testTotalContentContainNSeq() throws {
        let total = 100
        let seq = BaseSequence<DNA>.init(
            stringLiteral:
                String(repeating: "A", count: total/4)
            + String(repeating: "G", count: total/4)
            + String(repeating: "N", count: total/4)
            + String(repeating: "T", count: total/4))
        // N を計算結果に含めない(デフォルト).
        var result = seq.contentTotal([.s])
        XCTAssertEqual(total/4, result)
        
        // N を計算結果に含める(デフォルト).
        result = seq.contentTotal([.s], containN: true)
        // N と G が検出され, 合計される.
        XCTAssertEqual(total/2, result)
        XCTAssertEqual(total/4, seq.contentTotal(.g))
        XCTAssertEqual(total/2, seq.contentTotal(.a, containN: true))
        XCTAssertEqual(0, seq.contentTotal(.c))
        XCTAssertEqual(total, seq.contentTotal(.n, containN: true))
        XCTAssertEqual(total, seq.contentTotal(.n, containN: false))
    }
    
}
