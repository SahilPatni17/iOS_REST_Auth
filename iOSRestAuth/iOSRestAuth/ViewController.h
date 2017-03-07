//
//  ViewController.h
//  ClubManApp
//
//  Created by Sahil Patni on 07/03/17.
//  Copyright © 2017 Sahil Patni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"
#import "AFURLRequestSerialization.h"
#import "AFURLResponseSerialization.h"

@interface ViewController : UIViewController<UITextFieldDelegate>
{
    __weak IBOutlet UITextField *txtPassword;
    __weak IBOutlet UITextField *txtUserName;
}

@end

