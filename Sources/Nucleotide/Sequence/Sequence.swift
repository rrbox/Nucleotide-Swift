//
//  Sequence.swift
//  
//
//  Created by rrbox on 2022/08/14.
//

public protocol BaseType {
    static var unicodeToBaseDict: [UInt32: UInt8] { get }
    static var baseToUnicodeDict: [UInt8: Character] { get }
}

public enum DNA: BaseType {
    public static let unicodeToBaseDict: [UInt32: UInt8] = [
        UnicodeScalar("A").value: Nucleotide.a.rawValue,
        UnicodeScalar("C").value: Nucleotide.c.rawValue,
        UnicodeScalar("G").value: Nucleotide.g.rawValue,
        UnicodeScalar("T").value: Nucleotide.t.rawValue,
        UnicodeScalar("N").value: Nucleotide.n.rawValue,
    ]
    
    public static let baseToUnicodeDict: [UInt8: Character] = [
        Nucleotide.a.rawValue: "A",
        Nucleotide.t.rawValue: "T",
        Nucleotide.c.rawValue: "C",
        Nucleotide.g.rawValue: "G",
        Nucleotide.n.rawValue: "N",
    ]
    
}

public enum RNA: BaseType {
    public static let unicodeToBaseDict: [UInt32: UInt8] = [
        UnicodeScalar("A").value: Nucleotide.a.rawValue,
        UnicodeScalar("C").value: Nucleotide.c.rawValue,
        UnicodeScalar("G").value: Nucleotide.g.rawValue,
        UnicodeScalar("U").value: Nucleotide.u.rawValue,
        UnicodeScalar("N").value: Nucleotide.n.rawValue,
    ]
    
    public static let baseToUnicodeDict: [UInt8: Character] = [
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
        self.sequence = value.unicodeScalars.map({ s in
            T.unicodeToBaseDict[s.value]!
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
