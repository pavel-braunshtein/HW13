//
//  CatalogViewController.swift
//  Lesson13HW
//

//

import UIKit

class CatalogViewController: UIViewController {
    
    @IBOutlet weak var contentView: CatalogView!
    var model: CatalogModel!
    
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
        
        title = "Catalog"
        
        model = CatalogModel()
        model.delegate = self
        
        contentView.delegate = self
        
        contentView.tableView.dataSource = self
//        contentView.tableView.delegate = self
        
        contentView.tableView.registerInfoCell()
    }
}

// MARK: - CatalogModelDelegate
extension CatalogViewController: CatalogModelDelegate {
    
    func dataDidLoad() {
        contentView.tableView.reloadData()
    }
}

// MARK: - CatalogViewDelegate
extension CatalogViewController: CatalogViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension CatalogViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.pcItems.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell") as? InfoCell
        else {
            assertionFailure()
            return UITableViewCell()
        }
        
        let item = model.pcItems[indexPath.row]
        
        cell.productСode.text = "Код товару: \(item.id)"
        cell.productName.text = item.name
        cell.productManufactured.text = item.manufacturer
        cell.productModel.text = item.model
        cell.productPrice.text = String(item.price)
        cell.productCurrency.text = item.currency
        
        
        let filledStar = UIImage(systemName: "star.fill")
        let emptyStar = UIImage(systemName: "star")

        let starImageViews = [cell.star1, cell.star2, cell.star3, cell.star4, cell.star5]

        for (index, starImageView) in starImageViews.enumerated() {
            if index < item.rating {
                print()
                starImageView?.image = filledStar
            } else {
                starImageView?.image = emptyStar
            }
        }

        if item.isFavorite ?? false {
            cell.productIsFavoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            cell.productIsFavoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
        cell.isFavoriteAction = { [weak self] in
            guard let self = self else { return }
            
            let isFavorite = !self.model.pcItems[indexPath.row].favorite()
            self.model.updateItem(with: isFavorite, at: indexPath.row)

            if isFavorite {
                cell.productIsFavoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                cell.productIsFavoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }


        
        return cell
    }
}
