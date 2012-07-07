//
//  LBCompany.h
//  Aperio
//
//  Created by Andrew Barinov on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBCompany : NSObject
{
    NSString *_name;
    NSString *_symbol;
    NSString *_exchange;
}

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *symbol;
@property (nonatomic, strong) NSString *exchange;

// Designated Initializer
- (id)initWithName:(NSString*)aName Symbol:(NSString*)aSumbol Exchange:(NSString*)anExchange;

@end
