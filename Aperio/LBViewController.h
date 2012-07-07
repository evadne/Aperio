//
//  LBViewController.h
//  Aperio
//

#import <UIKit/UIKit.h>

typedef void (^LBCompanyDataRetrievalFinishBlock)(NSMutableArray *results, NSError *error);

@interface LBViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_companyData;
}

@property (nonatomic, strong) UITableView *companyTableView;

@property (nonatomic, strong) NSMutableArray *companyData;

@end
