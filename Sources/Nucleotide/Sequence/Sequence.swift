//
//  File.swift
//  
//
//  Created by rrbox on 2022/08/14.
//

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
