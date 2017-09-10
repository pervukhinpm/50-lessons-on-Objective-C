//
//  PMDancer.h
//  Protocols
//
//  Created by Петр Первухин on 27.04.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMPatient.h"

@interface PMDancer : NSObject <PMPatient>

@property(strong,nonatomic) NSString* favoriteDancer;
@property (strong,nonatomic) NSString* name;

- (void) dance;

@end
