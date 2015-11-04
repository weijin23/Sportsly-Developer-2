//
//  UITextField+utils.h
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

#import <UIKit/UIKit.h>

@interface UITextField (smb_utils)

//text edit
- (void) insertText:(NSString *)text atIndex:(NSUInteger) index NS_AVAILABLE(10_5,2_0);

//text validation
- (BOOL) isReachedAtMaxChars:(NSUInteger) maxValue NS_AVAILABLE(10_5,2_0);
- (BOOL) matchesWithRegularExpression:(NSString*) regEx NS_AVAILABLE(10_5,3_2);    //ICU Regular Expression

- (BOOL) containsValidEmail NS_AVAILABLE(10_5,3_2);
- (BOOL) containsValidPhoneNumber NS_AVAILABLE(10_5,3_2);
- (BOOL) containsValidSSNNumber NS_AVAILABLE(10_5,3_2);

- (BOOL) isCharactersInString:(NSString*)str validForValidatorString:(NSString*)validatorString NS_AVAILABLE(10_5,2_0);    //validator string is a simple character set with valid characters
@end
