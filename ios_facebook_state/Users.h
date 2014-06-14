//
//  Users.h
//  ios_facebook_state
//
//  Created by Stanley Ng on 6/14/14.
//  Copyright (c) 2014 Stanley Ng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Users : NSObject

@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, strong) NSString *current;

+ (instancetype)instance;

- (NSString *)getCurrent;
- (NSString *)getCurrentFeedView;
- (NSString *)getCurrentMoreView;
- (NSString *)getCurrentProfileImage;

@end
