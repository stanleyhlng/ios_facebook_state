//
//  User.h
//  ios_facebook_state
//
//  Created by Stanley Ng on 6/13/14.
//  Copyright (c) 2014 Stanley Ng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong) NSDictionary *nameDict;

@end
