//
//  File.swift
//  
//
//  Created by rrbox on 2022/08/16.
//

public struct BaseSequenceSIMD64<T: BaseType>: CustomStringConvertible {
    var sequence: [SIMD64<UInt8>]
    
    init(sequence: [UInt8]) {
        self.sequence = stride(from: sequence.startIndex, through: sequence.endIndex, by: 64).map { i -> SIMD64<UInt8> in
            return SIMD64<UInt8>(
                (i ..< i+64).map { i -> UInt8 in
                    if sequence.indices.contains(i) {
                        return sequence[i]
                    } else {
                        return .zero
                    }
                }
            )
        }
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

