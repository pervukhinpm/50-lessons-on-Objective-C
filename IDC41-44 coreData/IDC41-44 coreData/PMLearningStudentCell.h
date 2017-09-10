//
//  PMLearningStudentCell.h
//  IDC41-44 coreData
//
//  Created by Петр Первухин on 26.08.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMLearningStudentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (assign, nonatomic) BOOL isSelected;
@property (assign, nonatomic) BOOL isEdit;

- (void) makeColorAndAccessory;

@end
