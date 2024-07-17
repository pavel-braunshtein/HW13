//
//  FavoriteViewController.swift
//  Lesson13HW
//

//

import UIKit

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var contentView: FavoriteView!
    var model: FavoriteModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        model.loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        model.saveChangesIfNeeded()
    }
    
    private func setupInitialState() {
        
        title = "Favorite"
        
        model = FavoriteModel()
        model.delegate = self
        
        contentView.delegate = self
        
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        
        contentView.tableView.registerFavoriteCell()
    }
}

// MARK: - FavoriteModelDelegate
extension FavoriteViewController: FavoriteModelDelegate {
    
    func dataDidLoad() {
        contentView.tableView.reloadData()
    }
}

// MARK: - FavoriteViewDelegate
extension FavoriteViewController: FavoriteViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension FavoriteViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.favoriteItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell") as? FavoriteCell
        else {
            assertionFailure()
            return UITableViewCell()
        }
        
        let item = model.favoriteItems[indexPath.row]
        
        cell.productCode.text = "Код товару: \(item.id)"
        cell.productName.text = item.name
        cell.productManufactured.text = item.manufacturer
        cell.productModel.text = item.model
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            model.removeFromFavorite(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: - UITableViewDelegate
extension FavoriteViewController: UITableViewDelegate {
    
}
