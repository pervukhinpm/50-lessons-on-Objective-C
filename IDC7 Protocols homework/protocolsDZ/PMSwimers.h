//
//  PMSwimers.h
//  protocolsDZ
//
//  Created by Петр Первухин on 29.04.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PMSwimers <NSObject>


@property(strong,nonatomic) NSString* name;
-(void) swim;

@optional
-(void) run;

@end
