//
//  UITextField+utils.m
//  Utility
//
//  Created by SMB on 23/04/12.
//  Copyright (C) 2012 Soumen Bhuin. All rights reserved.

//  This software is provided 'as-is', without any express or implied
//  warranty. In no event will the authors be held liable for any damages
//  arising from the use of this software. Permission is granted to anyone to
//  use this software for any purpose, including commercial applications, and to
//  alter it and redistribute it freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//     claim that you wrote the original software. If you use this software
//     in a product, an acknowledgment in the product documentation would be
//     appreciated but is not required.
//  2. Altered source versions must be plainly marked as such, and must not be
//     misrepresented as being the original software.
//  3. This notice may not be removed or altered from any source
//     distribution.
//

#import "UITextField+smb_utils.h"
#import "SMBARCUtility.h"

@implementation UITextField (smb_utils)

#pragma mark - Text Edit
- (void) insertText:(NSString *)text atIndex:(NSUInteger) index {
    NSMutableString *mStr = [self.text mutableCopy];
    [mStr insertString:text atIndex:index];
    [self setText:mStr];
    RELEASE(mStr);
}

#pragma mark - Maximum Character checking

- (BOOL) isReachedAtMaxChars:(NSUInteger) maxValue {
    return [self.text length]>=maxValue;
}

#pragma mark - Text Validation
- (BOOL) matchesWithRegularExpression:(NSString*) regEx {
    NSRange r = [self.text rangeOfString:regEx options:NSRegularExpressionSearch];
    if (r.location == NSNotFound) {
        return NO;
    }
    else if ([self.text length]>r.length) {
        return NO;
    }
    return YES;
}

- (BOOL) containsValidEmail {
    NSString *regEx = @"[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,4}";
    return [self matchesWithRegularExpression:regEx];
}

- (BOOL) containsValidPhoneNumber {
    NSString *regEx = @"^\\+(?:[0-9] ?){6,14}[0-9]$";
    return [self matchesWithRegularExpression:regEx];
}

- (BOOL) containsValidSSNNumber {
    NSString *regEx = @"[0-9]{3}-[0-9]{2}-[0-9]{4}";
    return [self matchesWithRegularExpression:regEx];
}

//use in UITextFieldDelegate method "textField:shouldChangeCharactersInRange:replacementString:" to validate each character entered
- (BOOL) isCharactersInString:(NSString*)string validForValidatorString:(NSString*)validatorString {
    
    NSCharacterSet *unacceptedCharSet = [[NSCharacterSet characterSetWithCharactersInString:validatorString] invertedSet];    //unacceptable characters
    
    if ([[string componentsSeparatedByCharactersInSet:unacceptedCharSet] count] > 1) return NO;
    
    return YES;
}

@end
