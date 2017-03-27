//
//  AKUtilis.m
//  BuoyApp
//
//  Created by Andrii on 3/20/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKUtilis.h"

static  NSString * const akShowIntroController = @"akShowIntroController";
static  NSString * const akLoadDataFromServer = @"akLoadDataFromServer";

bool showIntro() {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults boolForKey:akShowIntroController];
}

void introFinished() {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults setBool:true forKey:akShowIntroController];
}


bool loadedDataFromServer() {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults boolForKey:akLoadDataFromServer];
}

void loadFinished() {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults setBool:true forKey:akLoadDataFromServer];
}
