//
//  PMStudent.h
//  Multithreading
//
//  Created by Петр Первухин on 25.05.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PMStudent : NSObject

@property (strong,nonatomic) NSString* name;
@property (assign,nonatomic) double finishTime;
@property (assign,nonatomic) NSInteger currentNumber;

- (void) guessNumberFrom :(NSInteger) startNumber to: (NSInteger) endNumber number: (NSInteger) number andBlock: (void(^)(void)) block;

@end
