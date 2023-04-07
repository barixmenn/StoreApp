//
//  ProductDetailController.swift
//  StoreApp
//
//  Created by Baris on 8.04.2023.
//

import Foundation
import UIKit

class ProductDetailController: UIViewController {
    //MARK: - UI Elements
    private let product : Product
    
    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Properties

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var deleteProductButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Delete", for: .normal)
        return button
    }()
 
    
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //MARK: - Functions
    
    private func configure() {
        view.backgroundColor = UIColor.white
        title = product.title
        
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.text = product.description
        priceLabel.text = product.price.formatAsCurrency()
        
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(deleteProductButton)
        
        view.addSubview(stackView)
        
        // adding constraints
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    //MARK: - Actions

}
