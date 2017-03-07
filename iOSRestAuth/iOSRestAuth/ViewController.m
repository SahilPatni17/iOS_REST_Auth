//
//  ViewController.m
//  ClubManApp
//
//  Created by Sahil Patni on 07/03/17.
//  Copyright © 2017 Sahil Patni. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *paddindView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    
    txtUserName.layer.cornerRadius=8.0f;
    txtUserName.layer.masksToBounds=YES;
    txtUserName.layer.borderColor=[[UIColor whiteColor]CGColor];
    txtUserName.layer.borderWidth= 1.0f;
    txtUserName.leftView = paddindView;
    
    
    
    txtPassword.layer.cornerRadius=8.0f;
    txtPassword.layer.masksToBounds=YES;
    txtPassword.layer.borderColor=[[UIColor whiteColor]CGColor];
    txtPassword.layer.borderWidth= 1.0f;
    txtPassword.leftView = paddindView;

    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)btnSignInClick:(id)sender
{
    [self jasonApiCall];
}

-(void)jasonApiCall
{
    NSError *error;
    NSString* urlString = [NSString stringWithFormat:@"%@/%@",@"API_URL",@"Login"];
    
    
    NSDictionary* parametersDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          txtUserName.text,@"username",
                                          txtPassword.text,@"password",
                                          @"password",@"grant_type", nil
                                          ];
    
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    [manager POST:urlString parameters:parametersDictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        NSLog(@"%@",responseObject);
        NSMutableDictionary *dictResult = [responseObject valueForKey:@"Result"];
        NSLog(@"%@",dictResult);
        
        if ([[responseObject valueForKey:@"Status"] integerValue]== 0)
        {
            UIAlertView *alt=[[UIAlertView alloc] initWithTitle:@"Alert" message:[responseObject objectForKey:@"Message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alt show];
        }
        else {
            UIAlertView *alt=[[UIAlertView alloc] initWithTitle:@"Alert" message:[responseObject objectForKey:@"Message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alt show];
        }
       
    }
     
    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        NSLog(@"%@",error);
    }];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
