//
//  AppDelegate.m
//  protocolsDZ
//
//  Created by Петр Первухин on 29.04.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//
 /*
  
  1. Реализуйте протоколы Jumpers, Swimmers, Runners. Каждый протокол должен иметь пару свойств, например скорость или максимальная высота прыжка и пару методов, например прыгать или плыть, нырять и тд. Включите фантазию!!!
  
  2. Часть методов делайте обязательными (например у пловцов обязательный метод это плыть а у бегунов - бежать, логично?), а другую часть не обязательными.
  
  3. Используйте классы из задания про массивы, там где у вас люди и животные. Например у кенгуру и у особых спортсменов реализуйте протокол Jumpers, тоже самое с другими протоколами. Пусть каждый протокол будет реализован как некоторыми классами животных, так и некоторыми классами людей.
  
  4. Положите всех в одни массив. Тех кто прыгает заставьте прыгать и рассказывать про свои свойства. Причем у некоторых объектов пусть будут одни необязательные свойства или методы, а у других другие. Тот кто бегает пусть бегает, а тот кто плавает, пусть плавает. Тот кто ничего не делает должен быть выведен на экран как лодырь :)
  
  5. Сделайте так чтобы один какой-то класс мог и бегать и прыгать и плавать и посмотрите как он себя поведет в цикле.
  
  */
#import "AppDelegate.h"
#import "PMFish.h"
#import "PMCrosfiter.h"
#import "PMKenguru.h"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    
    PMFish* fish=[[PMFish alloc] init];
    PMKenguru* kenguru=[[PMKenguru alloc] init];
    PMCrosfiter* crossfitter=[[PMCrosfiter alloc] init];
    
    fish.name=@"Щука";
    kenguru.name=@"Kenguru Jack";
    crossfitter.name=@"Radu";
    
    NSArray* animalAndHuman=[NSArray arrayWithObjects:fish,crossfitter,kenguru,nil ];
    
    for (id <PMSwimers,PMJumpers> object in animalAndHuman){
        
        if ([object isKindOfClass:[PMFish class]]){
            [object swim];
    }
        if ([object conformsToProtocol:@protocol(PMSwimers)]) {
            [object swim];
            NSLog(@"Lets takes this sheet baby");
        }
        
        if ([object isKindOfClass:[PMKenguru class]]) {
            [object jump];
        }
        if ([ object respondsToSelector:@selector(run)] ){
         
            [object run];
        }
    }

    
    
    return YES;
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
