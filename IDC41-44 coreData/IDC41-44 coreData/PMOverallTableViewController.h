//
//  PMOverallTableViewController.h
//  IDC41-44 coreData
//
//  Created by Петр Первухин on 24.08.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PMStudent;

@interface PMOverallTableViewController : UITableViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) PMStudent *student;

@end
