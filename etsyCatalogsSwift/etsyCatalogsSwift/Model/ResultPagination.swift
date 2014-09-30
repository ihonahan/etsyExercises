//
//  ResultPagination.swift
//  etsyCatalogsSwift
//
//  Created by Ihonahan Buitrago on 9/19/14.
//  Copyright (c) 2014 Ihonahan Buitrago. All rights reserved.
//

import Foundation

class ResultPagination : NSObject
{
    var pageLimit : Int? = 0
    var currentOffset : Int? = 0
    var nextOffset : Int? = 0
    var currentPage : Int? = 0
    var nextPage : Int? = 0
    var totalCount : Int? = 0
    
    class func createCatalogListingImageFromDictionary(pageDictionary : Dictionary<String, AnyObject>) -> ResultPagination
    {
        var item : ResultPagination = ResultPagination()
        
        item.pageLimit = pageDictionary["effective_limit"] as AnyObject? as? Int
        item.currentOffset = pageDictionary["effective_offset"] as AnyObject? as? Int
        item.nextOffset = pageDictionary["next_offset"] as AnyObject? as? Int
        item.currentPage = pageDictionary["effective_page"] as AnyObject? as? Int
        item.nextPage = pageDictionary["next_page"] as AnyObject? as? Int
        item.totalCount = pageDictionary["count"] as AnyObject? as? Int
        
        return item
    }
    
}