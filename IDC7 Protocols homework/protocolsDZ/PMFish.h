//
//  PMFish.h
//  protocolsDZ
//
//  Created by Петр Первухин on 29.04.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMSwimers.h"


@interface PMFish : NSObject <PMSwimers>

@property(strong,nonatomic) NSString* name;

@end
