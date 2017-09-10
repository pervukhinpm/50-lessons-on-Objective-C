//
//  PMAddStudentTableViewController.h
//  IDC41-44 coreData
//
//  Created by Петр Первухин on 10.08.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PMAddStudentCell;
@class PMStudentCell;


@interface PMAddStudentTableViewController : UITableViewController

@property (strong, nonatomic) NSString *titleName;
@property (weak, nonatomic) PMStudentCell *editCell;

@property (weak, nonatomic) PMAddStudentCell *studentfirstName;
@property (weak, nonatomic) PMAddStudentCell *studentLastName;
@property (weak, nonatomic) PMAddStudentCell *studentEmail;

- (IBAction)saveAction:(UIBarButtonItem *)sender;

@end
