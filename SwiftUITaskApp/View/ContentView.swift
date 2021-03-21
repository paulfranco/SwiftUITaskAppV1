//
//  ContentView.swift
//  SwiftUITaskApp
//
//  Created by Paul Franco on 3/21/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    // MARK: - PROPERTIES
    @State private var showingNewTaskView: Bool = false
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.name, ascending: true)]) var tasks: FetchedResults<Task>


    // MARK: - BODY
    var body: some View {
        NavigationView {
            List {
                ForEach(self.tasks, id: \.self) { task in
                    HStack {
                        Text(task.name ?? "Unknown")
                        
                        Spacer()
                        
                        Text(task.priority ?? "Unknown")
                    }
                }//: ForEach
                .onDelete(perform: deleteTask)
            }//: LIST
            .navigationBarTitle("Task", displayMode: .inline)
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button(action: {
                // Show add task view
                self.showingNewTaskView.toggle()
            }) { Image(systemName: "plus")}
            .sheet(isPresented: $showingNewTaskView) {
                NewTaskView().environment(\.managedObjectContext, self.viewContext)
                
            }
            )
        }//: NAVIGATION
    }
    // MARK: - Functions
    private func deleteTask(at offsets: IndexSet) {
        for index in offsets {
            let task = tasks[index]
            viewContext.delete(task)
            
            do {
                try viewContext.save()
            } catch {
                print(error)
            }
        }
    }
}



// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
