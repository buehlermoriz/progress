//
//  training.swift
//  progress
//
//  Created by Moriz Buehler on 17.06.22.
//

import SwiftUI

struct training: View {
    @Environment (\.managedObjectContext) private var viewContext
    @Environment (\.dismiss) private var dismiss
    var body: some View {
        NavigationView{
            VStack{
                Text("Hello, World!")
                Button("close",action: {dismiss()})
            }
                
            
           
        }.navigationTitle("Training")
    }
}

struct training_Previews: PreviewProvider {
    static var previews: some View {
        training()
    }
}
