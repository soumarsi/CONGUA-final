//
//  AddProductImgViewController.m
//  CONGUA
//
//  Created by Priyanka ghosh on 17/06/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import "AddProductImgViewController.h"

@interface AddProductImgViewController ()<UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,PopView_delegate1>

@end

@implementation AddProductImgViewController
@synthesize mainscroll,lblDesc,txtvwDesc,ProductImg,btnSubmit,DocView,PopDelegate1,btnPhotoLib,btnCamera;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    CustomerCode=[prefs valueForKey:@"CustomerCode"];
    AuthToken=[prefs valueForKey:@"AuthToken"];
    ProductCode=[prefs valueForKey:@"ProductCode"];
    NSLog(@"product code=%@",ProductCode);
    
    urlobj=[[UrlconnectionObject alloc]init];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"background"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    lblDesc.textColor=[UIColor grayColor];
    
    if(self.view.frame.size.width==320)
    {
        //  [self.mainscroll setContentSize:CGSizeMake(320.0f,480.0f)];
        
        [self.mainscroll setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 495)];
    }
    btnPhotoLib.frame=CGRectMake(btnPhotoLib.frame.origin.x, btnCamera.frame.origin.y+btnCamera.frame.size.height+16, btnPhotoLib.frame.size.width, btnPhotoLib.frame.size.height);
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
    textView.autocorrectionType = UITextAutocorrectionTypeNo;
    if(textView==txtvwDesc)
    {
        lblDesc.hidden=YES;
        // [mainscroll setContentOffset:CGPointMake(0.0f,170.0f) animated:YES];
    }
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        if(textView==txtvwDesc)
        {
            //  [self.mainscroll setContentOffset:CGPointMake(0.0f,0.0f) animated:YES];
            
            if (txtvwDesc.text.length==0)
            {
                lblDesc.hidden=NO;
            }
        }
        
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)AddImageClk:(id)sender
{
    [txtvwDesc resignFirstResponder];
    actionsheet=[[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Photo Library", nil];
    [actionsheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex

{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = (id)self;
    picker.allowsEditing = NO;
    [mainscroll setContentOffset:CGPointMake(0,0) animated:YES];
    switch (buttonIndex) {
            
        case 0:
            
            
            if ([UIImagePickerController isSourceTypeAvailable:
                 UIImagePickerControllerSourceTypeCamera])
            {
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self.navigationController presentViewController:picker animated:YES completion:NULL];
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No Camera Available." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            
            break;
            
        case 1:
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self.navigationController presentViewController:picker animated:YES completion:NULL];
            break;
            
        default:
            break;
    }
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    ProductImg.image=info[UIImagePickerControllerOriginalImage];
    ProductImg.contentMode = UIViewContentModeScaleAspectFit;
    ProductImg.clipsToBounds=YES;
    
  //  [ProductImg setUserInteractionEnabled:YES];
 //   btnSubmit.frame=CGRectMake(btnSubmit.frame.origin.x, ProductImg.frame.origin.y+ProductImg.frame.size.height+10, btnSubmit.frame.size.width, btnSubmit.frame.size.height);
    DocView.hidden=YES;
    btnSubmit.hidden=NO;
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    
    
}
-(NSString *)textFieldBlankorNot:(NSString *)str
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [str stringByTrimmingCharactersInSet:whitespace];
    return trimmed;
}

- (IBAction)SubmitClk:(id)sender
{
    if([self textFieldBlankorNot:txtvwDesc.text].length==0)
    {
        /*
        lblDesc.text=@"Enter Description";
        lblDesc.textColor=[UIColor redColor];
         */
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Description" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
    }
   
 //   else if([ProductImg.image isEqual:[UIImage imageNamed:@"doc"]])
     else if(ProductImg.image==nil)
    {
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Add Image" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
    }
    
    else
    {
        
        [self ImageUploadUrl];
        
    }

}
-(void)ImageUploadUrl
{
    
    //filename
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    NSString *currentTime = [dateFormatter stringFromDate:today];
    FileName=[NSString stringWithFormat:@"%@%@%@",@"PortDoc",currentTime,@".png"];
    //[@"PortDoc" stringByAppendingString:currentTime];
    NSLog(@"time=%@",FileName);
    
    //image upload
    CGSize size = ProductImg.image.size;
    CGFloat ratio = 0;
    if (size.width > size.height) {
        ratio = 200.0 / size.width;
    }
    else {
        ratio = 200.0 / size.height;
    }
    CGRect rect = CGRectMake(0.0, 0.0, ratio * size.width, ratio * size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    [ProductImg.image drawInRect:rect];
    UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *imageData = UIImageJPEGRepresentation(thumbnail,1.0f);
    //    NSData *plainData = [plainString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [imageData base64EncodedStringWithOptions:0];
    
 //   NSString *encodedText = [self encodeToPercentEscapeString:base64String];
    [self checkLoader];
    tempDict = [[NSDictionary alloc] initWithObjectsAndKeys:FileName,@"FileName",[base64String stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],@"FileContent",nil];
    NSLog(@"tempdic=%@",tempDict);
    NSString *loginstring = [NSString stringWithFormat:@"%@UploadFile/%@?CustomerCode=%@",URL_LINK,AuthToken,CustomerCode];
    //    NSString *loginstring = [NSString stringWithFormat:@"%@InsertPortfolioDoc/%@?PortfolioCode=%@",URL_LINK,AuthToken,PortfolioCode];
    
    NSLog(@"--- %@",loginstring);
    
    NSError *localErr;
    
    NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:(NSDictionary *) tempDict options:NSJSONWritingPrettyPrinted error:&localErr];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:loginstring]];
    
    NSString *params = jsonString; //[jsonString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPMethod:@"POST"];
    
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    
    [request setHTTPShouldHandleCookies:NO];
    
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    BOOL net=[urlobj connectedToNetwork];
    if (net==YES)
    {
        
        [urlobj globalPost:request typerequest:@"array" withblock:^(id result, NSError *error,BOOL completed) {
            
            NSLog(@"event result----- %@", result);
            //    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
            //    dic=[result valueForKey:@"response"];
            
            
            
            if ([[result valueForKey:@"IsSuccess"] integerValue]==1) {
                
                FileName=[NSString stringWithFormat:@"%@",[result valueForKey:@"ResultInfo"]];
                [self SubmitProductImageUrl];
                
            }
            else if ([[result valueForKey:@"Description"] isEqualToString:@"AuthToken has expired."])
            {
                NSString *email,*password,*remember;
                
                NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                if ([[prefs valueForKey:@"remember"] isEqualToString:@"1"])
                {
                    email=[prefs valueForKey:@"email"];
                    password=[prefs valueForKey:@"password"];
                    remember=[prefs valueForKey:@"remember"];
                    
                }
                NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
                [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
                
                if ([remember isEqualToString:@"1"])
                {
                    [[NSUserDefaults standardUserDefaults] setObject:@"1"  forKey:@"remember"];
                    [[NSUserDefaults standardUserDefaults] setObject:email  forKey:@"email"];
                    [[NSUserDefaults standardUserDefaults] setObject:password  forKey:@"password"];
                    
                }
                login *obj1=[self.storyboard instantiateViewControllerWithIdentifier:@"login"];
                [self.navigationController pushViewController:obj1 animated:YES];
            }
            else
            {
                [self checkLoader];
                UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Unsucessful...." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [aler show];
            }
            
        }];
    }
    else{
        [self checkLoader];
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"No Network Connection." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
    }
    
    
}
-(void)SubmitProductImageUrl
{
    /*
     //result null
     
     NSString *str=[NSString stringWithFormat:@"%@InsertPortfolioDoc/%@?PortfolioCode=%@",URL_LINK,AuthToken,PortfolioCode];
     NSString *urlString = [NSString stringWithFormat:@"%@",str];
     
     NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
     [request setURL:[NSURL URLWithString:urlString]];
     [request setHTTPMethod:@"POST"];
     NSMutableData *body = [NSMutableData data];
     NSString *boundary = @"---------------------------14737809831466499882746641449";
     NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
     [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
     
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[@"Content-Disposition: form-data; name=\"FileName\"; filename=\".jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[NSData dataWithData:UIImageJPEGRepresentation(DocImage.image, 1)]];
     [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
     
     //  parameter username
     
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"DocName\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     
     [body appendData:[txtDocName.text dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
     
     
     //  parameter token
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"PortfolioDocCode\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     
     [body appendData:[@"0" dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
     
     
     // parameter method
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"DocTypeCode\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     
     [body appendData:[lblDocType.text dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
     
     
     //parameter method
     
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Description\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     
     [body appendData:[txtvwDescription.text dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
     
     // close form
     [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     
     
     // setting the body of the post to the reqeust
     [request setHTTPBody:body];
     
     NSLog(@"request=%@",request);
     */
    
    [self checkLoader];
    tempDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"0",@"ProductImageCode",txtvwDesc.text,@"Description",FileName,@"FileName",ProductCode,@"ProductCode",nil];
    NSLog(@"tempdic=%@",tempDict);
    NSString *loginstring = [NSString stringWithFormat:@"%@InsertProductImage/%@?ProductCode=%@",URL_LINK,AuthToken,ProductCode];
    
    NSLog(@"--- %@",loginstring);
    /*
     NSData *imageData = UIImagePNGRepresentation(DocImage.image);
     
     AFHTTPClient *client= [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:loginstring]];
     
     
     
     
     
     
     
     NSMutableURLRequest *request = [client multipartFormRequestWithMethod:@"POST" path:nil parameters:tempDict constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
     
     
     NSString *imagename = [NSString stringWithFormat:@"FileName"];
     
     
     
     [formData appendPartWithFileData:imageData name:imagename fileName:@"temp.png" mimeType:@"image/png"];
     
     
     
     
     
     }];
     
     
     
     
     
     
     
     AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
     
     
     
     [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _operation, id responseObject) {
     
     
     
     NSString *response = [_operation responseString];
     
     
     
     NSLog(@"response: [%@]",response);
     */
    /*
     NSError *error;
     NSString *dictString=[NSString stringWithFormat:@"%@", response];//or ur dict reference..
     NSData *jsonData = [dictString dataUsingEncoding:NSUTF8StringEncoding];
     NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData
     options:NSJSONReadingMutableContainers
     error:&error];
     if ([[json valueForKey:@"status"] isEqualToString:@"Success"]) {
     
     [self checkLoader];
     UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Success" message:@"Account Successfully Updated." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
     [aler show];
     }
     else
     {
     [self checkLoader];
     UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Unsucessful...." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
     [aler show];
     }
     
     */
    /*
     
     } failure:^(AFHTTPRequestOperation * _operation, NSError *error) {
     
     
     
     if([_operation.response statusCode] == 403){
     
     
     
     NSLog(@"Upload Failed");
     
     
     
     return;
     
     
     
     }
     NSLog(@"error: %@", [_operation error]);
     [self checkLoader];
     
     }];
     
     
     
     [operation start];
     */
    NSError *localErr;
    
    NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:(NSDictionary *) tempDict options:NSJSONWritingPrettyPrinted error:&localErr];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:loginstring]];
    
    NSString *params = jsonString; //[jsonString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPMethod:@"POST"];
    
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    
    [request setHTTPShouldHandleCookies:NO];
    
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    BOOL net=[urlobj connectedToNetwork];
    if (net==YES)
    {
        
        [urlobj globalPost:request typerequest:@"array" withblock:^(id result, NSError *error,BOOL completed) {
            
            NSLog(@"event result----- %@", result);
            //    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
            //    dic=[result valueForKey:@"response"];
            
            
            
            if ([[result valueForKey:@"IsSuccess"] integerValue]==1) {
                
                
                [self checkLoader];
                UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Success" message:@"Image Added Successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [aler show];
                [PopDelegate1 Popaction_method1];
                [self.navigationController popViewControllerAnimated:YES];
            }
            else if ([[result valueForKey:@"Description"] isEqualToString:@"AuthToken has expired."])
            {
                NSString *email,*password,*remember;
                
                NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                if ([[prefs valueForKey:@"remember"] isEqualToString:@"1"])
                {
                    email=[prefs valueForKey:@"email"];
                    password=[prefs valueForKey:@"password"];
                    remember=[prefs valueForKey:@"remember"];
                    
                }
                NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
                [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
                
                if ([remember isEqualToString:@"1"])
                {
                    [[NSUserDefaults standardUserDefaults] setObject:@"1"  forKey:@"remember"];
                    [[NSUserDefaults standardUserDefaults] setObject:email  forKey:@"email"];
                    [[NSUserDefaults standardUserDefaults] setObject:password  forKey:@"password"];
                    
                }
                login *obj1=[self.storyboard instantiateViewControllerWithIdentifier:@"login"];
                [self.navigationController pushViewController:obj1 animated:YES];
            }
            else
            {
                [self checkLoader];
                UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Unsucessful...." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [aler show];
            }
            
        }];
    }
    else{
        
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
- (IBAction)BackClk:(id)sender
{
   
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)CameraClick:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = (id)self;
        picker.allowsEditing = NO;
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self.navigationController presentViewController:picker animated:YES completion:NULL];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No Camera Available." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
   }

- (IBAction)PhotoLibClick:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = (id)self;
    picker.allowsEditing = NO;
  
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self.navigationController presentViewController:picker animated:YES completion:NULL];
 }
@end
