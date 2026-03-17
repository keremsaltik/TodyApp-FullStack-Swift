//
//  NavigationManager.swift
//  todoAppSwiftUI
//
//  Created by Kerem Saltık on 16.03.2026.
//

import SwiftUI
internal import Combine

@MainActor
class NavigationManager: ObservableObject{
    
    static let shared = NavigationManager()
    private init(){}
    
    @Published var path = NavigationPath()
    
    func push(_ route: Route){
        path.append(route)
    }
    
    
    func pop(){
        if !path.isEmpty{
            path.removeLast()
        }
    }
    
    func popToRoot(){
        path = NavigationPath()
    }
}
