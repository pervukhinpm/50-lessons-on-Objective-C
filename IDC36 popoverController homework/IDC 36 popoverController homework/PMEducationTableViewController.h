//
//  PMEducationTableViewController.h
//  IDC 36 popoverController homework
//
//  Created by Петр Первухин on 26.07.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EducationDelegate <NSObject>

@property (weak,nonatomic) UITextField* educationTextField;

@end

@interface PMEducationTableViewController : UITableViewController

@property (weak, nonatomic) id <EducationDelegate> delegate;

- (IBAction)doneAction:(UIBarButtonItem *)sender;

@end
