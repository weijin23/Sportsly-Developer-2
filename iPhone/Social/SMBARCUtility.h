//
//  SMBARCUtility.h
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

#ifndef Utility_SMBARCUtility_h
#define Utility_SMBARCUtility_h

#if __has_feature(objc_arc)

#define HAS_ARC 1
#define RETAIN(_o) (_o)
#define RELEASE(_o) 
#define AUTORELEASE(_o) (_o)
#define CFTYPECAST(_o) (__bridge _o)
#define TYPECAST(_o) (__bridge_transfer _o)
#define CFRELEASE(_o) CFRelease(_o)
#define DEALLOC(_o)

#else

#define HAS_ARC 0
#define RETAIN(_o) [(_o) retain]
#define RELEASE(_o) [(_o) release]
#define AUTORELEASE(_o) [(_o) autorelease]
#define CFTYPECAST(_o) (_o)
#define TYPECAST(_o) (_o)
#define CFRELEASE(_o) CFRelease(_o)
#define DEALLOC(_o) [_o dealloc]


#endif
#endif
