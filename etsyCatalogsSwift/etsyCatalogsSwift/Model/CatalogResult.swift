//
//  CatalogResult.swift
//  etsyCatalogsSwift
//
//  Created by Ihonahan Buitrago on 9/22/14.
//  Copyright (c) 2014 Ihonahan Buitrago. All rights reserved.
//

import Foundation

class CatalogResult : NSObject
{
    var pagination : ResultPagination = ResultPagination()
    var listingResults : [CatalogItem] = []

    
    override init()
    {
        super.init()
    }

    
    func insertPaginationInfo(dictionary : Dictionary<String, AnyObject>, count : Int)
    {
        var pageDictionary : Dictionary<String, AnyObject> = dictionary
        pageDictionary.updateValue(count, forKey: "count")
        self.pagination = ResultPagination.createCatalogListingImageFromDictionary(pageDictionary)
    }
    
    
    func insertCatalogItem(dictionary : Dictionary<String, AnyObject>)
    {
        var item : CatalogItem = CatalogItem.createCatalogItemFromDictionary(dictionary)
        
        self.listingResults.append(item)
    }
    
    
    func getCatalogItemWithListingID(listingId : Int) -> CatalogItem?
    {
        var idList : Int? = 0
        for item: CatalogItem in self.listingResults {
            idList = item.listingID;
            
            if idList == listingId {
                return item
            }
        }
        
        return nil
    }
    
    func getCatalogItemByIndex(index : Int) -> CatalogItem?
    {
        if index < self.listingResults.count {
            return self.listingResults[index]
        } else {
            return nil
        }
    }
    
    
    func getAllCatalogs() -> Array<CatalogItem>
    {
        return self.listingResults
    }
    
    
    func count() -> Int
    {
        return self.listingResults.count
    }
    
    
    func findIndexOfItem(item : CatalogItem) -> Int
    {
        var i = 0
        for listItem in self.listingResults {
            if listItem == item {
                return i
            }
            i++;
        }
        
        return -1
    }
}


