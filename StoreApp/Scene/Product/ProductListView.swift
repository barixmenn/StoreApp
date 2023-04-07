//
//  ProductListView.swift
//  StoreApp
//
//  Created by Baris on 6.04.2023.
//

import Foundation
import UIKit
import SwiftUI

class ProductListView: UITableViewController {
    
    //MARK: - UI Elements
    lazy var addProductBarItemButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addProductButtonPressed))
        return barButtonItem
    }()
    //MARK: - Properties
    
    private var category: Category
    private var service = NetworkManager()
    private var products: [Product] = []
    
    init(category: Category) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        Task {
            await populateProducts()
            
        }
    }
    
    
    //MARK: - Functions
    private func populateProducts() async {
        do {
            products = try await service.getProductsByCategory(categoryId: category.id)
            tableView.reloadData()
        } catch {
            print(error)
        }
    }
    
    private func configure(){
        title = category.name
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ProductTableViewCell")
        navigationItem.rightBarButtonItem = addProductBarItemButton
    }
    
}

//MARK: - Selector
extension ProductListView {
    @objc private func addProductButtonPressed(_ sender: UIBarButtonItem) {
        let addProductVC = AddProductViewController()
        let navigationController = UINavigationController(rootViewController: addProductVC)
        present(navigationController, animated: true)
    }
    
}


//MARK: - TableView Delagates
extension ProductListView {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        
        let product = products[indexPath.row]
        
        cell.contentConfiguration = UIHostingConfiguration(content: {
            ProductListCell(product: product)
        })
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        navigationController?.pushViewController(ProductDetailController(product: product), animated: true)
    }
    
}



extension ProductListView: AddProductViewControllerDelegate {
    
    func addProductViewControllerDidCancel(controller: AddProductViewController) {
        controller.dismiss(animated: true)
    }
    
    func addProductViewControllerDidSave(product: Product, controller: AddProductViewController) {
        
        let createProductRequest = CreateProduct(product: product)
        
        Task {
            do {
                let newProduct = try await service.createProduct(productRequest: createProductRequest)
                products.insert(newProduct, at: 0)
                tableView.reloadData()
                controller.dismiss(animated: true)
            } catch {
                print(error)
            }
        }
        
    }
    
}
