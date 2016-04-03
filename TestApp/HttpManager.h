//
//  HttpManager.h
//  TestApp
//
//  Created by ruchin somal on 02/04/16.
//  Copyright © 2016 ruchin somal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
typedef void (^SuccessRequestBlock) (BOOL wasSuccessful, NSDictionary *dict);

@interface HttpManager : NSObject
{
    NSString *url;
}

- (void)getRequestWithCallBack:(NSDictionary *)dict
                  withCallback:(SuccessRequestBlock)callback;
@end
