//
//  AppDelegate.m
//  BeGood
//
//  Created by Leo Chang on 3/31/14.
//  Copyright (c) 2014 Perfectidea Inc. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>

#import "Story.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // ****************************************************************************
    // Uncomment and fill in with your Parse credentials:
    [Parse setApplicationId:ParseApplicationKey clientKey:ParseClientKey];
    //
    // If you are using Facebook, uncomment and add your FacebookAppID to your bundle's plist as
    // described here: https://developers.facebook.com/docs/getting-started/facebook-sdk-for-ios/
    // [PFFacebookUtils initializeFacebook];
    // ****************************************************************************
    
    [PFUser enableAutomaticUser];
    
    PFACL *defaultACL = [PFACL ACL];
    
    // If you would like all objects to be private by default, remove this line.
    [defaultACL setPublicReadAccess:YES];
    
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
    
    [self GetStoryDataFromParse];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)GetStoryDataFromParse {
    NSMutableArray *array = [NSMutableArray array];
    PFQuery *query = [PFQuery queryWithClassName:@"Story"];
    [query orderByDescending:@"from"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %li scores.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                @autoreleasepool
                {
                    NSString *price = [object valueForKey:@"price"];
                    Story *item = [Story new];
                    item.title = object[@"title"];
                    item.content = object[@"content"];
                    item.detail = object[@"detail"];
                    item.price = [NSNumber numberWithInteger:price.integerValue];
                    item.status = (BOOL)object[@"status"];
                    item.from = object[@"from"];
                    item.to = object[@"to"];
                    item.imageUrls = @[@"https://dl.dropboxusercontent.com/u/18183877/imac.jpeg"];
                    [array addObject:item];
                }
            }
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:array, StoryKey, nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:StoryFinishEvent object:dict];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

@end
