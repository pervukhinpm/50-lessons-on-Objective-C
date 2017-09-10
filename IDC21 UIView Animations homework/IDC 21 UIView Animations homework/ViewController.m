//
//  ViewController.m
//  IDC 21 UIView Animations homework
//
//  Created by Петр Первухин on 19.06.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

/*
 
 1. Создайте 4 вьюхи у левого края ипада.
 2. Ваша задача всех передвинуть горизонтально по прямой за одно и тоже время
 3. Для каждой вьюхи используйте свою интерполяцию (EasyInOut, EasyIn и т.д.). Это для того, чтобы вы увидели разницу своими собственными глазами :)
 4. Добавте реверсивную анимацию и бесконечные повторения
 5. добавьте смену цвета на рандомный
 
 Студент
 
 5. Добавьте еще четыре квадратные вьюхи по углам - красную, желтую, зеленую и синюю
 6. За одинаковое время и при одинаковой интерполяции двигайте их всех случайно, либо по, либо против часовой стрелки в другой угол.
 7. Когда анимация закончиться повторите все опять: выберите направление и передвиньте всех :)
 8. Вьюха должна принимать в новом углу цвет той вьюхи, что была здесь до него ;)
 
 Мастер
 
 8. Нарисуйте несколько анимационных картинок человечка, который ходит.
 9. Добавьте несколько человечков на эту композицию и заставьте их ходить
 
 Супермена на этот раз нет, ничего сверхъестественного не смог придумать :(
 
 */



#import "ViewController.h"

@interface ViewController ()

@property (weak,nonatomic) UIView* viewCorner1;
@property (weak,nonatomic) UIView* viewCorner2;
@property (weak,nonatomic) UIView* viewCorner3;
@property (weak,nonatomic) UIView* viewCorner4;

//@property (weak, nonatomic) UIImageView* testImage;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGFloat deltaX = CGRectGetMaxX(self.view.bounds) - 50;
    
    UIView* square1 = [[UIView alloc] initWithFrame:CGRectMake(0, 130, 50, 50)];
    square1.backgroundColor = [UIColor redColor];
    
    UIView* square2 = [[UIView alloc] initWithFrame:CGRectMake(0, 230, 50, 50)];
    square2.backgroundColor = [UIColor greenColor];
   
    UIView* square3 = [[UIView alloc] initWithFrame:CGRectMake(0, 330, 50, 50)];
    square3.backgroundColor = [UIColor blueColor];
    
    UIView* square4 = [[UIView alloc] initWithFrame:CGRectMake(0, 430, 50, 50)];
    square4.backgroundColor = [UIColor orangeColor];
   /*
    [self.view addSubview:square1];
    [self.view addSubview:square2];
    [self.view addSubview:square3];
    [self.view addSubview:square4];
   */

   [self moveView:square1 byDeltaX:deltaX optionCurve:UIViewAnimationOptionCurveEaseInOut];
    [self moveView:square2 byDeltaX:deltaX optionCurve:UIViewAnimationOptionCurveEaseIn];
    [self moveView:square3 byDeltaX:deltaX optionCurve:UIViewAnimationOptionCurveEaseOut];
    [self moveView:square4 byDeltaX:deltaX optionCurve:UIViewAnimationOptionCurveLinear];
    
    // Student
    
    UIView* square5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    square5.backgroundColor = [UIColor redColor];
    UIView* square6 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.bounds)-50, 50, 50)];
    square6.backgroundColor = [UIColor greenColor];
    UIView* square8 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.view.bounds)-50, 0, 50, 50)];
    square8.backgroundColor = [UIColor blueColor];
    UIView* square7 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.view.bounds)-50,CGRectGetMaxY(self.view.bounds)-50, 50, 50)];
    square7.backgroundColor = [UIColor orangeColor];
   
    [self.view addSubview:square5];
    [self.view addSubview:square6];
    [self.view addSubview:square7];
    [self.view addSubview:square8];
   
    self.viewCorner1 = square5;
    self.viewCorner2 = square6;
    self.viewCorner3 = square7;
    self.viewCorner4 = square8;

   [self moveView];

   
  /*  UIImageView* imgView1= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.png"]];
    imgView1.center = CGPointMake(50, 300);
    [self.view addSubview:imgView1];
  
   */
    
}

-(void) moveView:(UIView*) view byDeltaX:(CGFloat) deltaX optionCurve:(UIViewAnimationOptions) option {
    
    CGFloat deltaY = 0.f;
    CGFloat time = 2.f;
    
    [UIView animateWithDuration:time
                          delay:0
                        options:option | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse
                     animations:^{
                         view.backgroundColor = [self randomColor];
                         view.transform = CGAffineTransformMakeTranslation(deltaX,deltaY);
                     }
                     completion:^(BOOL finished) {
                         
                     }];
    
}


-(void) moveView{
BOOL clockwise = arc4random() % 2;
   
    if (clockwise){
        [self moveClockwise];
    }else{
        [self moveСounterСlockwise];
    }
}

-(void) moveClockwise{
    CGRect frame1 = self.viewCorner1.frame;
    UIColor* color1 = self.viewCorner1.backgroundColor;
    
    CGRect frame2 = self.viewCorner2.frame;
    UIColor* color2 = self.viewCorner2.backgroundColor;

    CGRect frame3 = self.viewCorner3.frame;
    UIColor* color3 = self.viewCorner3.backgroundColor;

    CGRect frame4 = self.viewCorner4.frame;
    UIColor* color4 = self.viewCorner4.backgroundColor;

    [UIView animateWithDuration:2.f
                                   delay:0.f
                                 options: UIViewAnimationOptionCurveLinear
                              animations:^{
                                  self.viewCorner1.frame = frame4;
                                  self.viewCorner1.backgroundColor = color4;
                                  
                                  self.viewCorner2.frame = frame1;
                                  self.viewCorner2.backgroundColor = color1;
                                  
                                  self.viewCorner3.frame = frame2;
                                  self.viewCorner3.backgroundColor = color2;
                                  
                                  self.viewCorner4.frame = frame3;
                                  self.viewCorner4.backgroundColor = color3;
                                  
                              }
                              completion:^(BOOL finished) {
                                  if (finished) {
                                      [self moveView];
                                  }
                              }];
}

-(void)moveСounterСlockwise{
    CGRect frame1 = self.viewCorner1.frame;
    UIColor* color1 = self.viewCorner1.backgroundColor;
    
    CGRect frame2 = self.viewCorner2.frame;
    UIColor* color2 = self.viewCorner2.backgroundColor;
    
    CGRect frame3 = self.viewCorner3.frame;
    UIColor* color3 = self.viewCorner3.backgroundColor;
    
    CGRect frame4 = self.viewCorner4.frame;
    UIColor* color4 = self.viewCorner4.backgroundColor;
    
    [UIView animateWithDuration:2.f
                          delay:0.f
                        options: UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.viewCorner1.frame = frame2;
                         self.viewCorner1.backgroundColor = color2;
                         
                         self.viewCorner2.frame = frame3;
                         self.viewCorner2.backgroundColor = color3;
                         
                         self.viewCorner3.frame = frame4;
                         self.viewCorner3.backgroundColor = color4;
                         
                         self.viewCorner4.frame = frame1;
                         self.viewCorner4.backgroundColor = color1;
                         
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             [self moveView];
                         }
                     }];
}



-(UIColor*) randomColor{
    CGFloat r = (float) (arc4random() % 256) / 255;
    CGFloat g = (float) (arc4random() % 256) / 255;
    CGFloat b = (float) (arc4random() % 256) / 255;

        return [UIColor colorWithRed:r green:g blue:b alpha:1];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
