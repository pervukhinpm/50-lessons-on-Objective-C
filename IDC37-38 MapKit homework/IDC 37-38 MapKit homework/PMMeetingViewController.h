//
//  PMMeetingViewController.h
//  IDC 37-38 MapKit homework
//
//  Created by Петр Первухин on 02.08.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PMAmountOfStudents <NSObject>

@property (strong, nonatomic, readonly) NSMutableArray *students;

@property (strong, nonatomic, readonly) NSMutableArray *withoutCircleStudents;
@property (strong, nonatomic, readonly) NSMutableArray *firstCircleStudents;
@property (strong, nonatomic, readonly) NSMutableArray *secondCircleStudents;
@property (strong, nonatomic, readonly) NSMutableArray *thirdCircleStudents;

@end

@interface PMMeetingViewController : UITableViewController

@property (weak, nonatomic) id <PMAmountOfStudents> delegate;

- (IBAction)actionOKPressed:(UIButton *)sender;

@end
