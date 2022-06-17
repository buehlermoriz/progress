//
//  addNewItem.swift
//  progress
//
//  Created by Moriz Buehler on 17.06.22.
//

import SwiftUI

struct addNewItem: View {
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.id, ascending: true)],
        animation: .default)
    
    private var items: FetchedResults<Item>
    
    
    @Environment (\.managedObjectContext) private var viewContext
    @Environment (\.dismiss) private var dismiss
    
    
    @State var newTask : String = ""
    @State var newWeight : String = ""
    @State var newIterations : String = ""
    
    var body: some View {
        VStack(spacing: 0){
                Form{
                    Section( header: Text("Add new Task")) {
                        TextField("Task", text: self.$newTask)
                        TextField("Weight", text: self.$newWeight).keyboardType(UIKeyboardType.numberPad)
                        TextField("Iterations", text: self.$newIterations).keyboardType(UIKeyboardType.numberPad)
                    }
                    
                }
                List{
                    Section( header: Text("Preview")) {
                        HStack(alignment: .center){
                            VStack(alignment: .leading){
                                Text(newTask)
                                    .font(.title)
                                    .fontWeight(.bold)
                            }
                            Spacer()
                            VStack(alignment: .center){
                                HStack(alignment: .center){
                                    Text(newWeight)
                                        .font(.largeTitle)
                                        .foregroundColor(Color.theme.accent)
                                    Text("kg")}
                                HStack(alignment: .center){Text(newIterations)
                                        .foregroundColor(Color.gray)
                                    Text("x")}
                                .foregroundColor(Color.gray)
                            }
                        }
                }
                }
            addButton
 
    }
    }
    
    var addButton: some View{
        
        return Button("Save", action: addItem)
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.task = newTask
            newItem.id = randomString()
            newItem.weight = newWeight
            newItem.itterations = newIterations
            
            do {
                try viewContext.save()
                dismiss()
                newTask = ""
                newWeight = ""
                newIterations = ""
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    // Mo -- random String as ID - maybe change with coreData.lengh +1
    func randomString() -> String {
        let countItems = items.count
        let id = countItems + 1
        return String(id)
    }
}

struct addNewItem_Previews: PreviewProvider {
    static var previews: some View {
        addNewItem()
    }
}
