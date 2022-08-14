//
//  Standard.swift
//  
//
//  Created by rrbox on 2022/08/14.
//

private extension BaseSequence {
    func contentTotalNotIgnoreN(_ mask: UInt8) -> Int {
        return self.sequence.reduce(into: 0) { partialResult, n in
            if (n & mask) != 0 {
                partialResult += 1
            }
        }
    }
    
    func contentTotalIgnoreN(_ mask: UInt8) -> Int {
        return self.sequence.reduce(into: 0) { partialResult, n in
            if ((n | mask) ^ mask) == 0 {
                partialResult += 1
            }
        }
    }
    
}

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
    ///   - option: N を検索結果に含む(無視する)かどうかを Bool 値で指定します. デフォルトは true です.
    /// - Returns: 配列に base がいくつ含まれるか.
    func contentTotal(_ base: Nucleotide, ignoreN option: Bool = true) -> Int {
        let mask = base.rawValue
        if option {
            return self.contentTotalIgnoreN(mask)
        } else {
            return self.contentTotalNotIgnoreN(mask)
        }
    }
    
    /// 相補的な配列を算出します.
    /// - Returns: 現在の配列の相補鎖のデータをもつ配列
    func complementaryStrand() -> BaseSequence<DNA> {
        return BaseSequence<DNA>(sequence: self.sequence.map({ n in
            bitRotateLeft(n, n: 4)
        }))
    }
    
}
