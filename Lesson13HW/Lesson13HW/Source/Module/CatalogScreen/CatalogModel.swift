//
//  CatalogModel.swift
//  Lesson13HW
//

//

import Foundation

protocol CatalogModelDelegate: AnyObject {
    
    func dataDidLoad()
}

class CatalogModel {
    
    weak var delegate: CatalogModelDelegate?
    private let dataLoader = DataLoaderService()
    private let localStorage = LocalStorageService()
    
    var pcItems: [Pc] = []
    
    func loadData() {
        dataLoader.loadCatalog { [weak self] catalog in
            guard let self = self else { return }
            
            let loadedItems = catalog?.data ?? []
            
            let favoriteItems = self.localStorage.getFavorites()
            let loadedItemsWithFavorites = self.updateItemsWithFavorites(loadedItems, favoriteItems: favoriteItems)
            
            self.pcItems = loadedItemsWithFavorites
            self.delegate?.dataDidLoad()
        }
    }
    
    private func updateItemsWithFavorites(_ items: [Pc], favoriteItems: [Favorite]) -> [Pc] {

        let favoriteIds = Set(favoriteItems.map { $0.id })
        
        
        var updatedItems = items
        for (index, item) in updatedItems.enumerated() {
            if favoriteIds.contains(item.id) {
                updatedItems[index].isFavorite = true
            }
        }
        
        return updatedItems
    }
    
    func updateItem(with isFavorite: Bool, at index: Int) {
        pcItems[index].isFavorite = isFavorite
    }
    
    func saveChangesIfNeeded() {
        
        let favoriteItems = getFavoriteItems()
        let savedItems = localStorage.getFavorites()
        
        guard savedItems != favoriteItems else { return }
        
        let totlaSet: Set<Favorite> = Set(savedItems + favoriteItems)
        
        localStorage.saveFavorites(Array(totlaSet))
    }
    
    private func getFavoriteItems() -> [Favorite] {
        
        return pcItems.filter({ $0.favorite() }).compactMap {
            Favorite(
                id: $0.id,
                name: $0.name,
                manufacturer: $0.manufacturer,
                model: $0.model
            )
        }
    }
}
