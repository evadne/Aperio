//
//  LBViewController.m
//  Aperio
//
//  Created by Andrew Lauer Barinov on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LBViewController.h"
#import "LBHTTPClient.h"

@interface LBViewController ()

@end

@implementation LBViewController

@synthesize companyTableView = _companyTableView, companySearchBar = _companySearchBar, companyData = _companyData;

# pragma mark - View Loading Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

# pragma mark - Table View Data Source and Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_companyData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create table view cell
    UITableViewCell *cell = [_companyTableView dequeueReusableCellWithIdentifier:@"CompanyCell"];
    
    if (cell == nil) 
    {
        // Construct New Table View Cell here
    }
    
    // Fill in table view cell values here
    
    return cell;
}

# pragma mark - Search Bar Delegate Methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *searchQuery = [searchBar text];
    
    [self submitCompanyLookupQuery:searchQuery];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{

}

# pragma mark - API Methods

- (void)submitCompanyLookupQuery:(NSString*)lookupQuery
{
    // Encapsulate the HTTP client method for the time being
    // Additional logic?
    // @todo Error Handling Code
    
    NSLog(@"searching for %@",lookupQuery);
    
    [[LBHTTPClient sharedHTTPClient] getCompanyDataWithString:lookupQuery finish:^(NSMutableArray *results, NSError *error){
        [self setCompanyData:results];
        NSLog(@"The companies count is %d",self.companyData.count);
        [self.companyTableView reloadData];
    }];
    
}

@end
