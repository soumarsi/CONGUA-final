//
//  AppDelegate.h
//  CONGUA
//
//  Created by Soumen on 26/05/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "login.h"
#import "Landing.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSString *AuthToken;
}
@property (strong, nonatomic) UIWindow *window;
//@property (strong, nonatomic) UINavigationController *navigationController;

@end

