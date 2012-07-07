//
//  LBCompany.m
//  Aperio
//
//  Created by Andrew Barinov on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LBCompany.h"

@implementation LBCompany

@synthesize name = _name, symbol = _symbol, exchange = _exchange;

# pragma mark - Designated Intitializer

- (id)initWithName:(NSString*)aName Symbol:(NSString*)aSymbol Exchange:(NSString*)anExchange
{
    self = [super init];
    
    if (self) 
    {
        self.name = aName;
        self.symbol = aSymbol;
        self.exchange = anExchange;
    }
    
    return self;
}

@end
