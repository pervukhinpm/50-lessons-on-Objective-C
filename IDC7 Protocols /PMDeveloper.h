//
//  PMDeveloper.h
//  Protocols
//
//  Created by Петр Первухин on 27.04.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMPatient.h"


@interface PMDeveloper : NSObject <PMPatient>

@property (assign,nonatomic) NSInteger expirience;
@property (strong,nonatomic) NSString* name;

-(void) work;

@end
