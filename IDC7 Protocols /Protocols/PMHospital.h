//
//  PMHospital.h
//  Protocols
//
//  Created by Петр Первухин on 27.04.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PMHospital

@property (strong,nonatomic) NSString* name;


-(BOOL) areYouOk;
-(void)takePill;
-(void)makeShot;

@end
