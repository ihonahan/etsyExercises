//
//  CatalogServices.swift
//  etsyCatalogsSwift
//
//  Created by Ihonahan Buitrago on 9/22/14.
//  Copyright (c) 2014 Ihonahan Buitrago. All rights reserved.
//

import Foundation


class CatalogServices : NSObject
{
    
    class func getCatalogListingsByKeywordsAndPage(keywords : String, pageNumber : Int, block : ((catalogsResults : CatalogResult?, error : NSError?) -> Void)! ) {
        if let responseBlock = block {
            let pageOffset : Int = ModelUtilities.kPageItemsize * pageNumber
            var url : String = ModelUtilities.kServicesUrl + ModelUtilities.kListingService
            url = String(format: url, ModelUtilities.kApiKey, keywords, pageOffset, ModelUtilities.kPageItemsize)
            var manager : AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
            
            manager.GET(url,
                parameters: nil,
                success: { (operation , responseObject) -> Void in
                    if let response : AnyObject = responseObject? {
                        if let responseDict = response as? Dictionary<String, AnyObject> {
                            var count : Int = responseDict["count"] as AnyObject? as Int
                            var pagination : Dictionary<String, AnyObject> = responseDict["pagination"] as AnyObject? as Dictionary<String, AnyObject>
                            
                            if count > 0 {
                                var catalogResult : CatalogResult = CatalogResult()
                                
                                catalogResult.insertPaginationInfo(pagination, count: count)
                                
                                var resultsArray : Array<AnyObject> = responseDict["results"] as AnyObject? as Array<AnyObject>
                                
                                for resultAny : AnyObject in resultsArray {
                                    var result : Dictionary<String, AnyObject> = resultAny as Dictionary<String, AnyObject>
                                    catalogResult.insertCatalogItem(result)
                                }
                                
                                block(catalogsResults: catalogResult, error: nil)
                            } else {
                                let givenError = CatalogServices.buildErrorWithCode(ModelUtilities.kErrorCodeNoResultsFound,
                                    description: NSLocalizedString("No results found", comment: ""))
                                block(catalogsResults: nil, error: givenError)
                            }
                        } else {
                            let givenError = CatalogServices.buildErrorWithCode(ModelUtilities.kErrorCodeBadResponse,
                                description: NSLocalizedString("Bad response from server", comment: ""))
                            block(catalogsResults: nil, error: givenError)
                        }
                    }
                },
                failure: { (operation, error) -> Void in
                    block(catalogsResults: nil, error: error)
            })
            
        }
    }
    
    
    class func getListingImagesForListingID(listingId : Int, block : ((imagesResult : Array<CatalogListingImage>?, error : NSError?) -> Void)! ) {
        if let responseBlock = block {
            var url : String = ModelUtilities.kServicesUrl + ModelUtilities.kListingImagesService
            url = String(format: url, listingId, ModelUtilities.kApiKey)
            var manager : AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
            
            manager.GET(url,
                parameters: nil,
                success: { (operation, responseObject) -> Void in
                    if let response : AnyObject = responseObject? {
                        if let responseDict = response as? Dictionary<String, AnyObject> {
                            var count : Int = responseDict["count"] as AnyObject? as Int
                            
                            if count > 0 {
                                var images : Array<CatalogListingImage> = []
                                var resultsArray : Array<AnyObject> = responseDict["results"] as AnyObject? as Array<AnyObject>
                                
                                for resultAny : AnyObject in resultsArray {
                                    var result : Dictionary<String, AnyObject> = resultAny as Dictionary<String, AnyObject>
                                    var item : CatalogListingImage = CatalogListingImage.createCatalogListingImageFromDictionary(result)
                                    images.append(item)
                                }
                                
                                block(imagesResult: images, error: nil)
                            } else {
                                let givenError = CatalogServices.buildErrorWithCode(ModelUtilities.kErrorCodeNoResultsFound,
                                    description: NSLocalizedString("No results found", comment: ""))
                                block(imagesResult: nil, error: givenError)
                            }
                        } else {
                            let givenError = CatalogServices.buildErrorWithCode(ModelUtilities.kErrorCodeBadResponse,
                                description: NSLocalizedString("Bad response from server", comment: ""))
                            block(imagesResult: nil, error: givenError)
                        }
                    }
                },
                failure: { (operation, error) -> Void in
                    block(imagesResult: nil, error: error)
            })
        }
    }
    
    
    
    
    
    // Mark: - Private methods
    private class func buildErrorWithCode(code : Int, description : String) -> NSError {
        let userInfo = [NSLocalizedDescriptionKey : description]
        var error : NSError = NSError(domain: ModelUtilities.kListingModelErrorDomain,
            code: code,
            userInfo: userInfo)
        return error
    }
    
}