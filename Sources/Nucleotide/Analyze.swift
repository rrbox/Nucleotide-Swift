//
//  File.swift
//  
//
//  Created by rrbox on 2022/08/14.
//

import Foundation

public extension BaseSequence {
    /// 任意の複合塩基がいくつ含まれているかを算出します.
    /// ```swift
    /// let seq: BaseSequence<DNA> = "AAAAAAAAAAGGGGGGGGGG"
    /// // GC含有率を計算
    /// print(seq.contentTotal([.c, .g])) // 10
    /// // or
    /// print(seq.contentTotal(.s)) // 10
    /// ```
    func contentTotal(_ b: Nucleotide) -> Int {
        let mask = b.rawValue
        return self.sequence.reduce(into: 0) { partialResult, n in
            if (n & mask) != 0 {
                partialResult += 1
            }
        }
    }
}
