//
//  ContentView.swift
//  AppABC
//
//  Created by IHG on 01/01/23.
//

import SwiftUI

struct ContentView: View {
    //Arreglo para visualizar los datos
    @State var userModels: [UserModel] = []
    
    @State var userSelected: Bool = false
    
    @State var selectedUserId: Int64 = 0
    
    @State var Alert = false
    
    var body: some View {
    
   
    
    //Creacion de vista de navegacion
    NavigationView {
        VStack{
            HStack{
                Spacer()
                NavigationLink(destination: AddUserView(), label: { Text("Agregar valor").padding()
                    
                })
                
            }
        
            NavigationLink (destination: EditUserView(id: self.$selectedUserId), isActive: self.$userSelected)
            {
                EmptyView()
            }
        
        List (self.userModels) {
            (model) in
            HStack{
                Spacer()
                Text(model.valor1)
                Spacer()
                Text(model.valor2)
                
                Button(action: {
                    self.selectedUserId = model.id
                    self.userSelected = true }, label: { Text("Edit").foregroundColor(Color.blue)
                        
                    }).buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    Alert = true }, label: {Text("Borrar").foregroundColor(Color.red)})
                    .confirmationDialog("¿Estas seguro?", isPresented: $Alert, titleVisibility: .visible) {
                        Button("Borrar", role: .destructive) {
                            let dbManager: DB_Manager = DB_Manager()
                            
                            dbManager.deleteUser(idValue: model.id)
                            
                            self.userModels = dbManager.getUsers()
                        
                        }
                    }
                    /*.alert("Estas segur@?", isPresented: $Alert) {
                        Button(action: {
                            
                            let dbManager: DB_Manager = DB_Manager()
                            
                            dbManager.deleteUser(idValue: model.id)
                            
                            self.userModels = dbManager.getUsers()
                        
                        }, label: {
                            Text("Delete").foregroundColor(Color.red)}).foregroundColor(Color.red)
                    }*/
                    
            }
        
    }.padding()
    
        
            .onAppear(perform: { self.userModels =
                DB_Manager().getUsers()
            })
        
            HStack {
            NavigationLink(destination: Acercade(), label: {
                Text("Acerca de").padding()
            })
                
            }
        }.navigationBarTitle("Sistema ABC")
    }
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
