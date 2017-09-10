//
//  ASBoxer.h
//  Properties part1
//
//  Created by Петр Первухин on 26.04.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASBoxer : NSObject

@property (strong,nonatomic) NSString* name;
@property (assign,nonatomic) NSInteger age;
@property (assign,nonatomic) double weight;

-(NSInteger) howoldareyou;

@end
