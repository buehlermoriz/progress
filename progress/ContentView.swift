//
//  ContentView.swift
//  progress
//
//  Created by Moriz Buehler on 16.06.22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    
    //Variables
    @State var newTask : String = ""
    @State var newWeight : String = ""
    @State var newIterations : String = ""
    
    @State var showOverlay = false
    
    
    //Editmodestuff
    @State private var editMode: EditMode = .inactive
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.task, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        NavigationView {
            
            VStack{
                List {
                    ForEach(items) { item in
                        HStack(alignment: .center){
                            VStack(alignment: .leading){
                                Text(item.task!)
                                    .font(.title)
                                    .fontWeight(.bold)
                            }
                            Spacer()
                            VStack(alignment: .center){
                                HStack(alignment: .center){
                                    Text(item.weight!)
                                        .font(.largeTitle)
                                        .foregroundColor(Color.red)
                                    Text("kg")}
                                HStack(alignment: .center){Text(item.itterations!)
                                        .foregroundColor(Color.gray)
                                    Text("x")}
                                .foregroundColor(Color.gray)
                            }
                        }
                        
                    }.onDelete(perform: deleteItems)
                }.navigationTitle("Progress")
                    .environment(\.editMode, $editMode)
                
                    .overlay( searchBar)
                
                
                HStack{
                    editButton
                    toggleOverlay
                }.padding(.top)
            }
            
        }
    }
    
    // Mo -- Custom Views
    var searchBar : some View {
        VStack{
            if showOverlay {
                Form{
                    Section( header: Text("Add new Task")) {
                        TextField("Task", text: self.$newTask)
                        TextField("Weight", text: self.$newWeight)
                        TextField("Iterations", text: self.$newIterations)
                    }
                    addButton
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
                                        .foregroundColor(Color.red)
                                    Text("kg")}
                                HStack(alignment: .center){Text(newIterations)
                                        .foregroundColor(Color.gray)
                                    Text("x")}
                                .foregroundColor(Color.gray)
                            }
                        }
                }
                }
    
        }
    }
    }
    
    // Mo -- Custom Buttons
    var toggleOverlay: some View{
        return Button{
            if showOverlay == false {
                showOverlay = true
            } else {
                showOverlay = false
            }
        } label: {
            showOverlay == false ?
            Image(systemName: "plus.circle")
                .font(.title)
                .foregroundColor(Color.red) :
            Image(systemName: "plus.circle.fill")
                .font(.title)
                .foregroundColor(Color.red)
        }
    }
    var addButton: some View{
        
        return Button(action: addItem, label: {
            Image(systemName: "plus.circle")
                .font(.title)
                .foregroundColor(Color.red)
        })
    }
    
    var editButton: some View {
        return Button {
            if editMode == .inactive {
                editMode = .active
            } else {
                editMode = .inactive
            }
        } label: {
            editMode == .inactive ?
            Image(systemName: "pencil.circle")
                .font(.title)
                .foregroundColor(Color.red) :
            Image(systemName: "pencil.circle.fill")
                .font(.title)
                .foregroundColor(Color.red)
        }
    }
    
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.task = newTask
            newItem.id = randomString(length: 5)
            newItem.weight = newWeight
            newItem.itterations = newIterations
            
            do {
                try viewContext.save()
                showOverlay = false
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
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
