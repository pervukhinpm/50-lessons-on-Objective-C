//
//  PMStudentDescription.h
//  IDC 37-38 MapKit homework
//
//  Created by Петр Первухин on 01.08.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMStudentDescription : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *adressLabel;

- (IBAction)okButton:(UIButton *)sender;

@end
