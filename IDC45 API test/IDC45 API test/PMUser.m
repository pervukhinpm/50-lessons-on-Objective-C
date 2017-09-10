//
//  PMUser.m
//  IDC45 API test
//
//  Created by Петр Первухин on 09.09.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "PMUser.h"

@implementation PMUser

- (id) initWithServerResponse:(NSDictionary*) responseObject
{
    self = [super init];
    if (self) {
        
        self.firstName = [responseObject objectForKey:@"first_name"];
        self.lastName = [responseObject objectForKey:@"last_name"];
        
        NSString* urlString = [responseObject objectForKey:@"photo_50"];
        
        if (urlString) {
            self.imageURL = [NSURL URLWithString:urlString];
        }
    }
    return self;
}


@end
