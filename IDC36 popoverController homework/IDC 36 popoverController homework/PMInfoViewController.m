//
//  PMInfoViewController.m
//  IDC 36 popoverController homework
//
//  Created by Петр Первухин on 25.07.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "PMInfoViewController.h"

@interface PMInfoViewController ()

@end

@implementation PMInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)dismisPopoverAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) dealloc{
    NSLog(@"Info popover deallocated");
}
@end
