//
//  NSData_SHA1.h
//  SwiftyEC
//
//  Created by Akilan Thirunavukka Arasu on 26/06/17.
//  Copyright © 2017 Akilan Thirunavukka Arasu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (NSData_SwiftyECSHA)

- (nonnull NSData*) SwiftyECSHA1;
- (nonnull NSData*) SwiftyECSHA224;
- (nonnull NSData*) SwiftyECSHA256;
- (nonnull NSData*) SwiftyECSHA384;
- (nonnull NSData*) SwiftyECSHA512;

@end
