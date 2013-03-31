//
//  SetCardView.m
//  Matchismo
//
//  Created by nevercry on 13-3-25.
//  Copyright (c) 2013年 nevercry. All rights reserved.
//

#import "SetCardView.h"

@implementation SetCardView

#pragma mark - Initialization

- (void)setup
{
    // do initialization here
}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

- (void)setNumber:(SetNumber)number
{
    _number = number;
    [self setNeedsDisplay];
}

- (void)setSymbol:(SetSymbol)symbol
{
    _symbol = symbol;
    [self setNeedsDisplay];
}

- (void)setShading:(SetShading)shading
{
    _shading = shading;
    [self setNeedsDisplay];
}

- (void)setColor:(SetColor)color
{
    _color = color;
    [self setNeedsDisplay];
}

- (void)setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay];
}

- (UIColor *)cardColor
{
    UIColor *color;
    switch (self.color) {
        case SetColorGreen:
            color = [UIColor greenColor];
            break;
        case SetColorPurple:
            color = [UIColor purpleColor];
            break;
        case SetColorRed:
            color = [UIColor redColor];
            break;
    }
    
    return color;
}


#pragma mark - Drawing

#define CORNER_RADIUS 12.0
#define SYMBOL_X_FACTOR 0.3
#define SYMBOL_Y_FACTOR 0.1
#define PATH_LINEWIDTH 3.0
#define STRIP_DISTANCE_FACTOR 0.1


- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:CORNER_RADIUS];
    
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    if (self.isFaceUp && self.alpha == 1.0) {
        [[UIColor blackColor] setStroke];
        
        roundedRect.lineWidth = PATH_LINEWIDTH;
        [roundedRect stroke];
    }
    
    
    
    
    
    
    if (self.number == SetNumberOne) {
        CGPoint middle = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        [self drawSymbol:self.symbol atPoint:middle];
    } else if (self.number == SetNumberTwo) {
        CGPoint pointOne = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/3);
        CGPoint pointTwo = CGPointMake(self.bounds.size.width/2, self.bounds.size.height*2/3);
        [self drawSymbol:self.symbol atPoint:pointOne];
        [self drawSymbol:self.symbol atPoint:pointTwo];
    } else if (self.number == SetNumberThree) {
        CGPoint pointOne = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/4);
        CGPoint pointTwo = CGPointMake(self.bounds.size.width/2, self.bounds.size.height*2/4);
        CGPoint pointThree = CGPointMake(self.bounds.size.width/2, self.bounds.size.height*3/4);
        [self drawSymbol:self.symbol atPoint:pointOne];
        [self drawSymbol:self.symbol atPoint:pointTwo];
        [self drawSymbol:self.symbol atPoint:pointThree];
    }
    
}

- (void)drawSymbol:(SetSymbol)symbol atPoint:(CGPoint)startPoint
{
    switch (symbol) {
        case SetSymbolDiamond:
            [self drawDiamondAtPoint:startPoint];
            break;
        case SetSymbolSquiggle:
            [self drawSquiggleAtPoint:startPoint];
            break;
        case SetSymbolOval:
            [self drawOvalAtPoint:startPoint];
            break;
        default:
            break;
    }
}


- (void)drawStripInPath:(UIBezierPath *)path atPoint:(CGPoint)startPoint
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    [path addClip];
    
    for (CGFloat beginX = startPoint.x - SYMBOL_X_FACTOR*self.bounds.size.width; beginX < startPoint.x + SYMBOL_X_FACTOR*self.bounds.size.width + STRIP_DISTANCE_FACTOR*self.bounds.size.width; beginX += STRIP_DISTANCE_FACTOR*self.bounds.size.width) {
        [path moveToPoint:CGPointMake(beginX, startPoint.y - SYMBOL_Y_FACTOR*self.bounds.size.height)];
        [path addLineToPoint:CGPointMake(beginX, startPoint.y + SYMBOL_Y_FACTOR*self.bounds.size.height)];
        path.lineWidth = PATH_LINEWIDTH/4;
        [path stroke];
    }
    
    CGContextRestoreGState(context);
}


- (void)drawDiamondAtPoint:(CGPoint)startPoint
{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    
    [path moveToPoint:CGPointMake(startPoint.x , startPoint.y + self.bounds.size.height*SYMBOL_Y_FACTOR)];
    [path addLineToPoint:CGPointMake(startPoint.x + self.bounds.size.width*SYMBOL_X_FACTOR , startPoint.y)];
    [path addLineToPoint:CGPointMake(startPoint.x , startPoint.y - self.bounds.size.height*SYMBOL_Y_FACTOR)];
    [path addLineToPoint:CGPointMake(startPoint.x - self.bounds.size.width*SYMBOL_X_FACTOR , startPoint.y)];
    [path closePath];
    
    path.lineWidth = PATH_LINEWIDTH;
    
    
    [[self cardColor] setStroke];
    [path stroke];
    
    if (self.shading == SetShadingSolid)
    {
        [[self cardColor] setFill];
        [path fill];
    }
    else if (self.shading == SetShadingStriped) {
        [self drawStripInPath:path atPoint:startPoint];
    }
}

- (void)drawSquiggleAtPoint:(CGPoint)startPoint
{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    [path moveToPoint:CGPointMake(startPoint.x - self.bounds.size.width*SYMBOL_X_FACTOR, startPoint.y + self.bounds.size.height*SYMBOL_Y_FACTOR)];
    [path addCurveToPoint:CGPointMake(startPoint.x + self.bounds.size.width*SYMBOL_X_FACTOR, startPoint.y + self.bounds.size.height*SYMBOL_Y_FACTOR)
            controlPoint1:CGPointMake(startPoint.x - self.bounds.size.width*SYMBOL_X_FACTOR/2, startPoint.y)
            controlPoint2:CGPointMake(startPoint.x + self.bounds.size.width*SYMBOL_X_FACTOR/2, startPoint.y + self.bounds.size.height*SYMBOL_Y_FACTOR + self.bounds.size.height*SYMBOL_Y_FACTOR/2)];
    [path addQuadCurveToPoint:CGPointMake(startPoint.x + self.bounds.size.width*SYMBOL_X_FACTOR, startPoint.y - self.bounds.size.height*SYMBOL_Y_FACTOR)
                 controlPoint:CGPointMake(startPoint.x + self.bounds.size.width*SYMBOL_X_FACTOR + self.bounds.size.width*SYMBOL_X_FACTOR/2, startPoint.y)];
    [path addCurveToPoint:CGPointMake(startPoint.x - self.bounds.size.width*SYMBOL_X_FACTOR, startPoint.y - self.bounds.size.height*SYMBOL_Y_FACTOR)
            controlPoint1:CGPointMake(startPoint.x + self.bounds.size.width*SYMBOL_X_FACTOR/2, startPoint.y)
            controlPoint2:CGPointMake(startPoint.x - self.bounds.size.width*SYMBOL_X_FACTOR/2, startPoint.y - self.bounds.size.height*SYMBOL_Y_FACTOR - self.bounds.size.height*SYMBOL_Y_FACTOR/2)];
    [path addQuadCurveToPoint:CGPointMake(startPoint.x - self.bounds.size.width*SYMBOL_X_FACTOR, startPoint.y + self.bounds.size.height*SYMBOL_Y_FACTOR)
                 controlPoint:CGPointMake(startPoint.x - self.bounds.size.width*SYMBOL_X_FACTOR - self.bounds.size.width*SYMBOL_X_FACTOR/2, startPoint.y)];
    
    [path closePath];
    
    
    path.lineWidth = PATH_LINEWIDTH;
    [[self cardColor] setStroke];
    [path stroke];
    
    if (self.shading == SetShadingSolid)
    {
        [[self cardColor] setFill];
        [path fill];
    }
    else if (self.shading == SetShadingStriped) {
        [self drawStripInPath:path atPoint:startPoint];
    }

}

- (void)drawOvalAtPoint:(CGPoint)startPoint
{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    [path moveToPoint:CGPointMake(startPoint.x - self.bounds.size.width*SYMBOL_X_FACTOR, startPoint.y + self.bounds.size.height*SYMBOL_Y_FACTOR)];
    [path addLineToPoint:CGPointMake(startPoint.x + self.bounds.size.width*SYMBOL_X_FACTOR, startPoint.y + self.bounds.size.height*SYMBOL_Y_FACTOR)];
    [path addQuadCurveToPoint:CGPointMake(startPoint.x + self.bounds.size.width*SYMBOL_X_FACTOR, startPoint.y - self.bounds.size.height*SYMBOL_Y_FACTOR)
                 controlPoint:CGPointMake(startPoint.x + self.bounds.size.width*SYMBOL_X_FACTOR + self.bounds.size.width*SYMBOL_X_FACTOR/2, startPoint.y)];
    [path addLineToPoint:CGPointMake(startPoint.x - self.bounds.size.width*SYMBOL_X_FACTOR, startPoint.y -self.bounds.size.height*SYMBOL_Y_FACTOR)];
    [path addQuadCurveToPoint:CGPointMake(startPoint.x - self.bounds.size.width*SYMBOL_X_FACTOR, startPoint.y + self.bounds.size.height*SYMBOL_Y_FACTOR)
                 controlPoint:CGPointMake(startPoint.x - self.bounds.size.width*SYMBOL_X_FACTOR - self.bounds.size.width*SYMBOL_X_FACTOR/2, startPoint.y)];
    
    [path closePath];
    
    path.lineWidth = PATH_LINEWIDTH;
    
    [[self cardColor] setStroke];
    [path stroke];
    
    if (self.shading == SetShadingSolid)
    {
        [[self cardColor] setFill];
        [path fill];
    }
    else if (self.shading == SetShadingStriped) {
        [self drawStripInPath:path atPoint:startPoint];
    }
}

        

@end
