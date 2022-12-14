//
//  File.swift
//  
//
//  Created by rrbox on 2022/08/14.
//

import XCTest
import Nucleotide

final class AnalyzerMeasureTests: XCTestCase {
    let seqLength = 1000000
    var seq: BaseSequence<DNA>?
    override func setUp() async throws {
        self.seq = BaseSequence<DNA>.init(
            stringLiteral:
                String(repeating: "A",
                       count: self.seqLength/2) + String(repeating: "G",
                                                         count: self.seqLength/2))
        
    }
    
    // N を無視する場合の塩基含有量計算テスト. 実行時間も計測.
    func testTotalContentIgnoreNSeq() throws {
        var result = 0
        guard let seq = self.seq else {
            return
        }

        self.measure {
            result = seq.contentTotal([.s])
        }
        XCTAssertEqual(self.seqLength/2, result)
//        計測結果
//        10万塩基: 0.011 sec
//        100万塩基: 0.110 sec
//        1000万塩基: 1.065 sec
//        予想
//        1億塩基: 10 sec
//        10億塩基: 100 sec
    }
    
    // N を無視しない場合の塩基含有量計算テスト. 実行時間も計測.
    func testTotalContentNotIgnoreNSeq() throws {
        var result = 0
        guard let seq = self.seq else {
            return
        }
        
        self.measure {
            result = seq.contentTotal([.s], ignoreN: false)
        }
        XCTAssertEqual(self.seqLength/2, result)
//        計測結果
//        10万塩基: 0.012 sec
//        100万塩基: 0.095 sec
//        1000万塩基: 0.921 sec
//        結論: N を無視しても無視しなくてもほとんど同じ.
    }

//    相補的な配列の算出のテスト. 実行時間も計測.
    func testComplementaryStrand() throws {
        var result: BaseSequence<DNA>?
        let target = BaseSequence<DNA>.init(
            stringLiteral: String(repeating: "C",
                                  count: self.seqLength/2) + String(repeating: "T",
                                                                    count: self.seqLength/2))
        guard let seq = self.seq else {
            return
        }
        
        self.measure {
            result = seq.reveseComplementaryStrand()
        }
        
        XCTAssertEqual(result!.description, target.description)
//        計測結果
//        10万塩基: 0.023 sec
//        100万塩基: 0.205 sec
//        1000万塩基: 2.019 sec
        
    }
    
}

final class AnalyzeTests: XCTestCase {
//     N を含む配列での塩基含有量計算テスト.
    func testTotalContent() throws {
        let total = 100
        let seq = BaseSequence<DNA>.init(
            stringLiteral:
                String(repeating: "A", count: total/4)
            + String(repeating: "G", count: total/4)
            + String(repeating: "N", count: total/4)
            + String(repeating: "T", count: total/4))
        
        
        XCTAssertEqual(total/4, seq.contentTotal(.s))
        XCTAssertEqual(0, seq.contentTotal([]))
        XCTAssertEqual(total/4, seq.contentTotal(.g))
        XCTAssertEqual(total/2, seq.contentTotal(.g, ignoreN: false))
        XCTAssertEqual(3 * (total/4), seq.contentTotal([.a, .g], ignoreN: false))
        XCTAssertEqual(0, seq.contentTotal(.c))
        XCTAssertEqual(total, seq.contentTotal(.n))
        XCTAssertEqual(total, seq.contentTotal(.n, ignoreN: false))
    }
    
//    相補的な配列を算出するテスト.
    func testReverseComplementaryStrand() throws {
        let dna: BaseSequence<DNA> = "ATGCATGCN"
        XCTAssertEqual(
            dna.reveseComplementaryStrand()
                .description, "DNA: NGCATGCAT")
        XCTAssertEqual(
            dna.reverseComplementaryStrand(typeOf: RNA.self)
                .description, "RNA: NGCAUGCAU")
        
    }
    
//    相補的な配列を算出するテスト.
    func testComplementaryStrand() throws {
        let dna: BaseSequence<DNA> = "ATGCATGCN"
        XCTAssertEqual(
            dna.complementaryStrand()
                .description, "DNA: TACGTACGN")
        XCTAssertEqual(
            dna.complementaryStrand(typeOf: RNA.self)
                .description, "RNA: UACGUACGN")
        
    }
    
    //    逆向き配列を算出するテスト.
    func testfReverseStrand() throws {
        let dna: BaseSequence<DNA> = "ATGCATGCN"
        XCTAssertEqual(
            dna.reversed()
                .description, "DNA: NCGTACGTA")
        
    }
    
}
