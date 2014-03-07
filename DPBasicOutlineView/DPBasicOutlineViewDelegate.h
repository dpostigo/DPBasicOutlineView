//
// Created by Dani Postigo on 2/17/14.
//

#import <Foundation/Foundation.h>

@protocol DPBasicOutlineViewDelegate <NSObject>

@optional

- (void) outlineDidReload;
- (void) outlineDidKeyDown: (NSEvent *) theEvent;
@end