//
//  AboutUsViewController.m
//  ExamKing
//
//  Created by sinss on 13/5/6.
//  Copyright (c) 2013年 GoodIea. All rights reserved.
//

#import "AboutUsViewController.h"
#import <StoreKit/StoreKit.h>
#import <MessageUI/MessageUI.h>
#import "PrivacyViewController.h"
#import "copyrightView.h"
#import <Parse/Parse.h>


@interface AboutUsViewController () <MFMailComposeViewControllerDelegate, SKStoreProductViewControllerDelegate>
{
    BOOL systemInfoInd;
    BOOL companyInfoInd;
}

@property (nonatomic ,strong) NSArray *infos;
@property (nonatomic ,strong) NSArray *rateUs;


- (void)createCopyrightView;
- (void)showMail;
- (void)showStore;

@end

@implementation AboutUsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        if (self.infos == nil)
        {
            self.infos = [NSArray arrayWithObjects:@"版本", @"關於我們", @"隱私權政策", nil];
        }
        if (self.rateUs == nil)
        {
            self.rateUs = [NSArray arrayWithObjects:@"意見反應",@"評價我們", nil];
        }
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
    [self createCopyrightView];
    
//    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doneItemPress:)];
//    self.navigationItem.rightBarButtonItems = @[doneItem];
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"MSBarButtonIconNavigationPane.png"] style:UIBarButtonItemStyleBordered target:(MenuNavigationController *)self.navigationController action:@selector(showMenu)];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return [_infos count];
    }
    else if (section == 1)
    {
        return [_rateUs count];
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 22;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sec = [indexPath section];
    NSInteger row = [indexPath row];
    if (sec == 0 && row == 1)
    {
        if (systemInfoInd)
            return 200;
    }
    return 44;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *view = [[UITableViewHeaderFooterView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    [view.contentView setBackgroundColor:[UIColor clearColor]];
    //(226,229,234
    [view setTintColor:[UIColor colorWithRed:226/255.0 green:229/255.0 blue:234/255.0 alpha:1]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width, 22)];
    [label setTextColor:[UIColor darkGrayColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont fontWithName:systemFont size:15]];
    [view addSubview:label];
    
    if (section == 0)
    {
        [label setText:[NSString stringWithFormat:@"軟體資訊"]];
    }
    else if (section == 1)
    {
        [label setText:[NSString stringWithFormat:@"評價建議"]];
    }
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *versionCellIdentifier = @"versionCellIdentifier";
    NSInteger row = [indexPath row];
    NSInteger sec = [indexPath section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:versionCellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:versionCellIdentifier];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell.textLabel setFont:[UIFont fontWithName:systemFont size:17]];
        [cell.detailTextLabel setFont:[UIFont fontWithName:systemFont size:17]];
        [cell.textLabel setNumberOfLines:1];
        [cell.detailTextLabel setNumberOfLines:1];
        [cell.textLabel setLineBreakMode:NSLineBreakByCharWrapping];
        [cell.detailTextLabel setLineBreakMode:NSLineBreakByCharWrapping];
        [cell.textLabel setBackgroundColor:[UIColor clearColor]];
        [cell.detailTextLabel setBackgroundColor:[UIColor clearColor]];
        [cell.textLabel setTextColor:[UIColor blackColor]];
    }
    if (sec == 0)
    {
        if (row == 0)
        {
            [cell.textLabel setText:[_infos objectAtIndex:row]];
            [cell.detailTextLabel setTextAlignment:NSTextAlignmentRight];
            [cell setAccessoryType:UITableViewCellAccessoryNone];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@", system_version]];
        }
        else if (row == 1)
        {
            if (systemInfoInd)
            {
                [cell.textLabel setLineBreakMode:NSLineBreakByCharWrapping];
                [cell.detailTextLabel setLineBreakMode:NSLineBreakByCharWrapping];
                [cell.textLabel setNumberOfLines:0];
                [cell.detailTextLabel setNumberOfLines:0];
            }
            else
            {
                [cell.textLabel setLineBreakMode:NSLineBreakByTruncatingTail];
                [cell.detailTextLabel setLineBreakMode:NSLineBreakByTruncatingTail];
                [cell.textLabel setNumberOfLines:1];
                [cell.detailTextLabel setNumberOfLines:1];
            }
            NSString *systemInfo = companyInformationMessage;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell.textLabel setTextAlignment:NSTextAlignmentLeft];
            [cell.textLabel setText:systemInfo];
        }
        else
        {
            [cell.textLabel setLineBreakMode:NSLineBreakByTruncatingTail];
            [cell.detailTextLabel setLineBreakMode:NSLineBreakByTruncatingTail];
            [cell.textLabel setNumberOfLines:1];
            [cell.detailTextLabel setNumberOfLines:1];
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            [cell.textLabel setText:[_infos objectAtIndex:row]];
            [cell.detailTextLabel setText:@""];

        }
        [cell.textLabel setBackgroundColor:[UIColor clearColor]];
        [cell.detailTextLabel setBackgroundColor:[UIColor clearColor]];
    }
    else if (sec == 1)
    {
        [cell.textLabel setText:[_rateUs objectAtIndex:row]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
        [cell.detailTextLabel setTextAlignment:NSTextAlignmentRight];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cell.detailTextLabel setText:@""];
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sec = [indexPath section];
    NSInteger row = [indexPath row];
    if (sec == 0)
    {
        if (row == 1)
        {
            systemInfoInd = !systemInfoInd;
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        else if (row == 2)
        {
            /*
             display Privacy View Controller
             */
            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"privacy" ofType:@"html"];
            PrivacyViewController *privacyView = [[PrivacyViewController alloc] initWithNibName:@"PrivacyViewController" bundle:nil content:filePath];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:privacyView];
            [self presentViewController:nav animated:YES completion:nil];
            //[self.navigationController pushViewController:privacyView animated:YES];
        }
    }
    else if (sec == 1)
    {
        if (row == 0)
        {
            if ([MFMailComposeViewController canSendMail])
            {
                [self showMail];
            }
        }
        else if (row == 1)
        {
            [self showStore];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - SKProductViewControllerDelegate
// Sent if the user requests that the page be dismissed
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    NSString *msg;
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            msg = @"取消";
            break;
        case MFMailComposeResultSaved:
            msg = @"保存成功";
            
            break;
        case MFMailComposeResultSent:
            msg = @"成功";
            
            break;
        case MFMailComposeResultFailed:
            msg = @"失败";
            
            break;
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - user Define function

- (void)createCopyrightView
{
    copyrightView *view = [[[NSBundle mainBundle] loadNibNamed:@"copyrightView" owner:self options:nil] objectAtIndex:0];
    
    self.tableView.tableFooterView = view;
}

- (void)showMail
{
    //建立物件與指定代理
    MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
    controller.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
    controller.mailComposeDelegate = self;
    
    //設定收件人與主旨等資訊
    [controller setToRecipients:[NSArray arrayWithObjects:kSupportEamil, nil]];
    [controller setSubject:@"[B]"];
    
    //設定內文並且不使用HTML語法
    [controller setMessageBody:@"Dear\n" isHTML:NO];
    
    
    //顯示電子郵件畫面
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)showStore
{
    SKStoreProductViewController *storeProductViewController = [[SKStoreProductViewController alloc] init];
    // Configure View Controller
    [storeProductViewController setDelegate:self];
    storeProductViewController.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    [storeProductViewController loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier : applicationID} completionBlock:^(BOOL result, NSError *error) {
        if (error) {
            NSLog(@"Error %@ with User Info %@.", error, [error userInfo]);
        } else {
            // Present Store Product View Controller
            [self presentViewController:storeProductViewController animated:YES completion:nil];
        }
    }];
}

#pragma mark - Cancel
- (void)doneItemPress:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
