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
import Combine

struct ContentView: View {
    @State var todoSubscription: AnyCancellable?
    
    var body: some View {
        Text("Hello, World!")
            .onAppear {
                self.performOnAppear()
        }
    }
    
    func performOnAppear() {
        subscribeTodos()
    }
    
    func subscribeTodos() {
        self.todoSubscription
            = Amplify.DataStore.publisher(for: Todo.self)
                .sink(receiveCompletion: { completion in
                    print("Subscription has been completed: \(completion)")
                }, receiveValue: { mutationEvent in
                    print("Subscription got this value: \(mutationEvent)")
                })
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
