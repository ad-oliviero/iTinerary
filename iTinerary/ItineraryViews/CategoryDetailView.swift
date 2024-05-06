//
//  CategoryDetailView.swift
//  iTravel
//
//  Created by Daniela Landolfo on 06/05/24.
//

import SwiftUI



struct CategoryDetailView: View {
    var selectedCategories: [String: Bool]
    let categoryName: String
    let index: Int
    
    var body: some View {
        NavigationStack {
            VStack {
                
            }
          
            .navigationTitle("\(categoryName)")
            .navigationBarItems(
                trailing: NavigationLink(destination: NextCategoryDetailView(selectedCategories: selectedCategories, currentIndex: index)) {
                    HStack {
                        Text("Next")
                        Image(systemName: "chevron.right")
                            .font(.system(size: 15))
                            .font(.title)
                    }
                }
            )
        }
    }
}

struct NextCategoryDetailView: View {
    var selectedCategories: [String: Bool]
    let currentIndex: Int
    
    var body: some View {
        let categoryKeys = selectedCategories.filter { $0.value }.keys.sorted()
        let nextIndex = currentIndex + 1
        if nextIndex < categoryKeys.count {
            let nextCategoryName = categoryKeys[nextIndex]
            return AnyView(CategoryDetailView(selectedCategories: selectedCategories, categoryName: nextCategoryName, index: nextIndex))
        } else {
            // Handle if there's no next category
            return AnyView(RecapView())
        }
    }
}


#Preview {
  CategoryDetailView(selectedCategories: [:], categoryName: "", index: 0)
}
