//
//  PMTeacherViewController.h
//  IDC41-44 coreData
//
//  Created by Петр Первухин on 27.08.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PMStudent;

@protocol PMTeacherProtocol <NSObject>

@property (weak, nonatomic) IBOutlet UITextField *teacherField;
@property (weak, nonatomic) PMStudent *teacher;
@property (assign, nonatomic) NSInteger selectedRow;

@end

@interface PMTeacherViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) id<PMTeacherProtocol> delegate;
@property (weak, nonatomic) IBOutlet UIPickerView *teacherPicker;
- (IBAction)actionDoneButton:(UIButton *)sender;

@end

