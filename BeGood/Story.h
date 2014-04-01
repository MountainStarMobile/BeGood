//
//  Story.h
//  BeGood
//
//  Created by Leo Chang on 4/1/14.
//  Copyright (c) 2014 Perfectidea Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Story : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, strong) NSString *from;
@property (nonatomic, strong) NSString *to;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSArray *imageUrls;
@property BOOL status;

@end
