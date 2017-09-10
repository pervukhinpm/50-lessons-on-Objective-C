//
//  ViewController.h
//  IDC26 controls homework
//
//  Created by Петр Первухин on 26.06.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *borderAnimationView;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISwitch *rotationSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *scaleSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *translationSwitch;
@property (weak, nonatomic) IBOutlet UISlider *speedSlider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *typeImageControl;
@property (weak, nonatomic) IBOutlet UILabel *speedValueLabel;



- (IBAction)changeImageControl:(UISegmentedControl *)sender;
- (IBAction)actionRotation:(UISwitch *)sender;
- (IBAction)actionScale:(UISwitch *)sender;
- (IBAction)actionTranslation:(UISwitch *)sender;
- (IBAction)actionSpeed:(UISlider *)sender;


@end

