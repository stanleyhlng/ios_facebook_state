//
//  User.m
//  ios_facebook_state
//
//  Created by Stanley Ng on 6/13/14.
//  Copyright (c) 2014 Stanley Ng. All rights reserved.
//

#import "User.h"

@implementation User

+ (instancetype)sharedInstance
{
    static User *user = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        user = [User new];
        
        NSDictionary *dict = @{@"stanley":@"Stanley Ng", @"kenny":@"Kenny Tang"};
        user.nameDict = dict;
        
    });
    
    return user;
}

@end
