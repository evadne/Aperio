//
//  LBViewController.h
//  Aperio
//
//  Created by Andrew Lauer Barinov on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_companyData;
}

@property (nonatomic, strong) UITableView *companyTableView;

@property (nonatomic, strong) NSMutableArray *companyData;

@end
