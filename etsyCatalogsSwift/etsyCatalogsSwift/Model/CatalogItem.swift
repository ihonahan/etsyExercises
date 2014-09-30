//
//  CatalogItem.swift
//  etsyCatalogsSwift
//
//  Created by Ihonahan Buitrago on 9/19/14.
//  Copyright (c) 2014 Ihonahan Buitrago. All rights reserved.
//

import Foundation

class CatalogItem: NSObject
{
    var listingID : Int? = 0
    var userID : Int? = 0
    var categoryID : Int? = 0
    var itemTitle : String? = ""
    var itemDescription : String? = ""
    var currency : String? = ""
    var price : Double? = 0
    var quantity : Int? = 0
    var url : String? = ""
    var whenMade : String? = ""
    var images : [CatalogListingImage] = []
    
    
    override init() {
        super.init()
    }
    
    class func createCatalogItemFromDictionary(itemDictionary : Dictionary<String, AnyObject>) -> CatalogItem
    {
        var item : CatalogItem = CatalogItem()
     
        item.listingID = itemDictionary["listing_id"] as AnyObject? as? Int
        item.userID = itemDictionary["user_id"] as AnyObject? as? Int
        item.categoryID = itemDictionary["category_id"] as AnyObject? as? Int
        item.itemTitle = itemDictionary["title"] as AnyObject? as? String
        item.itemDescription = itemDictionary["description"] as AnyObject? as? String
        item.currency = itemDictionary["currency_code"] as AnyObject? as? String
        item.price = itemDictionary["price"] as AnyObject? as? Double
        item.quantity = itemDictionary["quantity"] as AnyObject? as? Int
        item.url = itemDictionary["url"] as AnyObject? as? String
        item.whenMade = itemDictionary["when_made"] as AnyObject? as? String
        item.images = []

        return item
    }
    
}