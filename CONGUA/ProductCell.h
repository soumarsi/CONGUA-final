//
//  ProductCell.h
//  CONGUA
//
//  Created by Priyanka ghosh on 21/09/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblValue;
@property (weak, nonatomic) IBOutlet UIImageView *insureImg;
@property (weak, nonatomic) IBOutlet UILabel *lblInsured;

@end
