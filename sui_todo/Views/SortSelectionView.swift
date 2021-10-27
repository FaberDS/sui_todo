//
//  SortSelectionView.swift
//  sui_todo
//
//  Created by Denis Schüle on 27.10.21.
//

import SwiftUI

struct SortSelectionView: View {
  // 1
  @Binding var selectedSortItem: TodoSort
  // 2
  let sorts: [TodoSort]
  var body: some View {
    // 1
    Menu {
      // 2
      Picker("Sort By", selection: $selectedSortItem) {
        // 3
        ForEach(sorts, id: \.self) { sort in
          // 4
          Text("\(sort.name)")
        }
      }
      // 5
    } label: {
      Label(
        "Sort",
        systemImage: "line.horizontal.3.decrease.circle")
    }
    // 6
    .pickerStyle(.inline)
  }
}
