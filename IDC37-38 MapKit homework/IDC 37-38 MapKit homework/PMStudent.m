//
//  PMStudent.m
//  IDC 37-38 MapKit homework
//
//  Created by Петр Первухин on 31.07.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "PMStudent.h"

@implementation PMStudent

-(instancetype)init{
    
    self = [super init];
    if (self) {
        
        self.firstName = firstNames[arc4random() % 56];
        
        self.lastName = lastNames[arc4random() % 56];
        
        double plusOrMinus = arc4random() % 2 == 0 ? -1 : 1;
        
        self.longitude = ((double)(arc4random() % 5000) / 100000.f * plusOrMinus) + mainLongitude;
        
        plusOrMinus = arc4random() % 2 == 0 ? -1 : 1;
        
        self.latitude = ((double)(arc4random() % 5000) / 100000.f * plusOrMinus) + mainLatitude;
     
        _coordinate.longitude = _longitude;
        
        _coordinate.latitude = _latitude;
        
        NSTimeInterval intervalBetween17and25Ages = arc4random() % 252288000 + 536112000;
        
        NSDate *dateOfBirthday = [[NSDate alloc] initWithTimeIntervalSinceNow:-intervalBetween17and25Ages];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd MMMM, yyyy"];
        
        _date = [dateFormatter stringFromDate:dateOfBirthday];
        
        _subtitle = _date;
        
        _title = [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];

        _gender = arc4random() % 2 == 0 ? PMWoman : PMMan;
        
    }
    return self;
}

static double mainLatitude = 56.011644;
static double mainLongitude  = 37.473795;


static NSString* firstNames[] = {
    @"Tran", @"Lenore", @"Bud", @"Fredda", @"Katrice",
    @"Clyde", @"Hildegard", @"Vernell", @"Nellie", @"Rupert",
    @"Billie", @"Tamica", @"Crystle", @"Kandi", @"Caridad",
    @"Vanetta", @"Taylor", @"Pinkie", @"Ben", @"Rosanna",
    @"Eufemia", @"Britteny", @"Ramon", @"Jacque", @"Telma",
    @"Colton", @"Monte", @"Pam", @"Tracy", @"Tresa",
    @"Willard", @"Mireille", @"Roma", @"Elise", @"Trang",
    @"Ty", @"Pierre", @"Floyd", @"Savanna", @"Arvilla",
    @"Whitney", @"Denver", @"Norbert", @"Meghan", @"Tandra",
    @"Jenise", @"Brent", @"Elenor", @"Sha", @"Jessie", @"Akram",
    @"Ruslan", @"Dasha", @"Sergey", @"Sveta", @"Zahar"
};

static NSString* lastNames[] = {
    
    @"Farrah", @"Laviolette", @"Heal", @"Sechrest", @"Roots",
    @"Homan", @"Starns", @"Oldham", @"Yocum", @"Mancia",
    @"Prill", @"Lush", @"Piedra", @"Castenada", @"Warnock",
    @"Vanderlinden", @"Simms", @"Gilroy", @"Brann", @"Bodden",
    @"Lenz", @"Gildersleeve", @"Wimbish", @"Bello", @"Beachy",
    @"Jurado", @"William", @"Beaupre", @"Dyal", @"Doiron",
    @"Plourde", @"Bator", @"Krause", @"Odriscoll", @"Corby",
    @"Waltman", @"Michaud", @"Kobayashi", @"Sherrick", @"Woolfolk",
    @"Holladay", @"Hornback", @"Moler", @"Bowles", @"Libbey",
    @"Spano", @"Folson", @"Arguelles", @"Burke", @"Rook", @"Timchenko",
    @"Makhmudov(a)", @"Astapenkov(a)", @"Kobilkin(a)", @"Tarasov(a)",
    @"Glushko"
};

@end


