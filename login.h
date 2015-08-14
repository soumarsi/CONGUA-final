//
//  login.h
//  CONGUA
//
//  Created by Soumen on 28/05/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlconnectionObject.h"
#import "SignUp.h"
@interface login : UIViewController<UITextFieldDelegate>
{
    UrlconnectionObject *urlobj;
    UIView *loader_shadow_View;
}
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UIButton *signIn;
- (IBAction)GosignIn:(id)sender;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) IBOutlet UILabel *signupnowlbl;
@property (strong, nonatomic) IBOutlet UIView *loginview;
@property (weak, nonatomic) IBOutlet UIButton *btnlogin;
@property (weak, nonatomic) IBOutlet UIButton *btnRemember;
- (IBAction)RememberClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *ChkImg;

@end
