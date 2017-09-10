//
//  AppDelegate.m
//  Multithreading
//
//  Created by Петр Первухин on 23.05.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//
/*
Ученик.

1. Создайте класс студент. У него должен быть метод - угадать ответ :)
2. В метод передается случайное целое число например в диапазоне от 0 - 100 (или больше) и сам диапазон, чтобы студент знал где угадывать
3. Студент генерирует случайное число в том же диапазоне пока оно не будет искомым
4. Весь процесс угадывания реализуется в потоке в классе студент
5. Когда студент досчитал то пусть пишет в НСЛог
6. Создайте 5 студентов и дайте им одну и туже задачу и посмотрите кто справился с ней лучше

Студент.

7. Задача та же, но вместе с условием передавайте студенту блок, в котором вы и объявите результаты
8. Блок должен определяться в томже классе, где и определялись студенты
9. Блок должен быть вызван на главном потоке

Мастер.

10. Создать приватный метод класса (да да, приватный метод да еще и с плюсом), который будет возвращать статическую (то есть одну на все объекты класса студент) dispatch_queue_t, которая инициализируется при первом обращении к этому методу.
11. Лучше в этом методе реализовать блок dispatch_once, ищите в инете как и зачем :) А что, программист всегда что-то ищет и хороший программист всегда находит.
12. Все студенты должны выполнять свои процессы в этой queue и она должна быть CONCURRENT, типа все блоки одновременно выполняются

Супермен.

13. Добавьте еще один класс студента, который делает все тоже самое что вы реализовали до этого, только вместо GCD он использует NSOperation и NSOperationQueue. Вообще вынос мозга в самостоятельной работе :)
14. Все сделавшие Мастера и Супермена и с красивым кодом получают отдельный огромный РЕСПЕКТ, так как они это на самом деле заслуживают.
*/

#import "AppDelegate.h"
#import "PMStudent.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

//    [self performSelectorInBackground:@selector(testThread) withObject:nil];
    
/*    for (int i = 0; i<10; i++) {
        NSThread* thread = [[NSThread alloc] initWithTarget:self selector:@selector(testThread) object:nil];
        thread.name = [NSString stringWithFormat:@"thread #%d",i+1];
        [thread start];
    }
 */

    
    PMStudent* student1 = [[PMStudent alloc] init];
    student1.name = @"Student 1";
    
    PMStudent* student2 = [[PMStudent alloc] init];
    student2.name = @"Student 2";
    
    PMStudent* student3 = [[PMStudent alloc] init];
    student3.name = @"Student 3";
    
    PMStudent* student4 = [[PMStudent alloc] init];
    student4.name = @"Student 4";

    PMStudent* student5 = [[PMStudent alloc] init];
    student5.name = @"Student 5";
    
    PMStudent* student6 = [[PMStudent alloc] init];
    student6.name = @"Student 6";
    
    NSArray* students = [NSArray arrayWithObjects:student1,student2,student3,student4,student5,student6,nil];
    
    for (PMStudent* student in students){
        [student guessNumberFrom:10 to:100000 number:44342 andBlock:^{
            NSLog(@" %@ finished in %f, answer:%ld",student.name,student.finishTime,student.currentNumber);
        }];
        
    }
    
    return YES;
}

- (void) testThread {
    double startTime = CACurrentMediaTime();
    
    NSLog(@"%@ started",[[NSThread currentThread] name]);
    
    for (int i = 0; i < 20000; i++) {
    }
    NSLog(@"%@ finished in %f",[[NSThread currentThread] name], CACurrentMediaTime()-startTime);
    
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
