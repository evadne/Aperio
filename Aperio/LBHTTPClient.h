//
//  LBHTTPClient.h
//  Aperio
//
//  Created by Andrew Barinov on 7/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AFHTTPClient.h"

typedef void (^LBMarkitAPIRequestCompletionBlock)(NSMutableArray *results, NSError *error);

@interface LBHTTPClient : AFHTTPClient

// @property (copy) LBMarkitAPIRequestCompletionBlock completionBlock;

- (id) initHTTPClient;
+ (LBHTTPClient*)sharedHTTPClient;
+ (id)allocWithZone:(NSZone *)zone;

- (void)getCompanyDataWithString:(NSString*)companySearchQuery finish:(LBMarkitAPIRequestCompletionBlock)finishBlock;

@end
