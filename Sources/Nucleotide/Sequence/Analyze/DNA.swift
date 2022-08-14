//
//  DNA.swift
//  
//
//  Created by rrbox on 2022/08/14.
//

public extension BaseSequence where T == DNA {
    /// DNA配列からRNA配列を生成します.
    func transcribed() -> BaseSequence<RNA> {
        return BaseSequence<RNA>(sequence: self.sequence)
    }
    
}
