//
//  PMAnimals.h
//  DZMassive
//
//  Created by Петр Первухин on 27.04.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMAnimals : NSObject

@property (strong,nonatomic) NSString* type;
@property (strong,nonatomic) NSString* countrty;

-(void) move;

@end
