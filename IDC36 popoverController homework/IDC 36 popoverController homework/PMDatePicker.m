//
//  PMDatePicker.m
//  IDC 36 popoverController homework
//
//  Created by Петр Первухин on 26.07.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "PMDatePicker.h"

@implementation PMDatePicker

-(void)sendActionsForControlEvents:(UIControlEvents)controlEvents{
    if(controlEvents == UIControlEventValueChanged){
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"dd MMMM yyyy";
        self.sender.text = [formatter stringFromDate: self.date];
    }
}

@end
