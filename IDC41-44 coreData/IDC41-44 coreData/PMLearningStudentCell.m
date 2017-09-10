//
//  PMLearningStudentCell.m
//  IDC41-44 coreData
//
//  Created by Петр Первухин on 26.08.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "PMLearningStudentCell.h"

@implementation PMLearningStudentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) makeColorAndAccessory {
    
    if (!self.isSelected) {
        
        self.isSelected = YES;
        
        self.accessoryType = UITableViewCellAccessoryCheckmark;
        
        UIView * selectedBackgroundView = [[UIView alloc] init];
        [selectedBackgroundView setBackgroundColor:[UIColor colorWithRed:0.8f green:1.f blue:0.5f alpha:0.75f]]; // set color here
        [self setBackgroundView:selectedBackgroundView];
        
    } else {
        
        self.isSelected = NO;
        
        self.accessoryType = UITableViewCellAccessoryNone;
        
        UIView * selectedBackgroundView = [[UIView alloc] init];
        [selectedBackgroundView setBackgroundColor:[UIColor colorWithRed:1.f green:1.f blue:1.f alpha:0.75f]]; // set color here
        [self setBackgroundView:selectedBackgroundView];
    }
    
}

@end
