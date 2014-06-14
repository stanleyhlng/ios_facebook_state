//
//  Users.m
//  ios_facebook_state
//
//  Created by Stanley Ng on 6/14/14.
//  Copyright (c) 2014 Stanley Ng. All rights reserved.
//

#import "Users.h"

@implementation Users

+ (instancetype)instance
{
    static Users *users = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        users = [Users new];
        
        NSDictionary *data = @{
                               @"stanley@yahoo-inc.com":@{
                                       @"name":@"Stanley Ng",
                                       @"view_feed":@"view-feed",
                                       @"view_more":@"view-more"
                                       },
                               @"mmayer@yahoo-inc.com":@{
                                       @"name": @"Marissa Mayer",
                                       @"view_feed":@"view-feed-marissa",
                                       @"view_more":@"view-more-marissa"
                                       }
                               };
        users.data = data;
        users.current = @"";
        
    });
    
    return users;
}

- (NSString *)getCurrent
{
    return self.current;
}

- (NSString *)getCurrentFeedView
{
    NSString *view = @"view-feed";
    NSDictionary *data = [self.data objectForKey:self.current];
    if (data) {
            view = [data objectForKey:@"view_feed"];
    }
    return view;
}

- (NSString *)getCurrentMoreView
{
    NSString *view = @"view-more";
    NSDictionary *data = [self.data objectForKey:self.current];
    if (data) {
        view = [data objectForKey:@"view_more"];
    }
    return view;
}

@end
