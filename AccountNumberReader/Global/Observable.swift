//
//  Observable.swift
//  AccountNumberReader
//
//  Created by peppermint100 on 2023/09/19.
//

import Foundation

class Observable<T> {
    var value: T {
        didSet {
            self.listener?(value)
        }
    }
    
    var listener: ((T) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
    
    func subscribe(listener: @escaping (T) -> Void) {
        listener(value)
        self.listener = listener
    }
}
