//
//  ModelUtilities.swift
//  etsyCatalogsSwift
//
//  Created by Ihonahan Buitrago on 9/22/14.
//  Copyright (c) 2014 Ihonahan Buitrago. All rights reserved.
//

import Foundation

struct ModelUtilities
{
    static let kApiKey : String = "wzqjy1uwfvsb69sgnr2j1f3y"
    
    static let kErrorCodeNoResultsFound : Int = 4020
    static let kErrorCodeBadResponse : Int = 4001
    
    static let kPageItemsize : Int = 20
    
    static let kPreferredImageWidth : CGFloat = 285.0
    
    static let kServicesUrl : String = "https://openapi.etsy.com/v2/"
    static let kListingService : String = "listings/active?api_key=%@&keywords='%@'&offset=%d&limit=%d"
    static let kListingImagesService : String = "listings/%lld/images?api_key=%@"
    static let kListingModelErrorDomain : String = "com.ihonahan.etsycatalogs.listing"
}