//
// Created by Dani Postigo on 2/17/14.
//

#import <DPKit/NSObject+CallSelector.h>
#import "DPBasicOutlineView.h"
#import "NSOutlineView+DPKit.h"
#import "DPBasicOutlineViewDelegate.h"

@implementation DPBasicOutlineView

@synthesize autoexpands;
@synthesize controller;

@synthesize outlineDelegate;

- (id) initWithCoder: (NSCoder *) coder {
    self = [super initWithCoder: coder];
    if (self) {
        autoexpands = YES;
    }

    return self;
}

- (void) reloadData {
    [super reloadData];

    if (autoexpands) {
        [self expandAllItems];
    }
}


- (void) keyDown: (NSEvent *) theEvent {
    BOOL success = [self forwardSelector: @selector(outlineDidKeyDown:) delegate: self.outlineDelegate object: theEvent];
    if (!success) {
        [super keyDown: theEvent];
    }
}


//- (void) keyDownWithKey: (unichar) key {
//    if (key == NSDeleteCharacter) {
//
//    }
//}

- (void) deleteSelectedItem {
    if ([self numberOfSelectedRows] == 0) return;
    if (self.selectedRow == -1) return;

   // NSInteger index = [self selectedRow];
}

- (void) doCommandBySelector: (SEL) aSelector {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [super doCommandBySelector: aSelector];
}


@end