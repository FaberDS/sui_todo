//
//  ContentView.swift
//  sui_todo
//
//  Created by Denis Schüle on 27.10.21.
//

import SwiftUI
import CoreData

enum ActiveSheet : Identifiable {
    var id: UUID { UUID()}
    case addView
    case updateView (todo: Todo)
}


struct ContentView: View {
    @State private var activeSheet : ActiveSheet? = nil
    @State private var sorting = false
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors:
                    [NSSortDescriptor(keyPath: \Todo.priority, ascending:false )])
    var tasks : FetchedResults<Todo>

    private var prioritySign = ["","!", "!!!"]
    
    
    var body: some View {
        NavigationView {
            todoView
            .navigationTitle("Todoes")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        activeSheet = .addView
                    }) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                        .disabled(tasks.isEmpty)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        sorting.toggle()
                    }) {
                        Image(systemName: "arrow.up.arrow.down")
                    }
                }
            }
            .sheet(item: $activeSheet) { activeSheet in
                switch activeSheet {
                case .addView:
                    AddTodoView()
                case .updateView(let todo):
                    AddTodoView(todo: todo)
                }
            }
         
        }
    }
    
    
    // ermöglichen conditional views
    @ViewBuilder
    var todoView : some View {
        if tasks.isEmpty {
            //emptyView
            VStack(spacing:30) {
                Image(systemName: "tray.full")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                Text("No todoes")
                    .font(.system(size: 30,weight: .semibold))
            }.foregroundColor(Color.black.opacity(0.4))
        } else {
            //Listview
                        List{
                            // ForEach ermöglich onDelete modifier
                            ForEach(tasks, id: \.id)  { todo in
                                HStack {
                                    Text(prioritySign[Int(todo.priority)])
                                        .foregroundColor(.red)
                                        .fontWeight(.semibold)
                                    Text(todo.title ?? "N/A" )
                                }
                                .onTapGesture {
                                    activeSheet = .updateView(todo:todo)
                                }
                            //short
                            }.onDelete(perform: deleteItems)
            
                            //long
            //                }.onDelete(perform: { indexSet in
            //                    deleteItems(offsets: indexSet)
            //                })
                        }
        }
    }
    func deleteItems(offsets: IndexSet){
        let todoToDelete = offsets.map {tasks[$0]}.forEach(viewContext.delete)
        //long
        //        let todoToDelete = offsets.map {tasks[$0]}.forEach {viewContext.delete($0)}
        try? viewContext.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, CoreDataManager.preview.persistentContainer.viewContext)

    }
}
