//
//  LBHTTPClient.m
//  Aperio
//

#define kMarkitBaseURL @"http://dev.markitondemand.com/Api/"
#define kMarkitCompanyURL @"Lookup"
#define kMarkingStockQuoteURL @"Quote"

#import "AFNetworking.h"
#import "LBHTTPClient.h"
#import "LBCompany.h"

@implementation LBHTTPClient

// Singleton Methods

static LBHTTPClient *sharedHTTPClient;


- (id) initHTTPClient
{
    self = [super initWithBaseURL:[NSURL URLWithString:kMarkitBaseURL]];
    
    if (self) 
    {
        // Sub class specific initializations
    }
    
    return self;
}

+ (LBHTTPClient*)sharedHTTPClient
{
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        sharedHTTPClient = [[self alloc] initHTTPClient];
    });
    
    NSLog(@"This memory address should never change: %@",sharedHTTPClient.description);
    
    return sharedHTTPClient;
}

+ (id)allocWithZone:(NSZone *)zone 
{
    return [LBHTTPClient sharedHTTPClient];
}

// Request Construction

//- (void)sendMarkitAPIRequest:(AFJSONRequestOperation*)JSONRequest onCompletion:(LBMarkitAPIRequestCompletionBlock)
//    {
//
//    }
//{
//    [JSONRequest start];
//}

- (void)getCompanyDataWithString:(NSString*)companySearchQuery finish:(LBMarkitAPIRequestCompletionBlock)finishBlock
{
    NSURL *searchQueryURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kMarkitBaseURL,kMarkitCompanyURL]];
    NSURLRequest *searchQueryRequest = [NSURLRequest requestWithURL:searchQueryURL];
    
    AFJSONRequestOperation *searchQueryRequestOperation = [AFJSONRequestOperation 
                                                           JSONRequestOperationWithRequest:searchQueryRequest 
                                                           success:^(NSURLRequest *request, NSHTTPURLResponse *response, id json) {
                                                               NSLog(@"Response: %@", response);
                                                               NSLog(@"JSON: %@",json);
                                                               NSMutableArray *results = [NSMutableArray array];
                                                               
                                                               NSError *anError = [[NSError alloc] init];
                                                               if ([json objectForKey:@"Message"]) 
                                                               {
                                                                   anError = [[NSError alloc] initWithDomain:[json objectForKey:@"Message"] 
                                                                                                        code:100 
                                                                                                    userInfo:nil];
                                                               }
                                                               
                                                               // Need some error handling code here
                                                               for (id item in json) 
                                                               {
                                                                   NSString *aName = [item objectForKey:@"Name"];
                                                                   NSString *aSymbol = [item objectForKey:@"Symbol"];
                                                                   NSString *anExchange = [item objectForKey:@"Exchange"];
                                                                   
                                                                   LBCompany *aCompany = [[LBCompany alloc] initWithName:aName Symbol:aSymbol Exchange:anExchange];
                                                                   [results addObject:aCompany];
                                                               }
                                                               // Need to run the passed in block after JSON Request Operation succeeds
                                                               
                                                               finishBlock(results,anError);
                                                           }
                                                           failure:nil];
    [searchQueryRequestOperation start];
    
}
@end