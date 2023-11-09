//
//  Home.swift
//  WellNest
//
//  Created by Joshua Truong on 9/14/23.
//

import SwiftUI
import SwiftData
import MapKit

// https://www.youtube.com/watch?v=gy6rp_pJmbo
struct HomeView: View {
    @ObservedObject var viewModel = TodoViewModel()
    //@Environment(\.modelContext) private var context
    //@Query private var todosSection: TodosSection
    var body: some View {
        NavigationStack {
            List{
                ForEach(viewModel.todos) { todo in
                    TodoView(todo: todo)
                }
                .onDelete(perform: viewModel.deleteTodo(indexSet:))
                .onMove(perform: viewModel.moveTodo(indexSet:index:))
            }
            .navigationTitle("Todos")
            .toolbar {
                ToolbarItem {
                    Button {
                        viewModel.addTodo()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
