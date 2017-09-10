//
//  PMMeetingViewCell.h
//  IDC 37-38 MapKit homework
//
//  Created by Петр Первухин on 02.08.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMMeetingViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *statusImage;

@end
