//
//  Landing.h
//  CONGUA
//
//  Created by Soumen on 28/05/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Landing : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UIButton *signinBtn;
@property (weak, nonatomic) IBOutlet UIButton *signUpbtn;
- (IBAction)PushLogin:(id)sender;
- (IBAction)pushSignUp:(id)sender;

@end
