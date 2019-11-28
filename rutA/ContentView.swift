//
//  ContentView.swift
//  rutA
//
//  Created by Sergio R Escudero Buerba on 22/11/19.
//  Copyright © 2019 Sebastian Escudero. All rights reserved.
//

import SwiftUI

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

let storedMatricula = "123"
let storedPassword = "123"

struct ContentView: View {
    
    @State var matricula: String = ""
    @State var password: String = ""
    
    @State var authenticationFailed: Bool = false
    @State var authenticationSucceed: Bool = false
    
    @State var editingMode: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                WelcomeText()
                logotipo_anahuac()
                MatriculaField(matricula: $matricula, editingMode: $editingMode)
                PasswordField(password: $password)
                if authenticationFailed {
                    Text("Información no coincide. Intentele nuevamente.")
                        .offset(y: -10)
                        .foregroundColor(.red)
                }
                Button(action: {
                        if self.matricula == storedMatricula && self.password == storedPassword {
                            self.authenticationSucceed = true
                            self.authenticationFailed = false
                        } else if self.matricula != storedMatricula || self.password != storedPassword{
                            self.authenticationFailed = true
                            self.authenticationSucceed = false
                        }
                })
                {
                    ContenidoBotonLogin()
                }
            }
            .padding()
            if authenticationSucceed {
                 Text("Ingreso exitoso!")
                    .font(.headline)
                    .frame(width: 250, height: 80)
                    .background(Color.green)
                    .cornerRadius(20.0)
                    .foregroundColor(.white)
                    .animation(Animation.default)
            }
        }
        .offset(y: editingMode ? -150 : 0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct WelcomeText: View {
    var body: some View {
        Text("Bienvenido a")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
    }
}

struct logotipo_anahuac: View {
    var body: some View {
        Image("logotipo_anahuac")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 350, height: 150)
            .clipped()
            //.cornerRadius(150)
            .padding(.bottom, 75)
    }
}

struct ContenidoBotonLogin: View {
    var body: some View {
        Text("INGRESAR")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.orange)
            .cornerRadius(15.0)
    }
}

struct MatriculaField: View {
    
    @Binding var matricula: String
    
    @Binding var editingMode: Bool
    
    var body: some View {
        TextField("Matricula", text: $matricula, onEditingChanged: {edit in
            if edit == true
            {self.editingMode = true}
            else
            {self.editingMode = false}
        })
        .padding()
        .background(lightGreyColor)
        .cornerRadius(5.0)
        .padding(.bottom, 20)
    }
}

struct PasswordField: View {
    
    @Binding var password: String
    
    var body: some View {
        TextField("Contraseña", text: $password)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}
