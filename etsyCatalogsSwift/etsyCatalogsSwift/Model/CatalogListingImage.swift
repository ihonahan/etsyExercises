//
//  CatalogListingImage.swift
//  etsyCatalogsSwift
//
//  Created by Ihonahan Buitrago on 9/19/14.
//  Copyright (c) 2014 Ihonahan Buitrago. All rights reserved.
//

import Foundation

class CatalogListingImage : NSObject
{
    var listingID : Int? = 0
    var listingImageID : Int? = 0
    var hexCode : String? = ""
    var red : Int? = 0
    var green : Int? = 0
    var blue : Int? = 0
    var hue : Int? = 0
    var saturation : Int? = 0
    var brightness : Int? = 0
    var fullWidth : Double? = 0
    var fullHeight : Double? = 0
    var url75x75 : String? = ""
    var url170x135 : String? = ""
    var url570xN : String? = ""
    var urlFullSize : String? = ""
    
    class func createCatalogListingImageFromDictionary(imageDictionary : Dictionary<String, AnyObject>) -> CatalogListingImage
    {
        var item : CatalogListingImage = CatalogListingImage()
        
        item.listingID = imageDictionary["listing_id"] as AnyObject? as? Int
        item.listingImageID = imageDictionary["listing_iamge_id"] as AnyObject? as? Int
        item.hexCode = imageDictionary["hex_code"] as AnyObject? as? String
        item.red = imageDictionary["red"] as AnyObject? as? Int
        item.green = imageDictionary["green"] as AnyObject? as? Int
        item.blue = imageDictionary["blue"] as AnyObject? as? Int
        item.hue = imageDictionary["hue"] as AnyObject? as? Int
        item.saturation = imageDictionary["saturation"] as AnyObject? as? Int
        item.brightness = imageDictionary["brightness"] as AnyObject? as? Int
        item.fullWidth = imageDictionary["full_width"] as AnyObject? as? Double
        item.fullHeight = imageDictionary["full_height"] as AnyObject? as? Double
        item.url75x75 = imageDictionary["url_75x75"] as AnyObject? as? String
        item.url170x135 = imageDictionary["url_170x135"] as AnyObject? as? String
        item.url570xN = imageDictionary["url_570xN"] as AnyObject? as? String
        item.urlFullSize = imageDictionary["url_fullxfull"] as AnyObject? as? String
        
        return item
    }
    
}