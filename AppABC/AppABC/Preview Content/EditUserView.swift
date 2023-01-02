//
//  EditUserView.swift
//  SwiftUI-Sqlite
//
//  Created by IHG on 16/12/22.
//

import SwiftUI
//Clase utilizada para editar datos/actualizar datos
struct EditUserView: View {
    
    //Variables utilizadas para el funcionamiento de la bd y metodos
    @Binding var id : Int64
    @State var name : String = ""
    @State var valor1 : String = ""
    @State var valor2 : String = ""
    //Tipo de dato para recibir y enviar datos de una vista a otra eb SwiftUI
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    
    
    var body: some View {
        VStack {
            //Campos de texto para actualizar los datos en las columnas de la bd
            TextField("Ingresa el valor 1", text: $valor1).disableAutocorrection(true)
                .autocapitalization(.none)
                .padding(8)
                .background(Color.green.opacity(0.3))
                .cornerRadius(6)
                .padding(.horizontal, 60)
                .padding(.top, 40)
            TextField("Ingresa el valor 2", text: $valor2).disableAutocorrection(true)
                .autocapitalization(.none)
                .padding(8)
                .background(Color.green.opacity(0.3))
                .cornerRadius(6)
                .padding(.horizontal, 60)
            HStack {
            //Boton que utiliza el metodo updateUser de la clase DB_Manager para realizar los cambios de informacion, utilizando parametros datos de los campos de texto y del modo Binding
            Button(action: {
                let userModel : UserModel = DB_Manager().getUser(idValue:self.id)
                
                
                self.valor1 = userModel.valor1
                self.valor2 = userModel.valor2
                
                DB_Manager().updateUser(idValue: self.id, valor1Value: self.valor1, valor2Value: self.valor2)
                
                self.mode.wrappedValue.dismiss()}, label: { Text("Cancelar")}).padding()
            Button(action: {
                
            DB_Manager().updateUser(idValue: self.id, valor1Value: self.valor1, valor2Value: self.valor2)
                
                //Boton en modo de referencia para cambiar las coordenadas, similar a un boton de guardar
                self.mode.wrappedValue.dismiss() }, label: {
                    Text("Cambiar")}).padding()
                .onAppear(perform: {
                    let userModel : UserModel = DB_Manager().getUser(idValue:self.id)
                    
                    
                    self.valor1 = userModel.valor1
                    self.valor2 = userModel.valor2
                })}
        }.navigationTitle("Editar datos")
        }
    }


struct EditUserView_Previews: PreviewProvider {
    @State static var id : Int64 = 0
    
    
    static var previews: some View {
        EditUserView(id : $id)
    }
}
