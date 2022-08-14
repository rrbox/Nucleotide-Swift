//
//  Nucreotide.swift
//
//
//  Created by rrbox on 2022/08/13.
//

public struct Nucleotide: OptionSet {
    public var rawValue: UInt8
    public init(rawValue: UInt8) {
        self.rawValue = rawValue
    }
}

public extension Nucleotide {
    static let a = Self.init(rawValue: 0b11)
    static let c = Self.init(rawValue: 0b11 << 2)
    static let g = Self.init(rawValue: 0b11 << 6)
    static let t = Self.init(rawValue: 0b11 << 4)
    static let u = Self.init(rawValue: 0b11 << 4)
}

// fasta 形式
extension Nucleotide {
    static let r: Nucleotide = [.a, .g]
    static let y: Nucleotide = [.t, .c]
    static let k: Nucleotide = [.g, .t]
    static let m: Nucleotide = [.a, .c]
}

public extension Nucleotide {
    static let s: Nucleotide = [.g, .c]
    static let w: Nucleotide = [.a, .t]
}

public extension Nucleotide {
    static let b: Nucleotide = [.g, .t, .c]
    static let d: Nucleotide = [.g, .a, .t]
    static let h: Nucleotide = [.a, .c, .t]
    static let v: Nucleotide = [.g, .c, .a]
}

public extension Nucleotide {
    static let n: Nucleotide = [.a, .g, .c, .t]
    static let gap: Nucleotide = .init(rawValue: 0)
}
