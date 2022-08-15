//
//  Sequence.swift
//  
//
//  Created by rrbox on 2022/08/14.
//

public protocol BaseType {
    static var unicodeToBaseDict: [Unicode.UTF8.CodeUnit: UInt8] { get }
    static var baseToUnicodeDict: [UInt8: Character] { get }
}

public enum DNA: BaseType {
    public static let unicodeToBaseDict: [Unicode.UTF8.CodeUnit: UInt8] = [
        UnicodeScalar("A").utf8.first!: Nucleotide.a.rawValue,
        UnicodeScalar("C").utf8.first!: Nucleotide.c.rawValue,
        UnicodeScalar("G").utf8.first!: Nucleotide.g.rawValue,
        UnicodeScalar("T").utf8.first!: Nucleotide.t.rawValue,
        UnicodeScalar("N").utf8.first!: Nucleotide.n.rawValue,
    ]
    
    public static let baseToUnicodeDict: [UInt8: Character] = [
        Nucleotide.a.rawValue: "A",
        Nucleotide.t.rawValue: "T",
        Nucleotide.c.rawValue: "C",
        Nucleotide.g.rawValue: "G",
        Nucleotide.n.rawValue: "N",
        0: "-",
    ]
    
}

public enum RNA: BaseType {
    public static let unicodeToBaseDict: [Unicode.UTF8.CodeUnit: UInt8] = [
        UnicodeScalar("A").utf8.first!: Nucleotide.a.rawValue,
        UnicodeScalar("C").utf8.first!: Nucleotide.c.rawValue,
        UnicodeScalar("G").utf8.first!: Nucleotide.g.rawValue,
        UnicodeScalar("U").utf8.first!: Nucleotide.u.rawValue,
        UnicodeScalar("N").utf8.first!: Nucleotide.n.rawValue,
    ]
    
    public static let baseToUnicodeDict: [UInt8: Character] = [
        Nucleotide.a.rawValue: "A",
        Nucleotide.u.rawValue: "U",
        Nucleotide.c.rawValue: "C",
        Nucleotide.g.rawValue: "G",
        Nucleotide.n.rawValue: "N",
        0: "-",
    ]
    
}

public struct BaseSequence<T: BaseType>: ExpressibleByStringLiteral, CustomStringConvertible {
    var sequence: [UInt8]
    
    public init(stringLiteral value: StringLiteralType) {
        self.sequence = value.utf8.map({ s in
            T.unicodeToBaseDict[s]!
        })
    }
    
    init(sequence: [UInt8]) {
        self.sequence = sequence
    }
    
    public var description: String {
//        "\(T.self): \(self.sequence.reduce(into: "") {$0 += String(T.baseToUnicodeDict[$1]!)})"
        "\(T.self): \(String(self.sequence.map { T.baseToUnicodeDict[$0]! }))"
        
    }
    
}
