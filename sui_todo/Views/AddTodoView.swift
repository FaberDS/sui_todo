//
//  AddTodoView.swift
//  sui_todo
//
//  Created by Denis Schüle on 27.10.21.
//

import SwiftUI

struct AddTodoView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var viewContext

    @State private var title : String
    @State private var priority : Int

    private var todo : Todo?
    
    init(todo: Todo? = nil){
        self.todo = todo
        //_title _ ist nötig da es sich um Statevariablen handelt
        self._title = State.init(initialValue: todo?.title ?? "")
        self._priority = State.init(initialValue: Int(todo?.priority ?? 0))


    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Title")){
                    TextField("Staubsaugen", text: $title)
                }
                Section(header: Text("Priorität")){
                    Picker("",selection: $priority){
                        Text("Normal").tag(0)
                        Text("!").tag(1)
                        Text("!!!").tag(2)
                    }.pickerStyle(SegmentedPickerStyle())
                }
               
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel"){
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save"){
                        if let todo = todo {
                            updateTask(todo: todo)
                        } else {
                            createTask()
                        }
                        presentationMode.wrappedValue.dismiss()
                    }.disabled(title.isEmpty)
                }
            })
            .navigationBarTitle(todo == nil ? "New Todo" : "Update Todo")
        }

    }
    func createTask(){
        let todo = Todo(context: viewContext)
        todo.title = title
        todo.priority = Int16(priority)
        todo.timestamp = Date()
        todo.id = UUID()
        try! viewContext.save()
    }
    func updateTask(todo: Todo){
        todo.title = title
        todo.priority = Int16(priority)
        try! viewContext.save()
    }
}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
