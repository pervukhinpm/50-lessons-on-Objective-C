//
//  PMCoursesNameAndSubjectCell.h
//  IDC41-44 coreData
//
//  Created by Петр Первухин on 26.08.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMCoursesNameAndSubjectCell : UITableViewCell


@property (assign, nonatomic) BOOL nameIsOk;
@property (assign, nonatomic) BOOL subjectIsOk;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *subjectField;

@property (weak, nonatomic) IBOutlet UIImageView *nameIsOkImage;
@property (weak, nonatomic) IBOutlet UIImageView *subjectIsOkImage;

@end
