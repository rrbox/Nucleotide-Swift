//
//  File.swift
//  
//
//  Created by rrbox on 2022/08/16.
//

import simd

/// SIMD 64 で表現された配列を作成します.
///
/// 相補鎖の生成, 標準出力の表示などを BaseSequence よりも高速に行うことができます.
public struct BaseSequenceSIMD64<T: BaseType>: CustomStringConvertible {
    var sequence: [SIMD64<UInt8>]
    
    init(uint8 sequence: [UInt8]) {
        // 0 を後ろに埋めて要素数を 64 の倍数にする
        // - note: 最初から 64 の倍数の場合, 後ろにギャップが64個追加されてしまいます.
        let seq = sequence + [UInt8](repeating: 0, count: 64 - sequence.count%64)
        self.sequence = stride(from: sequence.startIndex, through: sequence.endIndex, by: 64).map { i -> SIMD64<UInt8> in
            return simd_uchar64(seq[i..<i+64])
        }
    }
    
    init(sequence: [SIMD64<UInt8>]) {
        self.sequence = sequence
    }
    
    public init(seq: BaseSequence<T>) {
        self.init(uint8: seq.sequence)
    }
    
    func description(simd: SIMD64<UInt8>) -> [Character] {
        (0 ..< 64).map { i in
            T.baseToUnicodeDict[simd[i]]!
        }
    }
    
    public var description: String {
        "SIMD64 DNA: " + String(self.sequence.reduce(into: []) { partialResult, simd in
            partialResult += self.description(simd: simd)
        })
    }
    
}

