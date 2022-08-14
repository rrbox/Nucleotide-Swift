//
//  Standard.swift
//  
//
//  Created by rrbox on 2022/08/14.
//

public extension BaseSequence {
    /// 任意の複合塩基がいくつ含まれているかを算出します.
    /// ```swift
    /// let seq: BaseSequence<DNA> = "AAAAAAAAAAGGGGGGGGGG"
    /// // GC含有数を計算
    /// print(seq.contentTotal([.c, .g])) // 10
    /// // or
    /// print(seq.contentTotal(.s)) // 10
    /// ```
    /// - Parameters:
    ///   - b: 合計を調べたい塩基
    ///   - option: N を検索結果に含めるかどうかを Bool 値で指定します. default is false.
    /// - Returns: 配列に base がいくつ含まれるか.
    func contentTotal(_ base: Nucleotide, containN option: Bool = false) -> Int {
        let mask = base.rawValue
        if option {
            return self.sequence.reduce(into: 0) { partialResult, n in
                if (n & mask) != 0 {
                    partialResult += 1
                }
            }
        } else {
            return self.sequence.reduce(into: 0) { partialResult, n in
                if ((n | mask) ^ mask) == 0 {
                    partialResult += 1
                }
            }
        }
    }
    
}
