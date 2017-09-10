//
//  PMStudent.m
//  Multithreading
//
//  Created by Петр Первухин on 25.05.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "PMStudent.h"

@implementation PMStudent


+ (dispatch_queue_t) initQueue {
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        queue = dispatch_queue_create("com.petrpervukhin.pmstudent.queue", DISPATCH_QUEUE_CONCURRENT);
    });
    return queue;
}



- (void) guessNumberFrom :(NSInteger) startNumber to: (NSInteger) endNumber number: (NSInteger) number  andBlock: (void(^)(void)) block {
    if (number>startNumber && number<endNumber){
        
       // dispatch_queue_t queue = dispatch_queue_create("com.petrpervukhin.pmstudent.queue", DISPATCH_QUEUE_SERIAL);
        dispatch_async([PMStudent initQueue], ^{
            
            double startTime =CACurrentMediaTime();
            NSLog(@"%@ started", self.name);
            NSInteger currentNumber = number;
           
            while (currentNumber != number) {
                currentNumber = startNumber + arc4random_uniform(endNumber-startNumber+1);
            }
            self.finishTime = CACurrentMediaTime()-startTime;
            self.currentNumber = currentNumber;
            block();
            
        });
        
        
    }else{
        NSLog(@"wrong range");
    }
    
    
    
    
}

@end
