//
//  AppDelegate.m
//  delegati peredelanoe
//
//  Created by Петр Первухин on 20.05.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

/*Ученик:

1. Создать пару пациентов и доктора по тому же принципу что и в видео. (Доктор делегат у пациентов)
2. У пациента пусть будет температура и другие симптомы, по которым доктор может принимать решение.
3. У пациента сделайте метод типа стало хуже и пусть когда станет хуже, то он идет к доктору
4. Всех пациентов объедините в массив и в цикле вызовите метод "стало хуже".
5. Доктор должен лечить каждого согласно симптомам.

Студент:

6. Создайте другой класс доктора, не наследника от первого доктора, например друг :)
7. этот друг должен лечить своих пациентов своими собственными методами и короче плохой он доктор
8. пусть кто-то ходит к врачу, а кто-то к нему
9. создайте пару разных объектов класса друг и пусть они лечат своих пациентов (чтобы понять что делегат это не класс, а объект)

Мастер:

10. Создайте список частей тела в делегате пациента (голова, живот, нога и тд) и когда пациент приходит к врачу, пусть говорит что болит.
11. Доктор должен принимать во внимание что болит
12. Создайте у доктора метод "рапорт". Пусть в конце дня, когда все уже нажаловались достаточно, доктор составит рапорт (выдаст имена) тех у кого болит голова, потом тех у кого болел живот и тд

Супермен

13. Создайте в классе пациента проперти - оценка доктору.
14. Когда доктор вам назначает лечение некоторые пациенты должны стать недовольны.
15. В конце дня после того как все лечение будет сделано и доктор напишет рапорт, надо пройтись по пациентам и всем недовольным поменять доктора.
16. Начать новый день и убедиться что Недовольные пациенты таки поменяли доктора.

Если что непонятно - задавайте вопросы!

*/


#import "AppDelegate.h"
#import "PMPatient.h"
#import "PMDoctor.h"
#import "PMDoctorIdiot.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    PMPatient* patient1=[[PMPatient alloc] init];
    patient1.name=@"vasya";
    patient1.pain=head;
    
    
    PMPatient* patient2=[[PMPatient alloc] init];
    patient2.name=@"sasha";
    patient2.pain=stomache;
    
    PMPatient* patient3=[[PMPatient alloc] init];
    patient3.name=@"petr";
    patient3.pain=head;
    
    PMPatient* patient4=[[PMPatient alloc] init];
    patient4.name=@"denis";
    patient4.pain=leg;
    
    PMDoctor* doctor1=[[PMDoctor alloc] init];
    doctor1.name=@"Teraphet";
    doctor1.raport= [[NSMutableDictionary alloc]init];
    
    PMDoctor* doctor2=[[PMDoctor alloc] init];
    doctor2.name=@"Lor";
    
    PMDoctorIdiot* DoctorIdiot = [[PMDoctorIdiot alloc] init];
    DoctorIdiot.name=@"DoctorIdiot";
    
    NSArray* array=[NSArray arrayWithObjects:patient1,patient2,patient3,patient4,nil];
    
    NSArray* arrayDoctor = [NSArray arrayWithObjects: DoctorIdiot, doctor1, doctor2, nil];
    
    for (id man in array){
        [man setDelegate:doctor1];
        [man feelBad];
    }
    
    NSLog(@"%@ ", doctor1.raport);
    
    for (NSString* patient in [doctor1.raport allKeys]){
        id obj=[doctor1.raport objectForKey:patient];
        
        switch ([[doctor1.raport valueForKey:patient] intValue]) {
            
            case head:
                NSLog(@"patient %@, have headache number %@",patient,obj);
                break;
                
            case leg:
                NSLog(@"patient %@, have leg hurts",patient);
                break;
                
            case stomache:
                NSLog(@"patient %@, have stomache",patient);
                break;
                
            default:NSLog(@"нет совпадений");
                break;
        }
    }
    
    NSMutableArray* patientNotHappy= [[NSMutableArray alloc] init];
    NSLog(@" ");
    NSLog(@"**** DAY 1 *****");
    NSLog(@" ");
    
    for (PMPatient* man in array){
        int i = arc4random()%3;
        
        switch (i) {
            case 0:
                NSLog(@"*** patient %@ go to doctor %@ ***",man.name,DoctorIdiot.name);
                break;
            case 1:
                NSLog(@"*** patient %@ go to doctor %@ ***",man.name,doctor1.name);
                break;
            case 2:
                NSLog(@"*** patient %@ go to doctor %@ ***",man.name,doctor2.name);
                break;
            default:
                break;
        }
        
        [man setDelegate:arrayDoctor[i]];
        [man feelBad];
        man.markForDoc = arc4random()%2;
        man.whichDoc = i;
        if (man.markForDoc==NO){
            [patientNotHappy addObject:man];
        }
    }
    
        
    NSLog(@"Unhappy patient:");
    for (PMPatient* man in patientNotHappy) {
        NSLog(@"patient %@ ",man.name);
    }
    NSLog(@" ");
    NSLog(@"**** NEW DAY ****");
    NSLog(@" ");
    
    for(PMPatient* man in patientNotHappy){
        if (man.whichDoc==0){
            if (arc4random()%2){
                NSLog(@"patient %@ changed doc on %@",man.name,doctor1.name);
            }else{
                NSLog(@"patient %@ changed doc on %@",man.name,doctor2.name);
            }
        }
        if (man.whichDoc==1){
            if (arc4random()%2){
                NSLog(@"patient %@ changed doc on %@",man.name,DoctorIdiot.name);
            }else{
                NSLog(@"patient %@ changed doc on %@",man.name,doctor2.name);
            }
        }
        if (man.whichDoc==2){
            if (arc4random()%2){
                NSLog(@"patient %@ changed doc on %@",man.name,DoctorIdiot.name);
            }else{
                NSLog(@"patient %@ changed doc on %@",man.name,doctor1.name);
            }
        }
    }
   
    
    return YES;
}
    
 
- (void)applicationWillResignActive:(UIApplication* )application    {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
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
