//
//  DataFetchPhase.swift
//  Moviezine
//
//  Created by Aditya Tyagi  on 31/01/22.
//

import Foundation

enum DataFetchPhase<V> {
    
    case empty
    case success(V)
    case failure(Error)
    
    var value: V? {
        if case .success(let value) = self {
            return value
        }
        return nil
    }
    
}
