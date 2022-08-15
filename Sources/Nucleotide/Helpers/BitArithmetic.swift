//
//  File.swift
//  
//
//  Created by rrbox on 2022/08/14.
//

func bitRotateLeft(_ b: UInt8, n: Int) -> UInt8 {
    return (b<<n)|(b>>(8-n))
}

func bitRotateLeft(_ b: SIMD64<UInt8>, n: UInt8) -> SIMD64<UInt8> {
    return (b &<< SIMD64<UInt8>(repeating: n)) | (b &>> SIMD64<UInt8>.init(repeating: 8-n))
}
