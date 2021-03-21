//
//  NewTaskView.swift
//  SwiftUITaskApp
//
//  Created by Paul Franco on 3/21/21.
//

import SwiftUI

struct NewTaskView: View {
    // MARK: - PROPERTIES
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    let priorities = ["High", "Normal", "Low"]
    
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    // MARK: - TASK NAME
                    TextField("Task", text: $name)
                    
                    // MARK: - TASK PRIORITY
                    Picker("Priority", selection: $priority) {
                        ForEach (priorities, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    // MARK: - SAVE BUTTON
                    Button(action: {
                        if self.name != "" {
                            print("save a new task item")
                            let task = Task(context: self.viewContext)
                            task.name = self.name
                            task.priority = self.priority
                            
                            do {
                                try self.viewContext.save()
                                print("New Task \(task.name ?? ""), Priority: \(task.priority ?? "")")
                            } catch {
                                print(error)
                            }
                        } else {
                            self.errorShowing = true
                            self.errorTitle = "Invalid Name"
                            self.errorMessage = "Make sure to enter something for\n the new task"
                            return
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Save")
                    }//: SAVE BUTTON
                }//: FORM
                Spacer()
                
            }//: VStACK
            .navigationBarTitle("New Task", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
            }))
            .alert(isPresented: $errorShowing) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
            
            
        } //: NAVIGATION
        
    }
}

// MARK: - PREVIEW
struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskView()
    }
}
