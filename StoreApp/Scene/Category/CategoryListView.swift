//
//  ViewController.swift
//  StoreApp
//
//  Created by Baris on 6.04.2023.
//

import UIKit

class CategoryListView: UITableViewController {
    //MARK: - UI Elements
    
    
    //MARK: - Properties
    private var service = NetworkManager()
    private var categories: [Category] = []
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        Task {
            await populateCategories()
            tableView.reloadData()
        }
        
    }
    
    //MARK: - Functions
    private func populateCategories() async {
        do {
            categories = try await service.getAllCategories()
            print(categories)
        } catch {
            // show error in alert
        }
    }
    
    private func configure() {
        view.backgroundColor = UIColor.white
        title = "Categories"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryTableViewCell")
    }
    
    //MARK: - Actions
    
}

extension CategoryListView {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath)
        let category =  categories[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        
        var configure = cell.defaultContentConfiguration()
        configure.text = category.name
        
        if let url = URL(string: category.image) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        let image =  UIImage(data: data)
                        configure.image = image
                        configure.imageProperties.maximumSize = CGSize(width: 75, height: 75)
                        cell.contentConfiguration = configure
                    }
                }
            }
        }
        cell.contentConfiguration = configure
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        navigationController?.pushViewController(ProductListView(category: category), animated: true)
    }
}
