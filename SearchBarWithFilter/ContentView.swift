//
//  ContentView.swift
//  SearchBarWithFilter
//
//  Created by Ivan Valero on 12/11/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var searchText = ""
    @State var visible = false
    
    
    var body: some View {
        NavigationView {
            VStack{
                
                SearchBar(searchText: $searchText, visible: $visible)
                
                ScrollView {
                    // utiliza el $0 para saber que accede a un valor de la lista para filtrar
                    // esta funcion se puede aplicar aparte
                    ForEach((0..<20).filter({"\($0)".contains(searchText) || searchText.isEmpty}), id: \.self) { num in
                        HStack {
                            Text("\(num)")
                            Spacer()
                            
                        }
                        .padding(.leading, 14)
                        Divider()
                        .padding()
                        
                    }
                }
            }

            .navigationTitle("List")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SearchBar: View {
    
    @Binding var searchText: String
    @Binding var visible: Bool
    
    var body: some View {
        HStack {
            HStack {
                TextField("Search terms here", text: $searchText)
                    .padding(.vertical, 10)
                    .padding(.leading, 32)
                    .background(Color(.systemGray5))
                    .cornerRadius(5)
            }
            .padding(15)
            .onTapGesture {
                // indica cuando se selecciona el buscador
                visible = true
            }
            .overlay(
                // Icono lupa y boton eliminar X
                HStack {
                    
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "magnifyingglass")
                        
                    })
                    
                    Spacer()
                    if visible {
                        Button(action: {
                            searchText = ""
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                            
                        })
                    }
                }.padding(23)
                    .foregroundColor(Color(.systemGray))
                
                
            ).transition(.move(edge: .trailing))
                .animation(.spring(), value: visible)
            
            HStack {
                if visible {
                    Button(action: {
                        visible = false
                        searchText = ""
                        // agregamos esta funcion para hacer desaparecer el teclado
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }, label: {
                        Text("Cancel")
                            .padding(.leading, -12)
                            .padding(.trailing, 15)
                    })
                        .transition(.move(edge: .trailing))
                        .animation(.spring(), value: visible)
                }
            }
            
            
        }
    }
}
