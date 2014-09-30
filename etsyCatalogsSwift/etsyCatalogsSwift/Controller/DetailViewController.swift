//
//  DetailViewController.swift
//  etsyCatalogsSwift
//
//  Created by Ihonahan Buitrago on 9/19/14.
//  Copyright (c) 2014 Ihonahan Buitrago. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceTitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionView: UILabel!

    var detailItem : CatalogItem = CatalogItem()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func configureDetailView()
    {
        self.titleLabel.text = self.detailItem.itemTitle
        self.priceTitleLabel.text = NSLocalizedString("Price: $", comment: "")
        self.priceLabel.text = String(format: "%.2f", self.detailItem.price!)
        self.descriptionView.text = self.detailItem.itemDescription
        
        
    }

}

