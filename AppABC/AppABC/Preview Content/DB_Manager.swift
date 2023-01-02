//
//  DB_Manager.swift
//  SwiftUI-Sqlite
//
//  Created by IHG on 15/12/22.
//

import Foundation
import SQLite
import UIKit
//Imports necesarios para el funcionamiento
class DB_Manager {
    //Variables privadas necesarias para la conexion a la bd y uso de sus atributos
    private var db: Connection!
    private var users: Table!
    private var id: Expression<Int64>!
    private var valor1: Expression<String>!
    private var valor2: Expression<String>!
    
    
    init() {
        do {
            let path: String =
            NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            db = try Connection("\(path)/my_users.sqlite3")
            //Variables utilizadas para la conexion a sqlite
            users = Table("users")
            //Nombre de la tabla en la bd
            //Atributos que contendra la tabla de la bd
            id = Expression<Int64>("id")
            valor1 = Expression<String>("valor1")
            valor2 = Expression<String>("valor2")
            //Metodo para crear la tabla en caso de que no exista
            if (!UserDefaults.standard.bool(forKey: "is_db_created")) {
                try db.run(users.create { (t) in t.column(id, primaryKey: true)
                    t.column(valor1)
                    t.column(valor2)
                    
                })
                
                UserDefaults.standard.set(true, forKey: "is_db_created")
            }
        } catch{
            print(error.localizedDescription)
        }
    }
    
    //Funcion para agregar coordenadas utilizando 2 parametros: longitud de tipo cadena y latitud de tipo cadena
    public func addUser (pvalor1: String, pvalor2: String) {
        do {
            try db.run(users.insert(valor1 <- pvalor1, valor2 <- pvalor2))
        } catch {
            print(error.localizedDescription)
        }
    }
    //Funcion para obtener toda la informacion de la tabla users, utilizando un modelo de la base de datos
    public func getUsers() -> [UserModel] {
        var userModels: [UserModel] = []
        users = users.order(id.desc)
        do {
            for user in try db.prepare(users) {
                let userModel: UserModel = UserModel()
                //En el modelo obtenemos los valores de cada columna en la tabla
                userModel.id = user[id]
                userModel.valor1 = user[valor1]
                userModel.valor2 = user[valor2]
                userModels.append(userModel)
            }
        } catch {
            print(error.localizedDescription)
        }
        return userModels
    }
    //Funcion para obtener el valor de un solo usuario (coordenadas) utilizando un parametro de tipo Int64
    public func getUser(idValue: Int64) -> UserModel {
        let userModel : UserModel = UserModel()
        do {
            let user : AnySequence<Row> = try db.prepare(users.filter(id == idValue))
            try user.forEach({
                //Se obtienen  los valores de las columnas de la bd
                (rowValue ) in userModel.id = try rowValue.get(id)
                userModel.valor1 = try rowValue.get (valor1)
                userModel.valor2  = try rowValue.get (valor2)
            })
        } catch {
            print(error.localizedDescription)
        }
    return userModel
    }
    
    //Funcion para actualizar datos de un registro en la bd, utilizando 3 parametros, uno de tipo Int64, cadena, cadena.
    public func updateUser (idValue: Int64, valor1Value: String, valor2Value: String ) {
        do {
            let user :Table = users.filter (id == idValue)
            try db.run(user.update(valor1 <- valor1Value, valor2 <- valor2Value))
            //Metodo update recibe 2 parametros para actualizarlos en la bd, son 3 pero 1 de ellos es la primary key el cual no debe de cambiar
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //Funcion para eliminar un registro en la bd utilizando un parametro del tipo Int64
    public func deleteUser(idValue: Int64) {
        do { let user: Table = users.filter(id == idValue)
            try db.run(user.delete())
        } catch {
            print(error.localizedDescription)
        }
    }
}
