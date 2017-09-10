//
//  ViewController.m
//  IDC 19 UIView Geometry Homework
//
//  Created by Петр Первухин on 09.06.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//
/*
 Ученик
 
 1. В цикле создавайте квадратные UIView с черным фоном и расположите их в виде шахматной доски
 2. доска должна иметь столько клеток, как и настоящая шахматная
 
 Студент
 
 3. Доска должна быть вписана в максимально возможный квадрат, т.е. либо бока, либо верх или низ должны касаться границ экрана
 4. Применяя соответствующие маски сделайте так, чтобы когда устройство меняет ориентацию, то все клетки растягивались соответственно и ничего не вылетало за пределы экрана.
 
 Мастер
 5. При повороте устройства все черные клетки должны менять цвет :)
 6.Сделайте так, чтобы доска при поворотах всегда строго находилась по центру
 
 Супермен
 8. Поставьте белые и красные шашки (квадратные вьюхи) так как они стоят на доске. Они должны быть сабвьюхами главной вьюхи (у них и у клеток один супервью)
 9. После каждого переворота шашки должны быть перетасованы используя соответствующие методы иерархии UIView
 
 viewWillTransitionToSize
 */



#import "ViewController.h"


@interface ViewController ()

@property (assign,nonatomic) CGFloat fullWidth;
@property (assign,nonatomic) CGFloat fullHeight;
@property (strong,nonatomic) NSMutableArray* cellsArray;
@property (strong,nonatomic) NSMutableArray* chekersArray;
@property (strong,nonatomic) NSMutableArray* placesForChekers;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fullWidth = CGRectGetWidth(self.view.bounds);
    self.fullHeight = CGRectGetHeight(self.view.bounds);
    
    NSLog(@"\nfullwidth = %f\nfullHeight = %f",self.fullWidth, self.fullHeight);
   
    NSInteger cells = 8;
    
    CGRect chessSize = self.fullHeight > self.fullWidth ?
    CGRectMake(0, (self.fullHeight-self.fullWidth)/2, self.fullWidth,self.fullWidth) : CGRectMake((self.fullWidth-self.fullHeight)/2, 0, self.fullHeight,self.fullHeight);
   
    NSLog(@"\n%@", NSStringFromCGRect(chessSize));
    
    UIView* view = [[UIView alloc] initWithFrame:chessSize];
    view.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:view];
   
    view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleBottomMargin;
    
    self.cellsArray = [[NSMutableArray alloc] init];
    self.chekersArray = [[NSMutableArray alloc] init];
    self.placesForChekers = [[NSMutableArray alloc] init];

    [self drawCellsAtView:view startSize: chessSize CellsAtRow:cells];

    
    
    
}

#pragma mark - draw

- (void) drawCellsAtView : (UIView*) view startSize:(CGRect) chess CellsAtRow : (NSInteger) cellsNumber{
    
    CGFloat coeficient = 0.1;
    
    CGFloat cellWidth = chess.size.width/(cellsNumber+coeficient*2);
    CGFloat cellHeight = chess.size.width/(cellsNumber+coeficient*2);
    CGFloat borderX = coeficient*cellWidth;
    CGFloat borderY = coeficient*cellHeight;
    
    for (int y = 0; y < cellsNumber; y++) {
        
        for (int x = 0; x < cellsNumber; x++) {
            //Set Cells
            UIView* cell = [[UIView alloc] initWithFrame:CGRectMake(borderX, borderY, cellWidth, cellHeight)];
            
            if (x % 2 == 0) {
                cell.backgroundColor = y % 2 ==0 ?[UIColor whiteColor]:[UIColor blackColor];
            }else {
                cell.backgroundColor = y % 2 ==0 ?[UIColor blackColor]:[UIColor whiteColor];
            }
            [view addSubview:cell];
            [self.cellsArray addObject:cell];
            borderX+=cellWidth;
            
            //Set Chekers
            
            UIView* cheker = [[ UIView alloc] initWithFrame:
                              CGRectMake(CGRectGetMinX(cell.frame)+CGRectGetWidth(cell.frame)/6,
                                         CGRectGetMinY(cell.frame)+CGRectGetHeight(cell.frame)/6,
                                         CGRectGetWidth(cell.frame)*2/3,
                                         CGRectGetHeight(cell.frame)*2/3) ];
            
            cheker.layer.cornerRadius =CGRectGetWidth(cell.frame)/3;
            
            if ((x+y) % 2 != 0 && y < cellsNumber/2 -1){
                
                cheker.backgroundColor = [UIColor greenColor];
                [self.chekersArray addObject:cheker];
                [view addSubview:cheker];
                [self.placesForChekers addObject:[NSValue valueWithCGPoint:cheker.center]];
                
            }else if((x+y) % 2 != 0 && y > cellsNumber/2 ){
                
                cheker.backgroundColor = [UIColor redColor];
                [self.chekersArray addObject:cheker];
                [view addSubview:cheker];
                [self.placesForChekers addObject:[NSValue valueWithCGPoint:cheker.center]];
                
            }
            
            
            
        }
        
        borderX = coeficient*cellHeight;
        borderY+=cellHeight;
        
    }
    for (UIView* obj in self.chekersArray){
        [view bringSubviewToFront:obj];
    }
    
    
}


-(UIInterfaceOrientationMask) supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

- (void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [UIView animateWithDuration:2 animations:^{
        
        [self setRandomCellColor];
        [self setRandomChekersColor];
        [self shakeChekers];
        
                      }];
    
    
}

-(void) setRandomCellColor {
    
    UIColor* randomColor = [self getRandomDarkColor];
    
    for (UIView* cell in self.cellsArray){
        if (![cell.backgroundColor isEqual:[UIColor whiteColor]]){
            cell.backgroundColor = randomColor;
            
        }
    }
}

-(void) setRandomChekersColor{
     UIColor* randomdarkColor = [self getRandomDarkColor];
     UIColor* randomBrightColor = [self getRandomBrightColor];
   
    for (UIView* cheker in self.chekersArray){
        if ([self.chekersArray indexOfObject:cheker] < self.chekersArray.count/2) {
            cheker.backgroundColor = randomdarkColor;
        }else {
            cheker.backgroundColor = randomBrightColor;
        }
    }
}

- (void) shakeChekers{
    
    NSMutableArray* UnusedPlaces = [NSMutableArray arrayWithArray:self.placesForChekers];

    for (UIView* cheker in self.chekersArray){
        
        NSUInteger randomIndex = arc4random() % UnusedPlaces.count;
        CGPoint randomPlace = [[UnusedPlaces objectAtIndex:randomIndex] CGPointValue];
        [UnusedPlaces removeObjectAtIndex:randomIndex];
        cheker.center = randomPlace;
    
    }
    
}


-(UIColor*) getRandomDarkColor {

    CGFloat r =arc4random()% 255;
    CGFloat g =arc4random()% 255;
    CGFloat b =arc4random()% 255;
    
    return [UIColor colorWithRed:(r/255) green:(g/255) blue:(b/255) alpha:1];

}

-(UIColor*) getRandomBrightColor {
    
    CGFloat r =0.5 + arc4random()% 51;
    CGFloat g =0.5 + arc4random()% 51;
    CGFloat b =0.5 + arc4random()% 51;
    
    return [UIColor colorWithRed:(r/100) green:(g/100) blue:(b/100) alpha:1];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];


}


@end
