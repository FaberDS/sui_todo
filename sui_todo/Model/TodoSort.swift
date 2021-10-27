//
//  PrioritySort.swift
//  sui_todo
//
//  Created by Denis Schüle on 27.10.21.
//

import Foundation
struct TodoSort: Hashable, Identifiable {
  let id: Int // to be conform to the Identifiable Protocol
  let name: String
  let descriptors: [SortDescriptor<Todo>] //<iOS 15 it was NSSortDescriptor

    // 1
    static let sorts: [TodoSort] = [
      // 2
        TodoSort(
        id: 0,
        name: "Todo | Ascending",
        // 3
        descriptors: [
          SortDescriptor(\Todo.priority, order: .forward),
          SortDescriptor(\Todo.title, order: .forward)
        ]),
        TodoSort(
        id: 1,
        name: "Todo | Descending",
        descriptors: [
          SortDescriptor(\Todo.priority, order: .reverse),
          SortDescriptor(\Todo.title, order: .forward)
        ]),
        TodoSort(
        id: 2,
        name: "Todo Date | Ascending",
        descriptors: [
          SortDescriptor(\Todo.timestamp, order: .forward),
          SortDescriptor(\Todo.title, order: .forward)
        ]),
        TodoSort(
        id: 3,
        name: "Todo Date | Descending",
        descriptors: [
          SortDescriptor(\Todo.timestamp, order: .reverse),
          SortDescriptor(\Todo.title, order: .forward)
        ])
    ]

    // 4
    static var `default`: TodoSort { sorts[0] }

}

