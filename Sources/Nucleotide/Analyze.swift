//
//  File.swift
//  
//
//  Created by rrbox on 2022/08/14.
//

import Foundation

public extension BaseSequence {
    /// 任意の複合塩基がいくつ含まれているかを算出します.
    func contentTotal(_ b: Nucleotide) -> Int {
        let mask = b.rawValue
        return self.sequence.reduce(into: 0) { partialResult, n in
            if (n & mask) != 0 {
                partialResult += 1
            }
        }
    }
}
