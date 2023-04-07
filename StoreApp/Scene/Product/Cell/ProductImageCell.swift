//
//  ProductImageCell.swift
//  StoreApp
//
//  Created by Baris on 8.04.2023.
//

import SwiftUI

struct ProductImageCell: View {
    let images: [UIImage]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            HStack {
                ForEach(images, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
            }
        }
    }
    }


struct ProductImageCell_Previews: PreviewProvider {
    static var previews: some View {
        ProductImageCell(images: [])
    }
}
