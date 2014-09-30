//
//  MasterViewController.swift
//  etsyCatalogsSwift
//
//  Created by Ihonahan Buitrago on 9/19/14.
//  Copyright (c) 2014 Ihonahan Buitrago. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, CatalogsDataSourceDelegate, UITextFieldDelegate {

    @IBOutlet weak var searchText : UITextField!
    @IBOutlet weak var catalogsDatasource : CatalogsDataSource!
    @IBOutlet weak var loadingView : UIActivityIndicatorView!


    var detailViewController: DetailViewController? = nil
    var objects = NSMutableArray()


    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 420.0, height: 600.0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let pageUpButton : UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Rewind,
            target: self,
            action: Selector(previousPage()))
        self.navigationItem.leftBarButtonItem = pageUpButton
        
        let pageDownButton : UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FastForward,
            target: self,
            action: Selector(nextPage()))
        self.navigationItem.rightBarButtonItem = pageDownButton
        
        self.navigationItem.titleView?.frame = self.searchText.frame
        
        self.loadingView.stopAnimating()
        self.loadingView.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Private methods
    private func previousPage() {
        self.catalogsDatasource.rewindPage()
        self.loadingView.startAnimating()
        self.loadingView.hidden = false
    }
    
    private func nextPage() {
        self.catalogsDatasource.fastForwardPage()
        self.loadingView.startAnimating()
        self.loadingView.hidden = false
    }


    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            if self.catalogsDatasource.catalogResults.count() > 0 {
                let detailButton = sender as UIButton
                if let item : CatalogItem = self.catalogsDatasource.catalogResults.getCatalogItemByIndex(detailButton.tag)? {
                    let detailViewController : DetailViewController = segue.destinationViewController.topViewController as DetailViewController
                    detailViewController.detailItem = item
                    detailViewController.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                    detailViewController.navigationItem.leftItemsSupplementBackButton = true
                }
                
                
            }
        }
    }
    
    
    // MARK: - UITextFieldDelegate methods
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let keywords = textField.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if keywords != "" {
            self.catalogsDatasource.getInitialListForKeywords(keywords)
            self.loadingView.startAnimating()
            self.loadingView.hidden = false
        }
        
        textField.resignFirstResponder()
        
        return true
    }
    
    
    // MARK: - CatalogsDataSourceDelegate methods
    func catalogsDataSourceDidFailWithError(catalogDataSource: CatalogsDataSource, error: NSError?) {
        
    }

    func catalogsDataSourceDidLoadListingCatalogs(catalogDataSource: CatalogsDataSource, count: Int) {

    }
    
    func catalogsDataSourceSelectedDetailsForListingImage(catalogDataSource: CatalogsDataSource, catalogItem: CatalogItem) {

    }

}

