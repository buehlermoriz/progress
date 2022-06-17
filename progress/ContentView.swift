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
    
    // mo -- Show oter pages
    
    @State var showAddNewItem = false
    @State private var showTrainingView = false
    
    
    //Editmodestuff
    @State private var editMode: EditMode = .inactive
    
    @Environment(\.managedObjectContext) private var viewContext
    
    
    // Mo -- Get training
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.id, ascending: true)],
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
                                        .foregroundColor(Color.theme.accent)
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
                // mo -- display other pages
                    .sheet(isPresented: $showTrainingView){training()}
                    .sheet(isPresented: $showAddNewItem){addNewItem()}
                    .accentColor(.theme.accent)
                
                HStack{
                    editButton
                    toggleOverlay
                    Button{if showTrainingView == false {
                        showTrainingView = true
                    } else {
                        showTrainingView = false
                    }
                    } label: {
                        Text("toggle")
                    }
                }.padding()
            }
            
        }
    }
    
    // Mo -- Custom Buttons
    var toggleOverlay: some View{
        return Button{
            if showAddNewItem == false {
                showAddNewItem = true
            } else {
                showAddNewItem = false
            }
        } label: {
            Image(systemName: "plus.circle")
                .font(.title)
                .foregroundColor(Color.theme.accent)
        }
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
                .foregroundColor(Color.theme.accent) :
            Image(systemName: "pencil.circle.fill")
                .font(.title)
                .foregroundColor(Color.theme.accent)
        }
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
        Group {
            ContentView()
        }
    }
}
