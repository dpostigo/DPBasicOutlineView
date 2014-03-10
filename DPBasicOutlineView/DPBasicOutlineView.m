//
// Created by Dani Postigo on 2/17/14.
//

#import <DPKit-Utils/NSObject+CallSelector.h>
#import "DPBasicOutlineView.h"
#import "NSOutlineView+DPKit.h"
#import "DPBasicOutlineViewDelegate.h"
#import "NSWindow+DPKit.h"

@implementation DPBasicOutlineView {
    BOOL isAwake;
    BOOL isCellsAwake;
}

@synthesize autoexpands;
@synthesize controller;

@synthesize outlineDelegate;
@synthesize cellStorage;

@synthesize onReload;

@synthesize onRowOver;
NSString *const kDPBasicOutlineViewMouseOverType = @"DPBasicOutlineViewMouseOverType";
NSString *const kDPBasicOutlineViewRowNumber = @"DPBasicOutlineViewRowNumber";

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

    if (onReload) {
        onReload();
    }
}


- (void) updateTrackingAreas {
    [super updateTrackingAreas];

    NSArray *trackingAreas = [NSArray arrayWithArray: self.trackingAreas];
    for (NSTrackingArea *area in trackingAreas) {
        [self removeTrackingArea: area];
    }

    for (int j = 0; j < [self numberOfRows]; j++) {
        NSRect rect = [self rectOfRow: j];
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
        [dictionary setObject: @"Row" forKey: kDPBasicOutlineViewMouseOverType];
        [dictionary setObject: [NSNumber numberWithInteger: j] forKey: kDPBasicOutlineViewRowNumber];

        NSTrackingArea *trackingArea = [[NSTrackingArea alloc] initWithRect: rect
                options: NSTrackingActiveInKeyWindow | NSTrackingMouseEnteredAndExited
                owner: self
                userInfo: dictionary];
        [self addTrackingArea: trackingArea];
    }

}


- (void) mouseEntered: (NSEvent *) theEvent {
    [super mouseEntered: theEvent];

    NSDictionary *userInfo = theEvent.trackingArea.userInfo;
    if ([userInfo objectForKey: kDPBasicOutlineViewMouseOverType]) {
        NSString *type = [userInfo objectForKey: kDPBasicOutlineViewMouseOverType];
        if ([type isEqualToString: @"Row"]) {
            NSInteger integer = [[userInfo objectForKey: kDPBasicOutlineViewRowNumber] integerValue];

            NSPoint point = theEvent.locationInWindow;
            point = [self convertPoint: point fromView: self.window.contentAsView];
            // CGFloat height = self.enclosingScrollView.frame.size.height;

            if (point.y < self.enclosingScrollView.frame.size.height) {

                [self mouseEnteredRow: integer];
            }

        }
    }
}


- (void) mouseEnteredRow: (NSInteger) row {
    if (onRowOver) {
        onRowOver(self, row);
    }
}

- (void) enableMouseOvers {
}

- (void) awakeFromNib {
    [super awakeFromNib];
    isAwake = YES;

    if (!isCellsAwake) {
        [self awakeCells];
        isCellsAwake = YES;
    }
}


- (void) awakeCells {
    cellStorage = [[NSMutableDictionary alloc] init];

    [self makeViewWithIdentifier: @"HeaderCell" owner: self.cellStorage];
    NSView *dataCellPrototype = [self makeViewWithIdentifier: @"DataCell" owner: self.cellStorage];
    [cellStorage setObject: dataCellPrototype forKey: @"dataCell"];

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


- (id) makeViewWithIdentifier: (NSString *) identifier owner: (id) owner {
    owner = self.cellStorage;
    return [super makeViewWithIdentifier: identifier owner: owner];
}

@end