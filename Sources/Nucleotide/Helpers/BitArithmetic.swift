//
//  File.swift
//  
//
//  Created by rrbox on 2022/08/14.
//

func rotateLeft(_ b: UInt8, n: Int) -> UInt8 {
    return (b<<n)|(b>>(8-n))
}
