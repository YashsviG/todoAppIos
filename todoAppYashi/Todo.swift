//
//  Todo.swift
//  todoAppYashi
//
//  Created by user181154 on 10/5/20.
//

import Foundation

struct Todo
{
    let title: String
    let isComplete: Bool
    init(title: String, isComplete: Bool = false) {
        self.title = title
        self.isComplete = isComplete
    }
    
    func completeToggled() -> Todo{
        return Todo(title: title, isComplete: !isComplete)
    }
}
