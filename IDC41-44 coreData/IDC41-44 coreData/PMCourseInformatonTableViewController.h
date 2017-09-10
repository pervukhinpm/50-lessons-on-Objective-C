//
//  PMCourseInformatonTableViewController.h
//  IDC41-44 coreData
//
//  Created by Петр Первухин on 25.08.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PMLearningStudentCell;
@class PMCoursesNameAndSubjectCell;
@class PMStudyBranchesCell;
@class PMTeacherCell;
@class PMCourse;
@class PMCourseCell;

@interface PMCourseInformatonTableViewController : UITableViewController

@property (weak, nonatomic) PMCoursesNameAndSubjectCell *nameCell;
@property (weak, nonatomic) PMCoursesNameAndSubjectCell *subjectCell;
@property (weak, nonatomic) PMStudyBranchesCell *studyBranchesCell;
@property (weak, nonatomic) PMTeacherCell *teacherCell;
@property (strong, nonatomic) NSString *titleName;
@property (strong, nonatomic) NSMutableArray<PMLearningStudentCell *>* studentCells;
@property (weak, nonatomic) PMCourse *editCourse;
@property (weak, nonatomic) PMCourseCell *editCell;


- (IBAction)actionSave:(UIBarButtonItem *)sender;



@end
