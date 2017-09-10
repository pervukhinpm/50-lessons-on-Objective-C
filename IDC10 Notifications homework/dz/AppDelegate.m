//
//  AppDelegate.m
//  dz
//
//  Created by Петр Первухин on 21.05.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//
/*
 Итак друзья, эта тема весьма интересная, применяется она довольно часто и самое главное понять из урока сам принцип, для чего оно надо и неужели нельзя обойтись без него :)
 
 Задание:
 
 Ученик.
 
 1. Используя мой код создать свой проект со своими классами и понять как оно работает
 2. Добавить классы "пенсионер" и "бизнесмен"
 3. Доктор следит за изменением зарплаты, бизнесмен должен следить за изменением налогов, а пенсионер за изменением пенсий.
 4. Все классы: Доктор, Пенсионер и Бизнесмен долджны следить также и за средней ценой на товар.
 
 Умничка.
 
 5. Каждый из классов следит за инфляцией (процентный рост средней цены на товар) и оценивает свой потенциальный доход по отношению к инфляции, например размер пенсии к возможности купить продукты у пенсионера, либо новая прибыль за вычетом налогов у бизнесмена также по отношению к ценам на товар.
 
 6. Не секрет что изменение этих характеристик оказывает разное влияние на разные слои населения, поэтому пусть в зависимости от уровня покупательской способности каждый класс выдает свои перлы.
 
 Мастер.
 
 7. Подпишите классы на нотификацию ухода приложения в бекграунд, чтобы когда нажимается кнопка HOME и приложение сворачивается, каждый объект заявлял о том что он идет спать
 
 8. Тоже самое сделать для случая, когда приложение возвращается из свернутого состояния
 
 Супермен
 
 9. Создайте свой класс аналог апп делегату, только он не делегат приложения, но слушатель тех же самых нотификаций, какие методы есть у делегата. Грубо говоря у вашего класса должны быть теже методы, что и у апп делегата, но вызываться они должны путем нотификаций
 
 10. Добавьте НСЛоги в каждый метод апп делегата и своего класса
 
 11. Сворачивая и разварачивая приложение добивайтесь вызовов определенный методов делегата и тех же нотификаций и посмотрите что вызывается раньше - метод делегата или нотификация :)
 
 */
#import "AppDelegate.h"
#import "PMGoverment.h"
#import "PMDoctor.h"
#import "PMBusinesman.h"
#import "PMPensioner.h"
#import "AppFakeDelegate.h"

@interface AppDelegate ()

@property (strong,nonatomic) PMGoverment* goverment;
@property (strong,nonatomic) PMBusinesman* businesman;
@property (strong,nonatomic) PMPensioner* pensioner;
@property (strong,nonatomic) PMDoctor* doctor;
@property (strong,nonatomic) AppFakeDelegate* fake;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.goverment= [[PMGoverment alloc] init];
    self.doctor = [[PMDoctor alloc] init];
    self.pensioner=[[PMPensioner alloc] init];
    self.businesman = [[PMBusinesman alloc] init];
    

    self.pensioner.pension=self.goverment.pension;
    self.pensioner.averagePrice=self.goverment.averagePrice;
    
    self.businesman.taxLevel=self.goverment.taxLevel;
    self.businesman.averagePrice=self.goverment.averagePrice;
    
   self.doctor.averagePrice=self.goverment.averagePrice;
    self.doctor.salary = self.goverment.salary;
    
    self.goverment.pension = 12;
    self.goverment.salary = 43;
    self.goverment.taxLevel = 15;
    self.goverment.averagePrice = 23;
 
    /*  [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(govermentNotifications: )
                                                 name:PMGovermentTaxLevelDidChangeNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(govermentNotifications: )
                                                 name:PMGovermentPensionDidChangeNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(govermentNotifications: )
                                                 name:PMGovermentSalaryDidChangeNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(govermentNotifications: )
                                                 name:PMGovermentAveragePriceDidChangeNotification
                                               object:nil];
    
   */
    
    NSLog(@"**** TEST ****");
    
    self.fake = [[AppFakeDelegate alloc] init];
    
    return YES;
}

- (void) govermentNotifications:(NSNotification*) notification {
    NSLog(@"GovermentNotification userInfo =%@", notification.userInfo);
    
}


- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    NSLog(@"AppDelegate:applicationWillResignActive will run");
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"AppDelegate:applicationDidEnterBackground will run");

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    NSLog(@"AppDelegate:applicationWillEnterForeground will run");

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"AppDelegate:applicationDidBecomeActive will run");

}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"AppDelegate:applicationWillTerminate will run");

}


@end
