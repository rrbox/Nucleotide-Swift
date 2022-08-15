//
//  File.swift
//  
//
//  Created by rrbox on 2022/08/16.
//

private extension BaseSequenceSIMD64 {
    func contentTotalNotIgnoreN(_ mask: UInt8) -> Int {
//        let masked = self.sequence.map { simd in
//            simd & mask
//        }
//        return masked.reduce(into: 0) { partialResult, n in
//            for i in 0 ..< 64 {
//                if n[i] != .zero {
//                    partialResult += 1
//                }
//            }
//        }
        let a = 0 ..< 64
        return self.sequence.reduce(into: 0) { partialResult, simd in
            let masked = simd & mask
            partialResult += a.reduce(into: 0) { partialResult, i in
                if masked[i] != .zero {
                    partialResult += 1
                }
            }
        }
    }
    
    func contentTotalIgnoreN(_ mask: UInt8) -> Int {
        return self.sequence.reduce(into: 0) { partialResult, n in
            let masked = (n | mask) ^ mask
            for i in 0 ..< 64 {
                if n[i] == 0 {
                    continue
                }
                if masked[i] == .zero {
                    partialResult += 1
                }
            }
        }
    }
    
}


public extension BaseSequenceSIMD64 {
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
    /// - Parameter type: 塩基の型を選択することができます.
    /// - Returns: 現在の配列の相補鎖のデータをもつ配列. type で指定した塩基が適用されます.
    func complementaryStrand<U: BaseType>(typeOf type: U.Type) -> BaseSequenceSIMD64<U> {
        return BaseSequenceSIMD64<U>(sequence: self.sequence.map({ simd in
            bitRotateLeft(simd, n: 4)
        }))
    }
    
}
