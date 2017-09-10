//
//  PMDataManager.m
//  IDC41-44 coreData
//
//  Created by Петр Первухин on 10.08.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "PMDataManager.h"

@implementation PMDataManager

#pragma mark - Shared manager

+ (PMDataManager *) sharedManager {
    
    static PMDataManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[PMDataManager alloc] init];
    });
    
    return manager;
}
#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"IDC41_44_coreData"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription,
                                                                              NSError *error) {
                
                if (error != nil) {
                    
                    [[NSFileManager defaultManager] removeItemAtURL:storeDescription.URL
                                                              error:&error];
                    
                    [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription,
                                                                                      NSError *error) {
                        if (error != nil) {
                            NSLog(@"%@", error.localizedDescription);
                        }
                    }];
                    
                }
                
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}



@end
