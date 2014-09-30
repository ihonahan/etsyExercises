//
//  CatalogListingImageView.swift
//  etsyCatalogsSwift
//
//  Created by Ihonahan Buitrago on 9/30/14.
//  Copyright (c) 2014 Ihonahan Buitrago. All rights reserved.
//

import Foundation

class CatalogListingImageView: UIImageView
{

    init(imageItem : CatalogListingImage, point : CGPoint) {
        
        super.init()
        
        var scale : CGFloat = 1;
        
        if UIScreen.mainScreen().respondsToSelector("scale") == true {
            scale = UIScreen.mainScreen().scale
        }
        
        var w : CGFloat = CGFloat(imageItem.fullWidth!) / scale
        var h : CGFloat = CGFloat(imageItem.fullHeight!) / scale
        
        var imgW : CGFloat = ModelUtilities.kPreferredImageWidth
        var imgH : CGFloat = (h * imgW) / w
        
        self.frame = CGRectMake(point.x, point.y, imgW, imgH)
        self.contentMode = UIViewContentMode.ScaleAspectFit
        
        var url : NSURL = NSURL(string: imageItem.urlFullSize!)
        self.setImageWithURL(url)
    }
    

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}