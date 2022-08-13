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
    static let g = Self.init(rawValue: 0b11 << 4)
    static let t = Self.init(rawValue: 0b11 << 6)
    static let u = Self.init(rawValue: 0b11 << 6)
}

// fasta 形式
extension Nucleotide {
    static let r: Self = [.a, .g]
    static let y: Self = [.t, .c]
    static let k: Self = [.g, .t]
    static let m: Self = [.a, .c]
}

public extension Nucleotide {
    static let s: Self = [.g, .c]
    static let w: Self = [.a, .t]
}

public extension Nucleotide {
    static let b: Self = [.g, .t, .c]
    static let d: Self = [.g, .a, .t]
    static let h: Self = [.a, .c, .t]
    static let v: Self = [.g, .c, .a]
}

public extension Nucleotide {
    static let n: Self = [.a, .g, .c, .t]
    static let gap: Self = .init(rawValue: 0)
}

public protocol BaseType {
    static var unicodeToBaseDict: [UnicodeScalar: Nucleotide] { get }
    static var baseToUnicodeDict: [UInt8: UnicodeScalar] { get }
}

extension BaseType {
    static func unicodeConvertToBase(_ unicode: UnicodeScalar) -> Nucleotide? {
        return Self.unicodeToBaseDict[unicode]
    }
    
    static func baseConvertToUnicode(_ base: Nucleotide) -> UnicodeScalar? {
        return Self.baseToUnicodeDict[base.rawValue]
    }
}


public enum DNA: BaseType {
    public static let unicodeToBaseDict: [UnicodeScalar: Nucleotide] = [
        "A": .a,
        "C": .c,
        "G": .g,
        "T": .t,
        "N": .n,
    ]
    
    public static let baseToUnicodeDict: [UInt8: UnicodeScalar] = [
        Nucleotide.a.rawValue: "A",
        Nucleotide.t.rawValue: "T",
        Nucleotide.c.rawValue: "C",
        Nucleotide.g.rawValue: "G",
        Nucleotide.n.rawValue: "N",
    ]
    
}

public enum RNA: BaseType {
    public static let unicodeToBaseDict: [UnicodeScalar: Nucleotide] = [
        "A": .a,
        "C": .c,
        "G": .g,
        "U": .u,
        "N": .n,
    ]
    
    public static let baseToUnicodeDict: [UInt8: UnicodeScalar] = [
        Nucleotide.a.rawValue: "A",
        Nucleotide.u.rawValue: "U",
        Nucleotide.c.rawValue: "C",
        Nucleotide.g.rawValue: "G",
        Nucleotide.n.rawValue: "N",
    ]
    
}

public struct BaseSequence<T: BaseType>: ExpressibleByStringLiteral, CustomStringConvertible {
    var sequence: [UInt8]
    
    public init(stringLiteral value: StringLiteralType) {
        self.sequence = value.unicodeScalars.reduce(into: []) { partialResult, s in
            partialResult.append(T.unicodeConvertToBase(s)!.rawValue)
        }
    }
    
    public var description: String {
        "\(T.self): \(self.sequence.reduce(into: "") {$0 += String(T.baseConvertToUnicode(Nucleotide(rawValue: $1))!)})"
    }
    
}
