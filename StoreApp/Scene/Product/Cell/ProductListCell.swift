//
//  ProductListCell.swift
//  StoreApp
//
//  Created by Baris on 7.04.2023.
//

import SwiftUI

struct ProductListCell: View {
    var product : Product
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            VStack(alignment: .leading) {
                Text(product.title).bold()
                Text(product.description)
            }
            Spacer()
            Text(product.price, format: .currency(code: "USD"))
                .padding(5)
                .background {
                    Color.green
                }
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            
        }
    }
}

struct ProductListCell_Previews: PreviewProvider {
    static var previews: some View {
           ProductListCell(product: Product(id: 1, title: "Handmade Fresh Table", price: 345, description: "Andy shoes are designed to keeping in", images: [URL(string: "https://placeimg.com/640/480/any?r=0.9178516507833767")!], category: Category(id: 1, name: "Clothes", image: "https://placeimg.com/640/480/any?r=0.9178516507833767")))
       }
}
