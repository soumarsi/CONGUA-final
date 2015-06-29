//
//  login.m
//  CONGUA
//
//  Created by Soumen on 28/05/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

/*#import "login.h"

@interface login ()

@end

@implementation login

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





#import "login.h"
#import "Landing.h"
/* #import "Reachability.h"
#import "User.h"*/
@interface login (){
    
   // Reachability *internetReachableFoo;
    UIAlertView *alert;
    CGRect f;
}

@end

@implementation login

- (void)viewDidLoad {
    [super viewDidLoad];
    f = _loginview.frame;
    [self addlabelgesture];
    
    urlobj=[[UrlconnectionObject alloc]init];
    // Do any additional setup after loading the view.
}

-(void)addlabelgesture
{
    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedOnLink:)];
    [_signupnowlbl setUserInteractionEnabled:YES];
    [_signupnowlbl addGestureRecognizer:gesture];
}

- (void)userTappedOnLink:(UIGestureRecognizer*)gestureRecognizer
{
    //NSLog(@"gesture is ok");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    Landing *dest = [storyboard instantiateViewControllerWithIdentifier:@"signup"];
    [self.navigationController pushViewController:dest animated:YES];
}

-(void)updateLabeltext:(id)sender
{
    //UIDatePicker *picker = (UIDatePicker*)self.myTextField.inputView;
    //self.myTextField.text = [NSString stringWithFormat:@"%@",picker.date];
    NSLog(@"I'm in updateLabeltext");
}
/*@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;


@synthesize username,password;
- (IBAction)GosignIn:(id)sender {
    
    internetReachableFoo = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    // Internet is reachable
    internetReachableFoo.reachableBlock = ^(Reachability*reach)
    {
        NSString *trimmedString = [username.text stringByTrimmingCharactersInSet:
                                   [NSCharacterSet whitespaceCharacterSet]];
        
        NSString *trimmedString1 = [password.text stringByTrimmingCharactersInSet:
                                    [NSCharacterSet whitespaceCharacterSet]];
        if (trimmedString.length <= 0) {
            
            
            alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please enter Username" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            alert.tag=0;
            [alert show];
            
        }
        //
        else if (trimmedString1.length <= 0) {
            
            alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please enter Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            alert.tag=1;
            [alert show];
            
        }
        else{
            
            
            dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
            
            
            
            dispatch_async(q, ^{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    NSError *error;
                    
                    NSString *urlString = [[NSString alloc] init];
                    urlString = [NSString stringWithFormat:@"http://sandbox.itraksoftware.com/congua/ConguaREST/ConguaService.svc/Authorise?LoginName=%@&password=%@",username.text,password.text],
                    
                    NSLog(@"urlstring is %@",urlString);
                    
                    
                    NSData *dataURL =  [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
                    NSLog(@"----------------------- %@", dataURL);
                    NSDictionary  *json = [NSJSONSerialization JSONObjectWithData:dataURL //1
                                                                          options:kNilOptions
                                                                            error:&error];
                    NSLog(@"======================= json issss%@", json);
                    NSString *str1=[NSString stringWithFormat:@"%@",[json objectForKey:@"IsSuccess"]];
                    if([str1  isEqualToString:@"1"]){
                        
                        // if(auth) {
                        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                        
                        NSDictionary  *userDetails = [json objectForKey:@"ResultInfo"];
                        [prefs setObject:[userDetails objectForKey:@"AuthToken"]forKey:@"AuthToken"];
                        [prefs setObject:[userDetails objectForKey:@"FullName"] forKey:@"FullName"];
                        [prefs setObject:[userDetails objectForKey:@"LoginName"]forKey:@"LoginName"];
                        [prefs synchronize];
                        
                        
                        
                        NSManagedObjectContext *context = [self managedObjectContext];
                        User *failedBankInfo = [NSEntityDescription
                                                insertNewObjectForEntityForName:@"User"
                                                inManagedObjectContext:context];
                        failedBankInfo.authtoken = [userDetails objectForKey:@"AuthToken"];
                        failedBankInfo.fullname = [userDetails objectForKey:@"FullName"];
                        failedBankInfo.customercode = [userDetails objectForKey:@"CustomerCode"];
                        failedBankInfo.email = [userDetails objectForKey:@"LoginName"];
                        
                        NSError *error;
                        if (![context save:&error]) {
                            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
                        }
                        
                        // Test listing all FailedBankInfos from the store
                        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                        NSEntityDescription *entity = [NSEntityDescription entityForName:@"User"
                                                                  inManagedObjectContext:context];
                        [fetchRequest setEntity:entity];
                        NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
                        for (User *info in fetchedObjects) {
                            NSLog(@"Name: %@", info.authtoken);
                            
                            NSLog(@"Zip: %@", info.fullname);
                        }
                        
                        // Override point for customization after application launch.
                        
                        
                        
                        
                        
                        
                        
                    }
                    else if ( [str1  isEqualToString:@"0"]){
                        
                        UIAlertView *authError = [[UIAlertView alloc] initWithTitle:@"Failed"
                                                                            message:@"Authentication failed! Please check your username and password!"
                                                                           delegate:self
                                                                  cancelButtonTitle:@"Ok"
                                                                  otherButtonTitles:nil];
                        [authError show];
                        
                        
                        
                        
                    }
                    
                });
                
            });
            
            
            
        }
        
    };
    
    // Internet is not reachable
    internetReachableFoo.unreachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        alert = [[UIAlertView alloc]initWithTitle:@"" message:@"No Internet Connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    };
    
    [internetReachableFoo startNotifier];
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil) {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}
- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil) {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"FailedBankCD" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil) {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"FailedBankCD.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
 
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
 
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}*/
- (IBAction)PUSHTOFORGOTPASSWORD:(id)sender {
    UIViewController * forgotpassvc=[self.storyboard instantiateViewControllerWithIdentifier:@"forgotpasswordviewcontroller"];
    [self.navigationController  pushViewController:forgotpassvc animated:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    if(textField==self.username)
    {
        //self.addrtxt.placeholder=Nil;
        [UIView animateWithDuration:0.4f
                            //  delay:0.1f
                           // options:UIViewAnimationTransitionNone
                         animations:^{
                             
                             self.loginview.frame=CGRectOffset(f,0.0f,-20.0f);}
                         completion:^(BOOL finished){
                             
                         }
         ];
        
        //            self.regview.frame=CGRectOffset(f,0.0f,-20.0f);
    }
    if(textField==self.password)
    {
        //self.addrtxt.placeholder=Nil;
        [UIView animateWithDuration:0.4f
                          //    delay:0.1f
                          //  options:UIViewAnimationTransitionNone
                         animations:^{
                             
                             self.loginview.frame=CGRectOffset(f,0.0f,-35.0f);}
                         completion:^(BOOL finished){
                             
                         }
         ];
        
        //            self.regview.frame=CGRectOffset(f,0.0f,-20.0f);
    }

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [UIView animateWithDuration:0.4f
                       //   delay:0.1f
                      //  options:UIViewAnimationTransitionNone
                     animations:^{
                         
                         self.loginview.frame=CGRectOffset(f,0.0f,0.0f);}
                     completion:^(BOOL finished){
                         
                     }
     ];

    return YES;
}

//This is for temporary purpose,only for testing,this must be deleted and the original login will be as earlier above
- (IBAction)GosignIn:(id)sender
{
    [_btnlogin setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    _btnlogin.backgroundColor=[UIColor colorWithRed:(224.0/255.0) green:(44.0/255.0) blue:(17.0/255.0) alpha:1.0];
    [_btnlogin setTitle:@"Signing in..." forState:UIControlStateNormal];
    _btnlogin.userInteractionEnabled=NO;
    [self LoginUrl];
    
    
    
}
-(void)LoginUrl
{
   // [self checkLoader];
    NSString *str=[NSString stringWithFormat:@"%@Authorise?LoginName=%@&Password=%@",URL_LINK,[self.username.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[self.password.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"str=%@",str);
    BOOL net=[urlobj connectedToNetwork];
    if (net==YES) {
        [urlobj global:str typerequest:@"array" withblock:^(id result, NSError *error,BOOL completed) {
            
          //     NSLog(@"event result----- %@", result);
           
            
          
            
            NSLog(@"values:%@",[result valueForKey:@"IsSuccess"]);
            
            
            if ([[result valueForKey:@"IsSuccess"] integerValue]==1) {
                
              //  [self checkLoader];
           /*     UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Success" message:@"Mail sent successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [aler show];
            */
                [[NSUserDefaults standardUserDefaults] setObject:[[result valueForKey:@"ResultInfo"] valueForKey:@"CustomerCode"]  forKey:@"CustomerCode"];
                [[NSUserDefaults standardUserDefaults] setObject:[[result valueForKey:@"ResultInfo"] valueForKey:@"FullName"]  forKey:@"FullName"];
                [[NSUserDefaults standardUserDefaults] setObject:[[result valueForKey:@"ResultInfo"] valueForKey:@"LoginName"]  forKey:@"email"];
                [[NSUserDefaults standardUserDefaults] setObject:[[result valueForKey:@"ResultInfo"] valueForKey:@"AuthToken"]  forKey:@"AuthToken"];
                [[NSUserDefaults standardUserDefaults] setObject:[[result valueForKey:@"ResultInfo"] valueForKey:@"UserCode"]  forKey:@"UserCode"];
                UIViewController * vc=[self.storyboard instantiateViewControllerWithIdentifier:@"viewcontroller"];
                [self.navigationController  pushViewController:vc animated:YES];
            }
            else
            {
              //  [self checkLoader];
                [_btnlogin setImage:[UIImage imageNamed:@"LoginSinnin"] forState:UIControlStateNormal];
                _btnlogin.userInteractionEnabled=YES;
                UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Unsucessful...." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [aler show];
            }
            
            
        }];
    }
    else{
      //  [self checkLoader];
        [_btnlogin setImage:[UIImage imageNamed:@"LoginSinnin"] forState:UIControlStateNormal];
        _btnlogin.userInteractionEnabled=YES;
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"No Network Connection." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
    }
}
-(void)checkLoader
{
    
    if([self.view.subviews containsObject:loader_shadow_View])
    {
        
        [loader_shadow_View removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
    }
    else
    {
        loader_shadow_View = [[UIView alloc] initWithFrame:self.view.frame];
        [loader_shadow_View setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.56f]];
        [loader_shadow_View setUserInteractionEnabled:NO];
        [[loader_shadow_View layer] setZPosition:2];
        [self.view setUserInteractionEnabled:NO];
        UIActivityIndicatorView *loader =[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        [loader setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
        
        [loader startAnimating];
        
        
        [loader_shadow_View addSubview:loader];
        [self.view addSubview:loader_shadow_View];
    }
}
@end

