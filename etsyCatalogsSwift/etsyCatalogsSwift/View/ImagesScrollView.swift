//
//  ImagesScrollView.swift
//  etsyCatalogsSwift
//
//  Created by Ihonahan Buitrago on 9/30/14.
//  Copyright (c) 2014 Ihonahan Buitrago. All rights reserved.
//

import Foundation

class ImagesScrollView: UIScrollView
{
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    func buildImages(fromArray : Array<CatalogListingImage>, heightAdjust : Boolean) {
        var x : CGFloat = 4
        var y : CGFloat = 0
        var i : Int = 0
        var maxHeight : CGFloat = 0
        
        for(i = 0; i < fromArray.count; i++) {
            var image : CatalogListingImage = fromArray[i]
            
            var imageView : CatalogListingImageView = CatalogListingImageView(imageItem: image, point: CGPointMake(x, y))
            self.addSubview(imageView)
            
            var imgW : CGFloat = imageView.frame.size.width
            var imgH : CGFloat = imageView.frame.size.height
            
            x += imgW + 4
            if imgH > maxHeight {
                maxHeight = imgH
            }
        }
    }
    
}