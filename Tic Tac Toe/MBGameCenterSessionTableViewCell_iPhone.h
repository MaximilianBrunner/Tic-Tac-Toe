//
//  MBGameCenterSessionTableViewCell_iPhone.h
//  Tic Tac Toe
//
//  Created by Maximilian Brunner on 30.07.13.
//  Copyright (c) 2013 Maximilian Brunner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBGameCenterSessionTableViewCell_iPhone : UITableViewCell {
    IBOutlet UILabel *peerNameLabel;
}

- (void)setPeerName:(NSString *)name;
- (NSString *)peerName;

@end
