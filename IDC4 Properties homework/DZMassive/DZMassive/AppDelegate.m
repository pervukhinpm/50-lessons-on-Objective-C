//
//  AppDelegate.m
//  DZMassive
//
//  Created by Петр Первухин on 27.04.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
/*
 
 Уровень ученик:
 (просто повторение того что увидел)
 
 1. Создать класс "человек", который будет содержать в себе базовые качества - "имя", "рост", "вес", "пол", а также будет иметь метод "передвижение".
 2. Создать дочерние классы (наследники) "велосипедист", "бегун", "пловец" и переопределить метод "передвижение" в каждом из этих классов.
 3. При старте программы создать по одному объекту каждого класса и объединить их в массив.
 4. В цикле пройти по всем элементам массива и вывести на экран все характеристики каждого объекта (имя, рост и тд) и у каждого вызвать метод "передвижение".
 
 Если получилось пройти уровень ученик, то можно попробовать уровень студент:
 (небольшая импровизация + дополнительная мозговая деятельность)
 
 5. Создать еще одного наследника от класса человек, добавить в него пару новых свойств, добавить в массив и в цикле вывода вывести его свойства как дополнение к свойствам человека
 6. Метод "передвижение" реализовать таким образом, чтобы перед тем как выполнить свое собственное передвижение, он выполнял передвижение реализованное в классе человек
 7. Массив выводить в обратном порядке.
 
 Уровень Мастер:
 (простор для фантазии + больше мозговой деятельности + больше практики)
 
 8. Создать класс "животное" (не наследник класса человек!) со своими собственными базовыми свойствами (отличными от человеческих) и методом "передвижение".
 9. Унаследоваться от него и создать пару других классов с переопределенным передвижением.
 10. Объединить всех людей и животных в один массив.
 11. В цикле выводить тип объекта (человек или животное) перед тем как выводить его свойства и вызывать метод
 
 Уровень Звезда:
 (разобраться с тем чего Леша не объяснял! + реальная задача!)
 
 12. Поместить всех людей в один массив, а животных в другой массив (количество людей и животных должно быть разное)
 13. В одном цикле выводить сначала человека а потом животное, доставая данные поочередно из двух разных массивов, если в одном из массивов объектов больше, то в конце должны выводиться только объекты этого массива (так как других уже нет)
 
 Уровень Супермен!
 (кодинг за гранью возможного! + вероятность успеха практически 0! + реальный вызов!)
 
 14. Соединить животных и людей в одном массиве.
 15. Используя нужный метод класса NSArray отсортировать массив (как результат будет другой массив). 16. Сортировать так: сначала люди, а потом животные, люди отсортированы по имени, а животные по кличкам
 17. Реально требует разобраться с сортировкой самому, тяжело, но достойно уважения
 
 Код можете копировать сюда, если будет не красиво, то найдем лучший способ, может как документы прикреплять?
 
 Так же приветствуются обсуждение, взаимная помощь и вопросы
*/


#import "AppDelegate.h"
#import "PMHuman.h"
#import "PMSwimer.h"
#import "PMRunner.h"
#import "PMSinger.h"
#import "PMAnimals.h"
#import "PMMouses.h"
#import "PMDog.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    PMHuman * human=[[PMHuman alloc] init];
    PMSwimer * swimer=[[PMSwimer alloc] init];
    PMRunner * runner=[[PMRunner alloc] init];
    PMSinger * singer=[[PMSinger alloc] init];
    PMMouses* mouse=[[PMMouses alloc] init];
    PMDog* dog=[[PMDog alloc] init];
    
    human.name=@"Vasya";
    human.weight=89;
    human.height=180;
    
    swimer.name=@"John";
    swimer.weight=70;
    swimer.height=60;
    
    runner.name=@"Kristina";
    runner.weight=90;
    runner.height=150;
    
    singer.name=@"Mathew Bellame";
    singer.weight=65;
    singer.height=180;
    singer.range=@"High";
    singer.level=5;
    
    mouse.type=@"Mouse";
    mouse.countrty=@"Russia";
    dog.type=@"Korzh";
    dog.countrty=@"Scotland";
    
    
    NSArray * arrayHumanAndAnimals =[NSArray arrayWithObjects:human, swimer, runner,singer,mouse,dog,nil];
    /*
    for (int i=(int)([array count])-1; i>=0; i--) {
        PMHuman* obj=[array objectAtIndex:i];
        
        if ([obj isKindOfClass:[PMSinger class]]) {
            PMSinger* man=(PMSinger*) obj;
            NSLog(@"name=%@,weight=%ld,height=%ld", [obj name],[obj weight],[obj height]);
            NSLog(@"range=%@ is %ld oktavs",[man range],[man level]);
            [obj move];
            
        }else{
        
        NSLog(@"name=%@,weight=%ld,height=%ld", [obj name],[obj weight],[obj height]);
        
        
        [obj move];
        
        NSLog(@"\n");
        }
    }
     
     */
    
    
    for(NSObject* object in arrayHumanAndAnimals){
        
        if ([object isKindOfClass:[PMHuman class]]){
            PMHuman* man=(PMHuman*) object;
            NSLog(@"name=%@,weight=%ld,height=%ld", [man name],[man weight],[man height]);
        [man move];
        }
        
        if ([object isKindOfClass:[PMSinger class]]){
            PMSinger* man=(PMSinger*) object;
            NSLog(@"range=%@ is %ld oktavs",[man range],[man level]);
        }
        if ([object isKindOfClass:[PMAnimals class]]){
            PMAnimals* animal=(PMAnimals*) object;
            NSLog(@"type=%@,it is living  in country=%@",[animal type],[animal countrty]);
            [animal move];
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
