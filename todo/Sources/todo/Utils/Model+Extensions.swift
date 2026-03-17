//
//  Model+Extensions.swift
//  todo
//
//  Created by Kerem Saltık on 28.02.2026.
//

import Fluent

extension Model{
    func setValue<Value>(
        _ value: Value?,
        to keyPath: ReferenceWritableKeyPath<Self, Value>
    ){
        if let value {
            self[keyPath: keyPath] = value
        }
    }
}
