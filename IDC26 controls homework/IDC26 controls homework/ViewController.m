//
//  ViewController.m
//  IDC26 controls homework
//
//  Created by Петр Первухин on 26.06.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//
/*
 Ученик.
 
 1. Расположите тестируюмую вьюху на верхней половине экрана
 2. На нижней половине создайте 3 свича: Rotation, Scale, Translation. По умолчанию все 3 выключены
 3. Также создайте сладер скорость, со значениями от 0.5 до 2, стартовое значение 1
 4. Создайте соответствующие проперти для свитчей и слайдера, а также методы для события valueChanged
 
 Студент.
 
 5. Добавьте сегментед контрол с тремя разными сегментами
 6. Они должны соответствовать трем разным картинкам, которые вы должны добавить
 7. Когда переключаю сегменты, то картинка должна меняться на соответствующую
 
 Мастер.
 
 8. Как только мы включаем один из свичей, наша вьюха должна начать соответствующую анимацию
 (либо поворот, либо скеил, либо перенос). Используйте свойство transform из урока об анимациях
 9. Так же следует помнить, что если вы переключили свич, но какойто другой включен одновременно с ним, то вы должны делать уже двойную анимацию. Например и увеличение и поворот одновременно (из урока про анимации)
 10. Анимации должны быть бесконечно повторяющимися, единственное что их может остановить, так это когда все три свича выключены
 
 Супермен.
 
 11. Добавляем использование слайдера. Слайдер регулирует скорость. То есть когда значение на 0.5, то скорость анимаций должна быть в два раза медленнее, а если на 2, то в два раза быстрее обычной.
 12. Попробуйте сделать так, чтобы когда двигался слайдер, то анимация обновлялась без прерывания, а скорость изменялась в соответствующую сторону.
 */
#import "ViewController.h"

typedef enum  {
    BenderImage,
    HomerImage,
    BallImage
}PMImageType;

typedef enum  {
    ChoosenParameterNone,
    ChoosenParameterRotation,
    ChoosenParameterScale,
    ChoosenParameterTranslation
}PMChoosenParameter;


@interface ViewController ()

@property (assign,nonatomic) CGFloat rotationSpeed;
@property (assign,nonatomic) CGFloat scaleSpeed;
@property (assign,nonatomic) CGFloat translationSpeed;
@property (assign,nonatomic) CGFloat animationTime;
@property (assign,nonatomic) PMChoosenParameter choosenParameter;

@property (strong,nonatomic) NSMutableArray* rotationKeys;
@property (strong,nonatomic) NSMutableArray* translationKeys;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.animationTime = 2.f;
    self.choosenParameter = ChoosenParameterNone;
    
    self.rotationSpeed = self.speedSlider.value;
    self.scaleSpeed = self.speedSlider.value;
    self.translationSpeed = self.speedSlider.value;
    
    self.typeImageControl.selectedSegmentIndex = 0;
    [self setImageToView];
    
}

#pragma mark - HelpFunc

-(void)setImageToView{
    switch (self.typeImageControl.selectedSegmentIndex) {
        case BenderImage:
            self.imageView.image = [UIImage imageNamed:@"bender.png"];
            [self.borderAnimationView addSubview:self.imageView];
            self.imageView.transform = CGAffineTransformMakeScale(0.5, 0.5);

            break;
        case HomerImage:
            self.imageView.image = [UIImage imageNamed:@"homer.png"];
            [self.borderAnimationView addSubview:self.imageView];
            self.imageView.transform = CGAffineTransformMakeScale(0.9, 0.9);

            break;
        case BallImage:
            self.imageView.image = [UIImage imageNamed:@"ball.png"];
            [self.borderAnimationView addSubview:self.imageView];
            self.imageView.transform = CGAffineTransformMakeScale(0.2, 0.2);
            break;
        default:
            break;
    }
    
}

-(void) enableSliderByParameter: (PMChoosenParameter) choosenParameter{
    switch (choosenParameter) {
            case ChoosenParameterNone:
            self.speedSlider.enabled = NO;
            break;
        case ChoosenParameterRotation:
            self.speedSlider.enabled = YES;
            self.speedSlider.value = self.rotationSpeed;
            break;
        case ChoosenParameterScale:
            self.speedSlider.enabled = YES;
            self.speedSlider.value = self.scaleSpeed;
            break;
        case ChoosenParameterTranslation:
            self.speedSlider.enabled = YES;
            self.speedSlider.value = self.translationSpeed;
            break;
        default:
            break;
    }
}



-(PMChoosenParameter)findEnabledParameter{
    if (self.rotationSwitch.isOn){
        return ChoosenParameterRotation;
    }else if (self.translationSwitch.isOn){
        return ChoosenParameterTranslation;
    } else if(self.scaleSwitch.isOn) {
        return ChoosenParameterScale;
    } else {
        return ChoosenParameterNone;
    }
}

-(void)actionSwitchType:(PMChoosenParameter) choosenParameter :(UISwitch*) sender{
    if (sender.isOn){
        self.choosenParameter = choosenParameter;
    }else{
        self.choosenParameter =[self findEnabledParameter];
    }
    [self enableSliderByParameter:self.choosenParameter];
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if([[UIApplication sharedApplication] isIgnoringInteractionEvents]){
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
    });
    
}

-(void)setValue: (CGFloat) value ForChoosenParameter:(PMChoosenParameter) parameter{
    switch (parameter) {
        case ChoosenParameterRotation:
            self.rotationSpeed = value;
            break;
        case ChoosenParameterTranslation:
            self.translationSpeed = value;
            break;
        case ChoosenParameterScale:
            self.scaleSpeed = value;
            [self setScale];
            break;
            
        default:
            break;
    }
    
}

# pragma mark - Action

- (IBAction)changeImageControl:(UISegmentedControl *)sender {
    [self setImageToView];
}

- (IBAction)actionRotation:(UISwitch *)sender {
    [self actionSwitchType:ChoosenParameterRotation :sender];
    [self animateRotation];
}

- (IBAction)actionScale:(UISwitch *)sender {
    [self actionSwitchType:ChoosenParameterScale :sender];
    [self setScale];
}

- (IBAction)actionTranslation:(UISwitch *)sender {
    [self actionSwitchType:ChoosenParameterTranslation :sender];
    [self animateTranslation];
}

- (IBAction)actionSpeed:(UISlider *)sender {
    [self setValue:sender.value ForChoosenParameter:self.choosenParameter];
}

#pragma mark - Animation

-(void) animateRotation{
    if(self.rotationSwitch.isOn){
        [UIView animateWithDuration:2/self.rotationSpeed
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState |UIViewAnimationOptionCurveLinear
                         animations:^{
                                self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, M_PI_2/4);
        } completion:^(BOOL finished) {
            [self animateRotation];
        }];
    }
}

-(void)setScale {
    
        [UIView animateWithDuration:0.3
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             CGAffineTransform scale = CGAffineTransformMakeScale(self.scaleSpeed, self.scaleSpeed);
                             self.imageView.transform = scale;
            } completion:^(BOOL finished) {
        }];
}

-(void)animateTranslation {
     if(self.translationSwitch.isOn){
         CGFloat destinationX ;
         CGFloat destinationY = [self randomCGFloatFrom: CGRectGetWidth(self.imageView.frame)/2 to:CGRectGetMaxY(self.borderAnimationView.bounds)-CGRectGetWidth(self.imageView.frame)/2];
         if( CGRectGetMidX(self.imageView.frame)>(CGRectGetMidX(self.borderAnimationView.bounds))){
             destinationX = CGRectGetMinX(self.borderAnimationView.bounds)+CGRectGetWidth(self.imageView.frame)/2;
         }else{
             destinationX = CGRectGetMaxX(self.borderAnimationView.bounds)-CGRectGetWidth(self.imageView.frame)/2;
         }
         CGPoint destination = CGPointMake(destinationX, destinationY);
         [UIView animateWithDuration:2/self.translationSpeed
                               delay:0
                             options:UIViewAnimationOptionCurveLinear
                          animations:^{
                              self.imageView.center = destination;
         } completion:^(BOOL finished) {
             [self animateTranslation];
         }];
     }
}


- (CGFloat) randomCGFloatFrom :(CGFloat) startNumber to: (CGFloat) endNumber{
    return startNumber +(CGFloat)(arc4random_uniform((endNumber-startNumber)+10001)/10000);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
