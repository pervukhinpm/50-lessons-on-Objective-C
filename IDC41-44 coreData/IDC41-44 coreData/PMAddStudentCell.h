//
//  PMAddStudentCell.h
//  IDC41-44 coreData
//
//  Created by Петр Первухин on 10.08.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMAddStudentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@end
