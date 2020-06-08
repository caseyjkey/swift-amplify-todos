//
//  ContentView.swift
//  Todo
//
//  Created by Key, Casey on 6/7/20.
//  Copyright © 2020 Key, Casey. All rights reserved.
//

import SwiftUI
import Amplify
import AmplifyPlugins

struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
            .onAppear {
                self.performOnAppear()
        }
    }
    
    func performOnAppear() {
        Amplify.DataStore.query(Todo.self,
                                where: Todo.keys.priority.eq(Priority.high.rawValue),
                                completion: { result in
            switch(result) {
            case .success(let todos):
                guard todos.count == 1, var toDeleteTodo = todos.first else {
                    print("Did not find exactly one todo, bailing")
                    return;
                }
                Amplify.DataStore.delete(toDeleteTodo,
                                       completion: { result in
                                        switch(result) {
                                        case .success(let savedTodo):
                                            print("Deleted item: \(toDeleteTodo.name)")
                                        case .failure(let error):
                                            print("Could not update data in Datastore: \(error)")
                                        }
                })
            case .failure(let error):
                print("Could not query DataStore: \(error)")
            }
        })
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
