//
//  portfolioitemprototyoecellheader.h
//  CONGUA
//
//  Created by Soumen on 29/05/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface portfolioitemprototyoecellheader : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btndropdown;

@property (weak, nonatomic) IBOutlet UIButton *btnAddProduct;

@property (weak, nonatomic) IBOutlet UIScrollView *headerCellScroll;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete;

@property (weak, nonatomic) IBOutlet UIButton *btnEdit;


@end
