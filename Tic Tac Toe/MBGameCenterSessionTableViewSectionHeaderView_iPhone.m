//
//  MBGameCenterSessionTableViewSectionHeaderView_iPhone.m
//  Tic Tac Toe
//
//  Created by Maximilian Brunner on 21.09.13.
//  Copyright (c) 2013 Maximilian Brunner. All rights reserved.
//

#import "MBGameCenterSessionTableViewSectionHeaderView_iPhone.h"

@implementation MBGameCenterSessionTableViewSectionHeaderView_iPhone

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSectionName:(NSString *)name {
    if (![name isEqualToString:[sectionNameLabel text]]) {
        [sectionNameLabel setText:name];
    }
}

- (NSString *)sectionName {
    return [sectionNameLabel text];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
