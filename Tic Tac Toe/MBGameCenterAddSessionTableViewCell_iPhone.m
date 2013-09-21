//
//  MBGameCenterAddSessionTableViewCell_iPhone.h
//  Tic Tac Toe
//
//  Created by Maximilian Brunner on 30.07.13.
//  Copyright (c) 2013 Maximilian Brunner. All rights reserved.
//

#import "MBGameCenterAddSessionTableViewCell_iPhone.h"

@implementation MBGameCenterAddSessionTableViewCell_iPhone

@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)addSession:(UIButton *)sender {
    [delegate addGameCenterSession:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
