//
//  PrivacyViewController.h
//  iExamMobile
//
//  Created by Leo Chang on 9/24/13.
//  Copyright (c) 2013 GoodIea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrivacyViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIWebView *contentWebView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil content:(NSString*)content;

@end
