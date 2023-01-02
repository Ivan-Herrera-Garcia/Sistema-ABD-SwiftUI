//
//  AddUserView.swift
//  SwiftUI-Sqlite
//
//  Created by IHG on 15/12/22.
//

import SwiftUI

struct AddUserView: View {
    //CREACION DE VARIABLES PARA ALMACENAR VALORES
    @State var valor1 : String = ""
    @State var valor2 : String = ""
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    
    var body: some View {
        
        VStack {
            //Campos de texto para insertar nuevos datos en la bd
            TextField ("Ingrese el valor 1", text : $valor1).disableAutocorrection(true)
                .autocapitalization(.none)
                .padding(8)
                .background(Color.blue.opacity(0.3))
                .cornerRadius(6)
                .padding(.horizontal, 60)
                .padding(.top, 40)
            TextField ("Ingrese el valor 2", text : $valor2).disableAutocorrection(true)
                .autocapitalization(.none)
                .padding(8)
                .background(Color.blue.opacity(0.3))
                .cornerRadius(6)
                .padding(.horizontal, 60)
                
            
            HStack {
                Button(action: {self.mode.wrappedValue.dismiss()}, label: {Text("Cancelar")}).padding()
            
            Button(action: {
                
                DB_Manager().addUser(pvalor1: self.valor1, pvalor2: self.valor2)
                
                //Boton en modo de referencia utilizando el metodo addUser de la clase DB_Manager
                //para la insercion de datos
                self.mode.wrappedValue.dismiss()}, label: { Text("Agregar")
                }).padding()
            }.padding()
        }.navigationTitle("Agregar datos")
    }
}

struct AddUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddUserView()
    }
}
