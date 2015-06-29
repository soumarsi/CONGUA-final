//
//  prototypecell.h
//  CONGUA
//
//  Created by Soumen on 26/05/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface prototypecell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIImageView *cellIcon;
@property (strong, nonatomic) IBOutlet UILabel *celltitlelbl;
@property (strong, nonatomic) IBOutlet UILabel *celladdresslbl;
@property (strong, nonatomic) IBOutlet UILabel *celldetailslbl;
@property (weak, nonatomic) IBOutlet UILabel *lblactive;
@property (weak, nonatomic) IBOutlet UILabel *lblinsured;

@end
