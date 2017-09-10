//
//  PMHuman.h
//  DZMassive
//
//  Created by Петр Первухин on 27.04.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PMHuman : NSObject

@property(strong,nonatomic) NSString* name;
@property(assign,nonatomic) NSInteger weight;
@property(assign,nonatomic) NSInteger height;
@property(strong,nonatomic) NSString* gender;

-(void) move;

@end
