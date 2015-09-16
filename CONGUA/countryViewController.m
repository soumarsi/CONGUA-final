//
//  countryViewController.m
//  CONGUA
//
//  Created by IOS2 on 16/07/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import "countryViewController.h"
#import "SignUp.h"
#import "AddProductViewController.h"

@interface countryViewController ()


//{BOOL categoryCheck,countryCheck;}

@property (strong, nonatomic) IBOutlet UIView *topBarView;





@property (strong, nonatomic) IBOutlet UIButton *backBtn;




@end

@implementation countryViewController

@synthesize myDelegate;

@synthesize ArrCountryCode,ArrCountryName,backBtn,topBarView,listTable,ArrCategory,categoryCheck,countryCheck,headerLbl1,headerLbl2,signin,SignDic,header1,header2,TitleCheck,ArrTitleCode,ArrTitleName,myprofile;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    headerLbl1.adjustsFontSizeToFitWidth=YES;
    
    headerLbl2.adjustsFontSizeToFitWidth=YES;
    headerLbl2.frame=CGRectMake(headerLbl1.frame.origin.x+headerLbl1.frame.size.width, headerLbl2.frame.origin.y, headerLbl2.frame.size.width, headerLbl2.frame.size.height);
    
    topBarView.layer.borderColor=[[UIColor grayColor]CGColor];
    
    topBarView.clipsToBounds=YES;
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    NSLog(@"Category array table values.....%@",ArrCategory);
     NSLog(@"dic in country.....%@",SignDic);
     NSLog(@"title check=%@",TitleCheck);
    if([TitleCheck isEqualToString:@"YES"])
    {
        headerLbl1.frame=CGRectMake(headerLbl1.frame.origin.x+10, headerLbl1.frame.origin.y, headerLbl1.frame.size.width-20, headerLbl1.frame.size.height);
        headerLbl2.frame=CGRectMake(headerLbl1.frame.origin.x+headerLbl1.frame.size.width, headerLbl2.frame.origin.y, headerLbl2.frame.size.width, headerLbl2.frame.size.height);
        
        listTable=[[UITableView alloc]initWithFrame:CGRectMake(0, topBarView.frame.origin.y+topBarView.bounds.size.height, self.view.bounds.size.width, ArrTitleName.count*50)];
       
       
        headerLbl1.text=@"Title";
        headerLbl2.text=@"List";
    }
    else if(ArrCountryName.count>0)
    {
        listTable=[[UITableView alloc]initWithFrame:CGRectMake(0, topBarView.frame.origin.y+topBarView.bounds.size.height, self.view.bounds.size.width, ArrCountryName.count*50)];
        
        countryCheck=@"YES";
        headerLbl1.text=@"Country";
        headerLbl2.text=@"List";
    }
    
    else if (ArrCategory.count>0)
    {
        headerLbl1.frame=CGRectMake(headerLbl1.frame.origin.x-20, headerLbl1.frame.origin.y, headerLbl1.frame.size.width, headerLbl1.frame.size.height);
        headerLbl2.frame=CGRectMake(headerLbl1.frame.origin.x+headerLbl1.frame.size.width, headerLbl2.frame.origin.y, headerLbl2.frame.size.width, headerLbl2.frame.size.height);
        NSLog(@"Category table creating....");
        
        listTable=[[UITableView alloc]initWithFrame:CGRectMake(0, topBarView.frame.origin.y+topBarView.bounds.size.height, self.view.bounds.size.width, ArrCategory.count*50)];
        
        categoryCheck=@"YES";
        headerLbl1.text=header1;
        headerLbl2.text=header2;
      //  NSLog(@"header=%@",header1);
        
    }
    
  //  NSLog(@"list delegate");
    listTable.delegate=self;
    listTable.dataSource=self;
    
    listTable.backgroundColor=[UIColor clearColor];
    
    listTable.separatorColor=[UIColor clearColor];
    
    [self.view addSubview:listTable];
    
//  NSLog(@"title list=%@",ArrTitleName);
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([countryCheck isEqualToString:@"YES"])
        return ArrCountryName.count;
    else if ([categoryCheck isEqualToString:@"YES"])
    {
        NSLog(@"Category table no of rows....%lu",(long)ArrCategory.count);
        
        return ArrCategory.count;
    }
    else if([TitleCheck isEqualToString:@"YES"])
        return ArrTitleName.count;
    
    else return 0;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

   static NSString *cellID=@"countryCell";
    
    UITableViewCell *countryTableCell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    
    if(countryTableCell==NULL)
    {
    
        countryTableCell=[tableView dequeueReusableCellWithIdentifier:cellID];
    
    }
    
    countryTableCell.textLabel.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Th" size:14.0];
    if([countryCheck isEqualToString:@"YES"])
      countryTableCell.textLabel.text=[ArrCountryName objectAtIndex:indexPath.row];
    
    else if ([categoryCheck isEqualToString:@"YES"])
        countryTableCell.textLabel.text=[[ArrCategory objectAtIndex:indexPath.row] valueForKey:@"CategoryName"];
    else if([TitleCheck isEqualToString:@"YES"])
        countryTableCell.textLabel.text=[ArrTitleName objectAtIndex:indexPath.row];
    
    NSLog(@"name=%@",[ArrTitleName objectAtIndex:indexPath.row]);
    countryTableCell.layer.shadowColor=[[UIColor grayColor] CGColor];
    
    countryTableCell.layer.shadowOpacity=0.3;
    
    countryTableCell.layer.shadowOffset=CGSizeMake(0, 3);
    
    countryTableCell.layer.shadowRadius=3.0;
    
 //   NSLog(@"Cell creating....");
    
    return countryTableCell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([countryCheck isEqualToString:@"YES"])
    {
    if (signin==YES) {
    SignUp *signupVC=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"signup"];
        [SignDic setObject:[ArrCountryName objectAtIndex:indexPath.row] forKey:@"country"];
        [SignDic setObject:[ArrCountryCode objectAtIndex:indexPath.row] forKey:@"countryCode"];
        signupVC.dataDic=SignDic;
  //  signupVC.country=[ArrCountryName objectAtIndex:indexPath.row];
    
 //   signupVC.countrycode=[ArrCountryCode objectAtIndex:indexPath.row];
        
            signupVC.gosignin=YES;
        
    [ArrCountryName removeAllObjects];
        
    [ArrCountryCode removeAllObjects];
    
    [self.navigationController pushViewController:signupVC animated:YES];
    }
    else if (myprofile==YES)
    {
        MyProfileViewController *signupVC=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"MyProfileViewController"];
        [SignDic setObject:[ArrCountryName objectAtIndex:indexPath.row] forKey:@"country"];
        [SignDic setObject:[ArrCountryCode objectAtIndex:indexPath.row] forKey:@"countryCode"];
        signupVC.dataDic=SignDic;
        //  signupVC.country=[ArrCountryName objectAtIndex:indexPath.row];
        
        //   signupVC.countrycode=[ArrCountryCode objectAtIndex:indexPath.row];
        
        signupVC.goprofile=YES;
        
        [ArrCountryName removeAllObjects];
        
        [ArrCountryCode removeAllObjects];
        
        [self.navigationController pushViewController:signupVC animated:YES];
    }
     
        
    }
    
    else if ([categoryCheck isEqualToString:@"YES"])
    {
     categoryCheck=@"NO";
        [self.myDelegate countryViewcontrollerDismissedwithCategoryName:[[ArrCategory objectAtIndex:indexPath.row] valueForKey:@"CategoryName"] categoryCode:[[ArrCategory objectAtIndex:indexPath.row] valueForKey:@"CategoryCode"]];
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
//        AddProductViewController *productVC=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AddProductViewControllersid"];
//        
//        productVC.ProductType=[[ArrCategory objectAtIndex:indexPath.row] valueForKey:@"CategoryName"];
//        
//        productVC.catCode=[[ArrCategory objectAtIndex:indexPath.row] valueForKey:@"CategoryCode"];
//        
//        
//        if([self.myDelegate respondsToSelector:@selector(countryViewcontrollerDismissedwithCategoryName:categoryCode:)])
//        {
//        
//            [self.myDelegate countryViewcontrollerDismissedwithCategoryName:productVC.ProductType categoryCode: productVC.catCode];
//        
//        
//        }
//        
//       
//        
//       
//        
//        [self dismissViewControllerAnimated:productVC completion:^{
//            
//            productVC.catCode=[[ArrCategory objectAtIndex:indexPath.row] valueForKey:@"CategoryCode"];
//
//            productVC.lblProductType.text=productVC.ProductType;
//            
//            NSLog(@"Product type value in table...%@", productVC.ProductType);
//            
//            
//        }];
        
       
    
    
    }
    else if([TitleCheck isEqualToString:@"YES"])
    {
        if (signin==YES) {
        SignUp *signupVC=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"signup"];
        [SignDic setObject:[ArrTitleName objectAtIndex:indexPath.row] forKey:@"title"];
        [SignDic setObject:[ArrTitleCode objectAtIndex:indexPath.row] forKey:@"titleCode"];

        signupVC.dataDic=SignDic;
    //    signupVC.titleName=[ArrTitleName objectAtIndex:indexPath.row];
        
    //    signupVC.titleCode=[ArrTitleCode objectAtIndex:indexPath.row];
        
            signupVC.gosignin=YES;
        
        [ArrCountryName removeAllObjects];
        
        [ArrCountryCode removeAllObjects];
        
        [self.navigationController pushViewController:signupVC animated:YES];
        }
        else if (myprofile==YES)
        {
            MyProfileViewController *signupVC=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"MyProfileViewController"];
            [SignDic setObject:[ArrTitleName objectAtIndex:indexPath.row] forKey:@"title"];
            [SignDic setObject:[ArrTitleCode objectAtIndex:indexPath.row] forKey:@"titleCode"];
            
            signupVC.dataDic=SignDic;
            //    signupVC.titleName=[ArrTitleName objectAtIndex:indexPath.row];
            
            //    signupVC.titleCode=[ArrTitleCode objectAtIndex:indexPath.row];
            
            signupVC.goprofile=YES;
            
            [ArrCountryName removeAllObjects];
            
            [ArrCountryCode removeAllObjects];
            
            [self.navigationController pushViewController:signupVC animated:YES];
        }
        //  countryCheck=NO;
        
    }

    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)backBtnFunc:(id)sender
{
    if([countryCheck isEqualToString:@"YES"])
    {
    if (signin==YES)
    {
    SignUp *signupVC=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"signup"];
        signupVC.dataDic=SignDic;
        
            signupVC.gosignin=YES;
       
    [ArrCountryName removeAllObjects];
    
    [ArrCountryCode removeAllObjects];
    
    countryCheck=@"NO";
    
    [self.navigationController pushViewController:signupVC animated:YES];
    }
      else if (myprofile==YES)
      {
            MyProfileViewController *signupVC=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"MyProfileViewController"];
            signupVC.dataDic=SignDic;
            
            signupVC.goprofile=YES;
            
            [ArrCountryName removeAllObjects];
            
            [ArrCountryCode removeAllObjects];
            
            countryCheck=@"NO";
            
            [self.navigationController pushViewController:signupVC animated:YES];
        }
        
    }
    
    else if ([categoryCheck isEqualToString:@"YES"])
    {
        categoryCheck=@"NO";
        [self.navigationController popViewControllerAnimated:YES];
        
//        AddProductViewController *addVC=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AddProductViewControllersid"];
//        
//        
//    
//        [self dismissViewControllerAnimated:addVC completion:^{
//            
//            
//            
//            
//        }];
    
    
    }
    else if([TitleCheck isEqualToString:@"YES"])
    {
        NSLog(@"my profile");
        if (signin==YES)
        {
        SignUp *signupVC=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"signup"];
        signupVC.dataDic=SignDic;
     //   signupVC.titleName=[SignDic valueForKey:@"title"];
     //   signupVC.titleCode=[SignDic valueForKey:@"titleCode"];
        
            signupVC.gosignin=YES;
        
        [ArrTitleName removeAllObjects];
        
        [ArrTitleCode removeAllObjects];
        
        TitleCheck=@"NO";
        
        [self.navigationController pushViewController:signupVC animated:YES];
        }
        else if (myprofile==YES)
        {
            
            MyProfileViewController *signupVC=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"MyProfileViewController"];
            signupVC.dataDic=SignDic;
            //   signupVC.titleName=[SignDic valueForKey:@"title"];
            //   signupVC.titleCode=[SignDic valueForKey:@"titleCode"];
            
            signupVC.goprofile=YES;
            
            [ArrTitleName removeAllObjects];
            
            [ArrTitleCode removeAllObjects];
            
            TitleCheck=@"NO";
            
            [self.navigationController pushViewController:signupVC animated:YES];
        }
    }

    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
