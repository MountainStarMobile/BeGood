//
//  PrivacyViewController.m
//  iExamMobile
//
//  Created by Leo Chang on 9/24/13.
//  Copyright (c) 2013 GoodIea. All rights reserved.
//

#import "PrivacyViewController.h"

@interface PrivacyViewController ()

@property (nonatomic, retain) NSString *filePath;

- (void)createBarItem;
- (void)dismissView:(id)sender;

@end

@implementation PrivacyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil content:(NSString *)content
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = [NSString stringWithFormat:@"隱私權政策"];
        self.filePath = content;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self createBarItem];
    NSData *webData = [NSData dataWithContentsOfFile:_filePath];
    [_contentWebView loadData:webData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createBarItem
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"了解" style:UIBarButtonItemStylePlain target:self action:@selector(dismissView:)];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObject:item];
}

- (void)dismissView:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
