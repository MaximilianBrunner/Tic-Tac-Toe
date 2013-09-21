//
//  MBGameCenterSessionTableViewCell_iPhone.m
//  Tic Tac Toe
//
//  Created by Maximilian Brunner on 30.07.13.
//  Copyright (c) 2013 Maximilian Brunner. All rights reserved.
//

#import "MBGameCenterSessionTableViewCell_iPhone.h"

@implementation MBGameCenterSessionTableViewCell_iPhone

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}

- (void)setPeerName:(NSString *)name {
    if (![name isEqualToString:[peerNameLabel text]]) {
        [peerNameLabel setText:name];
    }
}

- (NSString *)peerName {
    return [peerNameLabel text];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
