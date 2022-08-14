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

public protocol BaseType {
    static var unicodeToBaseDict: [UnicodeScalar: Nucleotide] { get }
    static var baseToUnicodeDict: [UInt8: UnicodeScalar] { get }
}

extension BaseType {
    static func convertUnicodeToBase(_ unicode: UnicodeScalar) -> Nucleotide? {
        return Self.unicodeToBaseDict[unicode]
    }
    
    static func convertBaseToUnicode(_ base: Nucleotide) -> UnicodeScalar? {
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
            partialResult.append(T.convertUnicodeToBase(s)!.rawValue)
        }
    }
    
    public var description: String {
        "\(T.self): \(self.sequence.reduce(into: "") {$0 += String(T.convertBaseToUnicode(Nucleotide(rawValue: $1))!)})"
    }
    
}
