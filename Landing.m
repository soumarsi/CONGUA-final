//
//  Landing.m
//  CONGUA
//
//  Created by Soumen on 28/05/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

/*#import "Landing.h"

@interface Landing ()

@end

@implementation Landing

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end*/


#import "Landing.h"
#import "login.h"
@implementation Landing
-(void)viewDidLoad{
    
    [super viewDidLoad];
    // _logo.frame = CGRectMake(80, 145, self.view.bounds.size.width-120, 630/3);
    
}

- (IBAction)PushLogin:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    Landing *dest = [storyboard instantiateViewControllerWithIdentifier:@"login"];
    [self.navigationController pushViewController:dest animated:YES];
}

- (IBAction)pushSignUp:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    Landing *dest = [storyboard instantiateViewControllerWithIdentifier:@"signup"];
    [self.navigationController pushViewController:dest animated:YES];
    
}
@end

