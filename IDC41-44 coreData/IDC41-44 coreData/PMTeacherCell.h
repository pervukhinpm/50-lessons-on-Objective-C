//
//  PMTeacherCell.h
//  IDC41-44 coreData
//
//  Created by Петр Первухин on 26.08.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMTeacherViewController.h"

@class PMStudent;

@interface PMTeacherCell : UITableViewCell <PMTeacherProtocol>
@property (weak, nonatomic) IBOutlet UITextField *teacherField;
@property (weak, nonatomic) PMStudent *teacher;
@property (assign, nonatomic) NSInteger selectedRow;


@end
