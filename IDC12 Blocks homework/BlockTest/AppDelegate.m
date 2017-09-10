//
//  AppDelegate.m
//  BlockTest
//
//  Created by Петр Первухин on 22.05.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//
/*
 Ученик. Фактически это повторить первую половину.
 
 1. В апп делегате создайте блок с без возвращаемой переменной и без параметров и вызовите его.
 2. Создайте блоки с параметрами и передайте туда строку, которую выведите на экран в последствии.
 3. Если вы не определили тип данных для ваших блоков, то сделайте это сейчас и используйте их
 4. Создайте метод который принимает блок и вызывает его и вызовите этот метод.
 
 Студент.
 5. Создайте класс студент с проперти имя и фамилия.
 6. Создайте в аппделегате 10 разных студентов, пусть у парочки будут одинаковые фамилии.
 7. Поместите всех в массив.
 8. Используя соответствующий метод сортировки массива (с блоком) отсортируйте массив студентов сначала по фамилии, а если они одинаковы то по имени.
 
 Мастер.
 9. Задание из видео. Из урока о делегатах. У пациентов удалите протокол делегат и соответствующее проперти.
 10. Добавьте метод принимающий блок когда им станет плохо.
 11. Блок должен передавать указатель на самого студента ну и на те параметры, которые были в задании по делегатам.
 12. Теперь когда пациентам поплохеет, они должны вызывать блок, а в блоке нужно принимать решения что делать (доктор не нужен делайте все в апп делегате)
 
 Супермен
 13. Познайте истинное предназначение блоков :) Пусть пациентам становится плохо не тогда когда вы их вызываете в цикле(это убрать), а через случайное время 5-15 секунд после создания (используйте специальный метод из урока по селекторам в ините пациента).
 14. не забудьте массив пациентов сделать проперти аппделегата, а то все помрут по выходе из функции так и не дождавшись :)
 */
#import "AppDelegate.h"
#import "PMStudent.h"

typedef void (^OurTestBlock)(void);
typedef NSString* (^OurTestBlock2)(void);

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /*
    //Создание блоков
    __block NSInteger i = 0;
    
    void (^testBlock) (void);
    testBlock=^{
        NSLog(@"Test Block %ld",i);
        ++i;
    };
    
    void (^testBlockWithParams) (NSString*,NSInteger) = ^(NSString* string, NSInteger intValue){
        NSLog(@"Test BlockWithParams parametr1:%@,parametr2:%ld",string,intValue);
    };
    
    NSString* (^testBlockWithReturnValueAndParams)(NSString*,NSInteger) = ^(NSString* string,NSInteger intValue){
        return [NSString stringWithFormat:@"testBlockWithReturnValueAndParams:first parametr1:%@,parametr2:%ld",string,intValue];
    };
    
    //Вызов
    testBlock();
    testBlock();
    testBlock();
    testBlockWithParams(@"XYI",2);
    NSString* result = testBlockWithReturnValueAndParams(@"XYI2",5);
    
    
    NSLog(@"%@",result);
    
    NSString* string1 = [self testMethodWithReturnValueAndParams:@"XYI" parament2:5];
    
    NSLog(@"testMethodWithReturnValueAndParams:%@",string1);
    */
    
    [self methodWithBlocks:^{
        NSLog(@"BLOCK");
    }];
    
    
    PMStudent* student1= [[PMStudent alloc] init];
    PMStudent* student2= [[PMStudent alloc] init];
    PMStudent* student3= [[PMStudent alloc] init];
    PMStudent* student4= [[PMStudent alloc] init];
    PMStudent* student5= [[PMStudent alloc] init];
    PMStudent* student6= [[PMStudent alloc] init];
    PMStudent* student7= [[PMStudent alloc] init];
    PMStudent* student8= [[PMStudent alloc] init];
    PMStudent* student9= [[PMStudent alloc] init];
    PMStudent* student10= [[PMStudent alloc] init];

    student1.firstName = @"Petr";
    student1.lastName = @"Petrov";
    
    student2.firstName = @"Ivan";
    student2.lastName = @"Ivanov";
    
    student3.firstName = @"Max";
    student3.lastName = @"Korzh";
    
    student4.firstName = @"Peter";
    student4.lastName = @"Parker";
    
    student5.firstName = @"Vasya";
    student5.lastName = @"Petrov";
    
    student6.firstName = @"Dimon";
    student6.lastName = @"Medvedev";
    
    student7.firstName = @"VLadimir";
    student7.lastName = @"Putin";
    
    student8.firstName = @"Donald";
    student8.lastName = @"Petrov";
    
    student9.firstName = @"Avril";
    student9.lastName = @"TRUMP";
    
    student10.firstName = @"Vladimir";
    student10.lastName = @"Medvedev";
    
    NSArray* arrayStudent = [NSArray arrayWithObjects:student1, student2, student3, student4, student5, student6, student7, student8, student9, student10, nil];
    
    [self printStudent:arrayStudent withComment:@"UNSORTED ARRAY"];
    
    arrayStudent = [ arrayStudent sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if ([obj1 lastName] == [obj2 lastName]){
            return [[obj1 firstName] compare:[obj2 firstName]];
        }else{
            return [[obj1 lastName] compare:[obj2 lastName]];
        }
    }];
    
    NSLog(@"  ");
    
    [self printStudent:arrayStudent withComment:@"SORTED"];
    
    return YES;
}

- (void) printStudent : (NSArray*) students withComment : (NSString*) string{
    
    NSLog(@" %@ ",string);
    
    for (id element in students){
        if ([element isKindOfClass:[PMStudent class]]){
            PMStudent* student = element;
            NSLog(@"%@ %@",student.firstName,student.lastName);
        }
        
    }
    
}

- (void) methodWithBlocks :(void (^) (void)) testBlocks{
    NSLog(@"methodWithBlocks:");
    testBlocks();
}

- (void) methodWithBlocks2 :(OurTestBlock) testBlocks{
    NSLog(@"methodWithBlocks:");
    testBlocks();
}

- (NSString*) testMethodWithReturnValueAndParams:(NSString*) string parament2:(NSInteger) intValue{
    return [NSString stringWithFormat:@"first parametr1:%@,parametr2:%ld",string,intValue];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
