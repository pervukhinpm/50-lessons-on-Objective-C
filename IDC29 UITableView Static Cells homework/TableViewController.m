//
//  TableViewController.m
//  IDC29 UITableView Static Cells homework
//
//  Created by Петр Первухин on 29.06.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end
static  NSString* kSettingsLogin        = @"login";
static  NSString* kSettingsPassword     = @"password";
static  NSString* kSettingsLevel        = @"level";
static  NSString* kSettingsShadows      = @"shadows";
static  NSString* kSettingsTextures     = @"textures";
static  NSString* kSettingsSound        = @"sound";
static  NSString* kSettingsMusic        = @"music";


@implementation TableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSettings];
    
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(notificationKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [nc addObserver:self selector:@selector(notificationKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
}

-(void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Nottification

-(void) notificationKeyboardWillShow :(NSNotification*) notification {
    NSLog(@"notificationKeyboardWillShow:\n%@",notification.userInfo);
}
-(void) notificationKeyboardWillHide :(NSNotification*) notification {
    NSLog(@"notificationKeyboardWillHide:\n%@",notification.userInfo);

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Save and Load settings


-(void) saveSettings{
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.loginFields.text forKey:kSettingsLogin];
    [userDefaults setObject:self.passwordFields.text forKey:kSettingsPassword];
    [userDefaults setInteger:self.levelControl.selectedSegmentIndex forKey:kSettingsLevel];
    [userDefaults setBool:self.shadowsSwitch.isOn forKey:kSettingsShadows];
    [userDefaults setInteger:self.texturesControl.selectedSegmentIndex forKey:kSettingsTextures];
    [userDefaults setDouble:self.soundSlider.value forKey:kSettingsSound];
    [userDefaults setDouble:self.musicSlider.value forKey:kSettingsMusic];
    
    [userDefaults synchronize];
}

-(void) loadSettings{
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    self.loginFields.text =[userDefaults objectForKey:kSettingsLogin];
    self.passwordFields.text = [userDefaults objectForKey:kSettingsPassword];
    self.levelControl.selectedSegmentIndex = [userDefaults integerForKey:kSettingsLevel];
    self.shadowsSwitch.on = [userDefaults boolForKey:kSettingsShadows];
    self.texturesControl.selectedSegmentIndex = [userDefaults integerForKey:kSettingsTextures];
    self.soundSlider.value = [userDefaults doubleForKey:kSettingsSound];
    self.musicSlider.value = [userDefaults doubleForKey:kSettingsMusic];
    
}

- (IBAction)actionTextChanged:(UITextField *)sender {
    [self saveSettings];
    
    
}

- (IBAction)actionValueChangrd:(id)sender {
    [self saveSettings];
    
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
  
    if ([textField isEqual:self.loginFields]){
        [self.passwordFields becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    
    return  NO;
}

@end
