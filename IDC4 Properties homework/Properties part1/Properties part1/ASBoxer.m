//
//  ASBoxer.m
//  Properties part1
//
//  Created by Петр Первухин on 26.04.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "ASBoxer.h"

@interface ASBoxer ()
@property (assign,nonatomic) NSInteger namecount;
@end


@implementation ASBoxer
@synthesize name=_name;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.namecount=0;
    }
    return self;
}

- (void) setName:(NSString *)inputName{
    NSLog(@"setter is called");
    _name= inputName;
}

-(NSString*) name {
    
    self.namecount+=1;
    NSLog(@" name is called %ld times",self.namecount);
    
    return _name;
}

-(NSInteger) age {
    NSLog(@"bye");
    return _age;
}

-(NSInteger) howoldareyou {
    
    return _age;
}



@end
