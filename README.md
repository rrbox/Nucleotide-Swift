# Nucleotide

[![GitHub issues](https://img.shields.io/github/issues/rrbox/Nucleotide-Swift)](https://github.com/rrbox/Nucleotide-Swift/issues)
[![GitHub license](https://img.shields.io/github/license/rrbox/Nucleotide-Swift)](https://github.com/rrbox/Nucleotide-Swift/blob/main/LICENCE)
[![Swift](https://github.com/rrbox/Nucleotide-Swift/actions/workflows/swift.yml/badge.svg?branch=develop)](https://github.com/rrbox/Nucleotide-Swift/actions/workflows/swift.yml)

## Usage

(Click [here](https://github.com/rrbox/Nucleotide-Swift/wiki) for details)

### Import

```swift
import Nucleotide
```

### DNA sequence

```swift
// declaration
let dna: BaseSequence<DNA> = "ATGCATGC"

// Calculate GC content (non-GC combinations are also possible)
let gc = dna.contentTotal([.g, .c]) // 4

// Transcription from DNA sequence to RNA sequence
let rna = dna.transcribed() // "RNA: AUGCAUGC"

// Create a complementary strand of the sequence
let s = dna.reverseComplementaryStrand() // "DNA: CGATCGAT"
// RNA sequences are also possible
dna.reverseComplementaryStrand(typeOf: RNA.self) // "DNA: GCAUGCAU"
```

### RNA sequence

```swift
// declaration
let rna: BaseSequence<RNA> = "AUGCAUGC"

// Calculate GC content (non-GC combinations are also possible)
let gc = rna.contentTotal([.g, .c]) // 4

// Create a complementary strand of the sequence
let s = rna.reverseComplementaryStrand() // "RNA: UACGUACG"

// Generate cDNA of RNA
let cDNA = rna.reverseComplementaryStrand(typeOf: DNA.self) // "DNA: TACGTACG"
```
