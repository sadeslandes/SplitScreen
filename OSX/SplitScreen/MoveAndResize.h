//
//  MoveAndResize.h
//  SplitScreen
//
//  Created by Evan Thompson on 11/13/15.
//  Copyright © 2015 SplitScreen. All rights reserved.
//

#ifndef MoveAndResize_h
#define MoveAndResize_h

#include <stdio.h>
#include <Carbon/Carbon.h>
#include <unistd.h>

void move_focused_window(float x, float y);

void resize_focused_window(float x, float y, float x1, float y1);

#endif /* MoveAndResize_h */
