//
// Created by Dani Postigo on 2/17/14.
//

#import <Foundation/Foundation.h>

@protocol DPBasicOutlineViewDelegate;


@class DPBasicOutlineView;

typedef void (^DPBasicOutlineViewBlock)();
typedef void (^DPBasicOutlineViewRowMouseOverBlock)(DPBasicOutlineView *outlineView, NSInteger rowIndex);


extern NSString *const kDPBasicOutlineViewMouseOverType;
extern NSString *const kDPBasicOutlineViewRowNumber;

@interface DPBasicOutlineView : NSOutlineView {

    BOOL autoexpands;
    IBOutlet NSTreeController *controller;
    __unsafe_unretained id <DPBasicOutlineViewDelegate> outlineDelegate;
    NSMutableDictionary *cellStorage;

    DPBasicOutlineViewBlock onReload;
    DPBasicOutlineViewRowMouseOverBlock onRowOver;
}

@property(nonatomic) BOOL autoexpands;
@property(nonatomic, strong) NSTreeController *controller;
@property(nonatomic, assign) id <DPBasicOutlineViewDelegate> outlineDelegate;
@property(nonatomic, strong) NSMutableDictionary *cellStorage;
@property(nonatomic, copy) DPBasicOutlineViewBlock onReload;
@property(nonatomic, copy) DPBasicOutlineViewRowMouseOverBlock onRowOver;
@end