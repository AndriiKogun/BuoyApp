//
//  AKUtilis.m
//  BuoyApp
//
//  Created by Andrii on 3/20/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKUtilis.h"

static  NSString * const akShowIntroController = @"IntroController";

BOOL showIntro() {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults boolForKey:akShowIntroController];
}

void saveIntroAppearance(BOOL state) {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults setBool:state forKey:akShowIntroController];
}
