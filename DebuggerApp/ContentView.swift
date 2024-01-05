//
//  ContentView.swift
//  DebuggerApp
//
//  Created by Julio Brazao on 03/01/24.
//

import SwiftUI

struct Item: Identifiable {
    var id: String
    var name: String
    var isActive: Bool
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: SimpleTODOView()) {
                HStack {
                    Text("Simple TODO App")
                    Spacer()
                    Image(systemName: "list.clipboard")
                }
                .padding()
                .fontWeight(.bold)
                .foregroundColor(.black)
                .background(.yellow)
                .cornerRadius(10)
            }
            .navigationTitle("DebuggerApp")
        }
        .padding()
    }
}

struct SimpleTODOView: View {
    @State private var items: [Item] = []
    @State private var itemName = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Enter item description", text: $itemName)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                HStack{
                    Button(action: {
                        addItem(item: "Open Item")
                    }){
                        HStack {
                            Image(systemName: "plus.app")
                            Text("Add Item")
                        }
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    
                    Button(action: {
                        deleteAllItems()
                    }){
                        HStack {
                            Image(systemName: "trash.slash")
                            Text("Clear List")
                        }
                        .padding()
                        .background(.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
            }
            
            Group {
                if (items.count == 0) {
                    VStack {
                        Image(systemName: "shippingbox")
                            .frame(width: 100, height: 100)
                            .padding()
                        Text("No donuts")
                    }
                } else {
                    List {
                        ForEach (items) {item in
                            HStack {
                                Text(item.name)
                                Spacer()
                                Image(systemName: item.isActive ? "x.circle" : "checkmark.circle")
                                    .foregroundColor(item.isActive ? Color.red : Color.green)
                                Image(systemName: "clear.fill").onTapGesture {
                                    removeItem(withId: item.id)
                                }
                            }.onTapGesture {
                                setActiveStatus(forItemId: item.id, isActive: !item.isActive)
                            }
                        }
                    }
                }
            }
            
        }
        .navigationTitle("Simple TODO App")
    }
    
    func addItem(item: String) -> Void {
        self.items.append(Item(id: UUID().uuidString, name: "\(itemName)", isActive: true))
        itemName = ""
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func deleteAllItems() -> Void {
        self.items = []
    }
    
    func removeItem(withId itemId: String) -> Void {
        self.items = self.items.filter { $0.id != itemId }
    }
    
    func setActiveStatus(forItemId itemId: String, isActive: Bool) {
        if let index = items.firstIndex(where: { $0.id == itemId }) {
            items[index].isActive = isActive
        }
    }
}

#Preview {
    SimpleTODOView()
}
