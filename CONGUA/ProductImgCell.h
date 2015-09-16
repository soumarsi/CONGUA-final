//
//  ProductImgCell.h
//  CONGUA
//
//  Created by Priyanka ghosh on 28/07/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductImgCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbldesc;
@property (weak, nonatomic) IBOutlet UIImageView *ProductImg;
@property (weak, nonatomic) IBOutlet UIScrollView *mainscroll;
@property (weak, nonatomic) IBOutlet UIButton *btnzoom;

@end
