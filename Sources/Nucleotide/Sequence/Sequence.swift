//
//  Sequence.swift
//  
//
//  Created by rrbox on 2022/08/14.
//

public protocol BaseType {
    static var unicodeToBaseDict: [Unicode.UTF8.CodeUnit: Nucleotide] { get }
    static var baseToUnicodeDict: [UInt8: UnicodeScalar] { get }
}

extension BaseType {
    static func convertUnicodeToBase(_ unicode: Unicode.UTF8.CodeUnit) -> Nucleotide? {
        return Self.unicodeToBaseDict[unicode]
    }
    
    static func convertBaseToUnicode(_ base: Nucleotide) -> UnicodeScalar? {
        return Self.baseToUnicodeDict[base.rawValue]
    }
    
}

public enum DNA: BaseType {
    public static let unicodeToBaseDict: [Unicode.UTF8.CodeUnit: Nucleotide] = [
        UnicodeScalar("A").utf8.first!: .a,
        UnicodeScalar("C").utf8.first!: .c,
        UnicodeScalar("G").utf8.first!: .g,
        UnicodeScalar("T").utf8.first!: .t,
        UnicodeScalar("N").utf8.first!: .n,
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
    public static let unicodeToBaseDict: [Unicode.UTF8.CodeUnit: Nucleotide] = [
        UnicodeScalar("A").utf8.first!: .a,
        UnicodeScalar("C").utf8.first!: .c,
        UnicodeScalar("G").utf8.first!: .g,
        UnicodeScalar("U").utf8.first!: .u,
        UnicodeScalar("N").utf8.first!: .n,
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
        self.sequence = value.utf8.map({ s in
            T.convertUnicodeToBase(s)!.rawValue
        })
    }
    
    init(sequence: [UInt8]) {
        self.sequence = sequence
    }
    
    public var description: String {
        "\(T.self): \(self.sequence.reduce(into: "") {$0 += String(T.convertBaseToUnicode(Nucleotide(rawValue: $1))!)})"
    }
    
}
