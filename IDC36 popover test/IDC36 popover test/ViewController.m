//
//  ViewController.m
//  IDC36 popover test
//
//  Created by Петр Первухин on 24.07.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "ViewController.h"
#import "DetailsViewController.h"

@interface ViewController () <UIPopoverControllerDelegate>

@property (strong,nonatomic) UIPopoverController* popover;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

-(void) showControllerAsModal:(UIViewController*) vc{
    [self presentViewController:vc
                       animated:YES
                     completion:^{
                         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                             [self dismissViewControllerAnimated:YES completion:nil];
                         });
                     }];
    
}
                                        
-(IBAction) actionAdd:(UIBarButtonItem*) sender{
    DetailsViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
   
        UIPopoverController* popover = [[UIPopoverController alloc] initWithContentViewController:vc];

        popover.delegate = self;
    
        [popover presentPopoverFromBarButtonItem:sender
                        permittedArrowDirections:UIPopoverArrowDirectionAny
                                        animated:YES];
        self.popover = popover;
    }else{
        [self showControllerAsModal:vc];
    }
}

-(IBAction) actionPresssMe:(UIButton*) sender{
    
    DetailsViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        
        
        UIPopoverController* popover = [[UIPopoverController alloc] initWithContentViewController:vc];
        
        popover.delegate = self;
        
        [popover presentPopoverFromRect:sender.frame
                                 inView:self.view
               permittedArrowDirections:UIPopoverArrowDirectionAny
                               animated:YES];
        
        self.popover = popover;
    }else{
        [self showControllerAsModal:vc];
    }
}


- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController NS_DEPRECATED_IOS(3_2, 9_0){
    self.popover = nil;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"prepareForSegue %@",segue.identifier);
}

@end
