//
//  Page.swift
//  todoAppSwiftUI
//
//  Created by Kerem Saltık on 10.03.2026.
//

import Foundation

struct Page<T: Codable>: Codable {
    struct Metadata: Codable {
        let total: Int
        let per: Int
        let page: Int
    }
    
    let metadata: Metadata
    let items: [T] 
}
