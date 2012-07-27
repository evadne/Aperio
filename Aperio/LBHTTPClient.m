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

//static LBHTTPClient *sharedHTTPClient;

#pragma mark - Designated Intitializer

- (id) initHTTPClient
{
    self = [super initWithBaseURL:[NSURL URLWithString:kMarkitBaseURL]];
    
    if (self) 
    {
        // Sub class specific initializations
    }
    
    return self;
}

#pragma mark - Singleton Methods

+ (LBHTTPClient*) sharedHTTPClient
{
    static dispatch_once_t once = 0;
    static LBHTTPClient *sharedHTTPClient = nil;
    dispatch_once(&once, ^{
        sharedHTTPClient = [[LBHTTPClient alloc] initHTTPClient];
    });
    
    NSLog(@"This memory address should never change: %@",(LBHTTPClient*) sharedHTTPClient.description);
    
    return sharedHTTPClient;
}

#pragma mark - Markit API Methods

- (void)getCompanyDataWithString:(NSString*)companySearchQuery finish:(LBMarkitAPIRequestCompletionBlock)finishBlock
{
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setParameterEncoding:AFJSONParameterEncoding];
//    NSURL *searchQueryURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kMarkitBaseURL,kMarkitCompanyURL]];
    NSDictionary *params = [NSDictionary dictionaryWithObject:companySearchQuery forKey:@"input"];
    NSMutableURLRequest *searchQueryRequest = [self requestWithMethod:@"GET" path:kMarkitCompanyURL parameters:params];
    NSLog(@"making URL request");
    
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
                                                           failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
                                                           {
                                                               NSLog(@"request failed: %@",[error localizedDescription]);
                                                               NSLog(@"Response: %@",response);
                                                               NSLog(@"JSON: %@",JSON);
                                                           }];
    [searchQueryRequestOperation start];
    NSLog(@"JSON operation started");
}

@end