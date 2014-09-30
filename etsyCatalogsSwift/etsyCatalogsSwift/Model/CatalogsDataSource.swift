//
//  CatalogsDataSource.swift
//  etsyCatalogsSwift
//
//  Created by Ihonahan Buitrago on 9/19/14.
//  Copyright (c) 2014 Ihonahan Buitrago. All rights reserved.
//

import Foundation

import UIKit


protocol CatalogsDataSourceDelegate
{
    func catalogsDataSourceDidLoadListingCatalogs(catalogDataSource : CatalogsDataSource, count : Int)
    func catalogsDataSourceDidFailWithError(catalogDataSource : CatalogsDataSource, error : NSError?)
    func catalogsDataSourceSelectedDetailsForListingImage(catalogDataSource : CatalogsDataSource, catalogItem : CatalogItem)
}


class CatalogsDataSource: NSObject, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet var listingTable : UITableView!
    
    var delegate : CatalogsDataSourceDelegate!
    var catalogResults : CatalogResult = CatalogResult()
    
    var currentPage : Int = 0
    var currentKeywords : String = ""
    var placeholder : UIImage =  UIImage(named: "transparent-square-th.png")
    
    override init() {
        super.init()
    }


    func rewindPage() {
        if (isValidGoBackward()) {
            currentPage--
            getListPage()
        }
    }


    func isValidGoBackward() -> Bool {
        if (currentPage > 0) {
            return true
        } else {
            reportErrorToDelegate(nil)
            return false
        }
    }
    
    
    func fastForwardPage() {
        if (isValidGoForward()) {
            currentPage++
            getListPage()
        }
    }

    
    func isValidGoForward() -> Bool {
        if (catalogResults.pagination.nextPage > self.currentPage) {
            return true;
        }
        
        reportErrorToDelegate(nil)
        return false;
    }
    
    
    func getInitialListForKeywords(keywords : String) {
        self.currentPage = 0
        self.currentKeywords = keywords
        getListPage()
    }
    
    
    func getListPage() {
        self.listingTable.reloadData()

        CatalogServices.getCatalogListingsByKeywordsAndPage(self.currentKeywords,
            pageNumber: self.currentPage,
            block: { (catalogsResults, error) -> Void in
                if let givenError = error {
                    self.reportErrorToDelegate(error)
                } else {
                    if let givenResults = catalogsResults {
                        self.catalogResults = catalogsResults!
                        self.listingTable.reloadData()
                        
                        if let givenDelegate = self.delegate {
                            self.delegate.catalogsDataSourceDidLoadListingCatalogs(self, count: self.catalogResults.count())
                        }
                    }
                    
                }
        })
    }
    
    
    func reportErrorToDelegate(error: NSError?) {
        if let givenDelegate = self.delegate {
            self.delegate.catalogsDataSourceDidFailWithError(self, error: error)
        }
    }

    func handleDetail(sender : UIButton) {
        let row : Int = sender.tag
        
        let item : CatalogItem = self.catalogResults.getCatalogItemByIndex(row)!
        
        self.delegate?.catalogsDataSourceSelectedDetailsForListingImage(self, catalogItem: item)
    }
    
    func initialSetOfImagesForListingID(listingId : Int) {
        CatalogServices.getListingImagesForListingID(listingId,
            block: { (imagesResult, error) -> Void in
                if let givenError = error {
                    self.reportErrorToDelegate(error)
                } else {
                    if let givenArray : Array<CatalogListingImage> = imagesResult {
                        if givenArray.count > 0 {
                            let imageItem : CatalogListingImage = givenArray[0]
                            let catalogItem : CatalogItem = self.catalogResults.getCatalogItemWithListingID(imageItem.listingID!)!
                            catalogItem.images = givenArray
                            let row : Int = self.catalogResults.findIndexOfItem(catalogItem)
                            if row >= 0 {
                                let indexPath : NSIndexPath = NSIndexPath(forRow: row, inSection: 0)
                                
                                if let cell : UITableViewCell = self.listingTable.cellForRowAtIndexPath(indexPath) {
                                    var imagecell : UIImageView = cell.viewWithTag(110) as UIImageView
                                    imagecell.setImageWithURL(NSURL.URLWithString(imageItem.url170x135!),
                                        placeholderImage: self.placeholder)
                                }
                            }
                        }
                    }
                }
        })
    }
    
    
    // MARK: - UITableViewDatasource and Delegate methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let results = self.catalogResults as CatalogResult? {
            return self.catalogResults.count()
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("ListingTableViewCell", forIndexPath: indexPath) as UITableViewCell
        
        let titleCell : UILabel = cell.viewWithTag(100) as UILabel
        let imageCell : UIImageView = cell.viewWithTag(110) as UIImageView
        let buttonCell : UIButton = cell.viewWithTag(120) as UIButton
        
        buttonCell.tag = indexPath.row
        buttonCell.addTarget(self, action: "handleDetail:", forControlEvents: UIControlEvents.TouchUpInside)
        imageCell.image = self.placeholder
        
        if let item : CatalogItem = self.catalogResults.getCatalogItemByIndex(indexPath.row) {
            titleCell.text = item.itemTitle
            if item.images.count > 0 {
                var catalogImage : CatalogListingImage = item.images[0]
                let urlImg : String = catalogImage.url170x135!
                imageCell.setImageWithURL(NSURL.URLWithString(urlImg))
            } else {
                self.initialSetOfImagesForListingID(item.listingID!)
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    }
    
    
    
}