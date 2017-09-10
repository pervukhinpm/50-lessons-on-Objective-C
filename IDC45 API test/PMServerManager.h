//
//  PMServerManager.h
//  IDC45 API test
//
//  Created by Петр Первухин on 09.09.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMServerManager : NSObject

+(PMServerManager*) sharedManager;

-(void) getFriendsWithOffSet:(NSInteger) offset
                       count:(NSInteger) count
                   onSuccess:(void(^)(NSArray* friends)) success
                   onFailure:(void(^)(NSError* error,NSInteger statusCode)) failure;


@end
