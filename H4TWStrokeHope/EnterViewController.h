//
//  EnterViewController.h
//  H4TWStrokeHope
//
//  Created by Rachel on 3/23/17.
//  Copyright © 2017 Rachel. All rights reserved.
//

/*
 * EnterViewController
 * ---------------------
 * This is the first screen of the app, where the user sees an inspirational quote
 * and an "enter" button.
 *
 */

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
//#import <AWSCognitoIdentityProvider/AWSCognitoIdentityProvider.h>


@interface EnterViewController : UIViewController
<UIGestureRecognizerDelegate, UITableViewDataSource,UITableViewDelegate,FBSDKLoginButtonDelegate>//AWSCognitoIdentityPasswordAuthentication
    @property (nonatomic, strong) NSString * usernameText;
    //UIPickerViewDelegate, UIPickerViewDataSource
    @property NSArray *arrLanguage;
    @property NSArray *arrKey;
    @property NSString *selectedLanguage;
@end
