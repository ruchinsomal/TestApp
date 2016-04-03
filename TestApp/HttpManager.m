//
//  HttpManager.m
//  TestApp
//
//  Created by ruchin somal on 02/04/16.
//  Copyright © 2016 ruchin somal. All rights reserved.
//

#import "HttpManager.h"

@implementation HttpManager
- (id)init {
    self = [super init];
    if (self) {
        url = @"http://androidservice.in";
    }
    return self;
}

- (void)getRequestWithCallBack:(NSDictionary *)dict
                  withCallback:(SuccessRequestBlock)callback
{
    NSString *getUrl = [NSString stringWithFormat:@"%@/%@/%@/%@",url,dict[@"parameter1"],dict[@"parameter2"],dict[@"parameter3"]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:getUrl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *dict = responseObject;
        callback(YES,dict);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        callback(NO,nil);
        NSLog(@"Error: %@", error);
    }];
}
@end
