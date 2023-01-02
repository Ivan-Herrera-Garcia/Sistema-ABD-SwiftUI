//
//  Acercade.swift
//  AppABC
//
//  Created by IHG on 01/01/23.
//

import SwiftUI

struct Acercade: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Image("pochita").resizable().scaledToFit()
            
            Text("Autor: Ivan Herrera Garcia")
            
            Button(action: {
                self.mode.wrappedValue.dismiss()
            }, label: {
                Text("Volver").padding()
            })
        }.navigationTitle("Creador")
    }
}

struct Acercade_Previews: PreviewProvider {
    static var previews: some View {
        Acercade()
    }
}
