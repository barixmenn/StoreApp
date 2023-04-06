//
//  CategoryPickerView.swift
//  StoreApp
//
//  Created by Baris on 7.04.2023.
//

import SwiftUI

struct CategoryPickerView: View {
    
    let client = NetworkManager()
    @State private var categories: [Category] = []
    @State private var selectedCategory: Category?
    
    let onSelected: (Category) -> Void
    
    var body: some View {
        Picker("Categories", selection: $selectedCategory) {
            ForEach(categories, id: \.id) { category in
                Text(category.name).tag(Optional(category))
            }
        }
        .onChange(of: selectedCategory, perform: { category in
            if let category {
                onSelected(category)
            }
        })
        .pickerStyle(.wheel)
            .task {
                do {
                    categories = try await client.getAllCategories()
                    selectedCategory = categories.first
                } catch {
                    print(error)
                }
            }
    }
}

struct CategoryPickerView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryPickerView(onSelected: { _ in })
    }
}
