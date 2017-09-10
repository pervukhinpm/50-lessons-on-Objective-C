//
//  PMCourseOverallTableViewController.h
//  IDC41-44 coreData
//
//  Created by Петр Первухин on 28.08.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PMCourse;

@interface PMCourseOverallTableViewController : UITableViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) PMCourse *course;

@end
