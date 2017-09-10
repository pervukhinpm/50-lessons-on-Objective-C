//
//  PMJumpers.h
//  protocolsDZ
//
//  Created by Петр Первухин on 29.04.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PMJumpers <NSObject>


@property(strong,nonatomic) NSString* name;

-(void) jump;

@optional

-(void) eatSomething;

@end
