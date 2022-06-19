//
//  training.swift
//  progress
//
//  Created by Moriz Buehler on 17.06.22.
//

import SwiftUI

struct training: View {
    
    @State var  countItems = 0
    @State var progressTraining = 0
    
    private var progressView = UIProgressView(progressViewStyle: .default)
    
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.id, ascending: true)],
        animation: .default)
    
    private var items: FetchedResults<Item>
    
    @Environment (\.managedObjectContext) private var viewContext
    @Environment (\.dismiss) private var dismiss
   
    var body: some View {
        NavigationView{
            VStack{
              
progressView
                Spacer()
                                Text(items[progressTraining].task!)
                                    .font(.title)
                                    .fontWeight(.bold)
                                HStack(alignment: .center){
                                    Text(items[progressTraining].weight!)
                                        .font(.largeTitle)
                                        .foregroundColor(Color.theme.accent)
                                    Text("kg")}
                                HStack(alignment: .center){Text(items[progressTraining].itterations!)
                                        .foregroundColor(Color.gray)
                                    Text("x")}
                                .foregroundColor(Color.gray)
                            Spacer()
             Button("next", action: handleTraining)
            }.navigationTitle("Training")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing){
                        Button(action: {dismiss()}, label: {Text("cancel")})
                    }
                }
                
            
           
        }
    }
    
    func handleTraining(){
        let countItems = items.count - 1
        if countItems > progressTraining {
            progressTraining += 1
        }
        else if countItems == progressTraining {
            dismiss()
        }
    }
}

struct training_Previews: PreviewProvider {
    static var previews: some View {
        training()
    }
}
