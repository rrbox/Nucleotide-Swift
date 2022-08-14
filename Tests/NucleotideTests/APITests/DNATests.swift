//
//  DNATests.swift
//  
//
//  Created by rrbox on 2022/08/14.
//

import XCTest
import Nucleotide

class DNATests: XCTestCase {
    func testTranscribe() throws {
        let dna: BaseSequence<DNA> = "ATGCATGC"
        let rna = dna.transcribed()
        XCTAssertEqual(rna.description, "RNA: AUGCAUGC")
        
    }
    
    func testComplementaryStrand() throws {
        let dna: BaseSequence<DNA> = "ATGCATGC"
        XCTAssertEqual(dna.complementaryStrand().description, "DNA: TACGTACG")
        
    }

}
