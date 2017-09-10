//
//  PMServerManager.m
//  IDC45 API test
//
//  Created by Петр Первухин on 09.09.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "PMServerManager.h"
#import "AFNetworking.h"
#import "PMUser.h"


@interface PMServerManager () 

@property (strong, nonatomic) AFHTTPSessionManager* requestOperationManager;

@end


@implementation PMServerManager




+(PMServerManager*) sharedManager{
    static PMServerManager* manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[PMServerManager alloc] init];
    });
    return manager;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        NSURL* url = [NSURL URLWithString:@"https://api.vk.com/method/"];
        
        self.requestOperationManager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    }
    return self;
}

-(void) getFriendsWithOffSet:(NSInteger) offset
                       count:(NSInteger) count
                   onSuccess:(void(^)(NSArray* friends)) success
                   onFailure:(void(^)(NSError* error,NSInteger statusCode)) failure{
    NSDictionary* params =
    [NSDictionary dictionaryWithObjectsAndKeys:
     @"11598002",   @"user_id",
     @"name",       @"order",
     @(count),      @"count",
     @(offset),     @"offset",
     @"photo_50",   @"fields",
     @"nom",        @"name_case", nil];
    
    [self.requestOperationManager
     GET:@"friends.get"
     parameters:params
    progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
     NSLog(@"JSON: %@", responseObject);
        
         
         NSArray* dictsArray = [responseObject objectForKey:@"response"];
         
         NSMutableArray* objectsArray = [NSMutableArray array];
         
         for (NSDictionary* dict in dictsArray) {
             PMUser* user = [[PMUser alloc] initWithServerResponse:dict];
             [objectsArray addObject:user];
         }
         
 
         if (success){
             success(objectsArray);
         }
         
         
     }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"error: %@", error);
 
         if (failure) {
             
             NSInteger statusCode = 0;
             NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
             
             if ([httpResponse isKindOfClass:[NSHTTPURLResponse class]]) {
                 statusCode = httpResponse.statusCode;
             }
             
             failure(error, statusCode);
         }
     }];
}






@end
