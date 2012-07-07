//
//  LBViewController.h
//  Aperio
//

#import <UIKit/UIKit.h>

typedef void (^LBCompanyDataRetrievalFinishBlock)(NSMutableArray *results, NSError *error);

@interface LBViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
    NSMutableArray *_companyData;
    
    IBOutlet UITableView *_companyTableView;
    IBOutlet UISearchBar *_companySearchBar;
}

@property (nonatomic, strong) UITableView *companyTableView;
@property (nonatomic, strong) UISearchBar *companySearchBar;
@property (nonatomic, strong) NSMutableArray *companyData;

@end
