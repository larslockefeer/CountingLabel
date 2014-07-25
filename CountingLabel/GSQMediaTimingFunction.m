//
//  GSQMediaTimingFunction.m
//  CoutingLabel
//
//  Created by Lars Lockefeer on 16/07/14.
//
//

#import "GSQMediaTimingFunction.h"

// start and end point are implicitly (0.0, 0.0) and (1.0, 1.0)
static const CGFloat _c0x = 0.0;
static const CGFloat _c0y = 0.0;
static const CGFloat _c3x = 1.0;
static const CGFloat _c3y = 1.0;

@implementation GSQMediaTimingFunction {
    CGFloat _c1x;
    CGFloat _c1y;
    CGFloat _c2x;
    CGFloat _c2y;
    
    CGFloat *_coefficientsX;
    CGFloat *_coefficientsY;
}

+ (id) functionWithName:(NSString *)name
{
    /* None of these were documented except 'default'. */
    /* see: http://netcetera.org/camtf-playground.html */
    
    if ([name isEqualToString: kCAMediaTimingFunctionDefault])
    {
        /* netcetera.org source claims this one was misdocumented.
         So, we use their numbers. */
        return [self functionWithControlPoints: 0.25
                                              : 0.1
                                              : 0.25
                                              : 1.0];
    }
    if ([name isEqualToString: kCAMediaTimingFunctionEaseInEaseOut])
    {
        return [self functionWithControlPoints: 0.42
                                              : 0.0
                                              : 0.58
                                              : 1.0];
    }
    if ([name isEqualToString: kCAMediaTimingFunctionEaseIn])
    {
        return [self functionWithControlPoints: 0.42
                                              : 0.0
                                              : 1.0
                                              : 1.0];
    }
    if ([name isEqualToString: kCAMediaTimingFunctionEaseOut])
    {
        return [self functionWithControlPoints: 0.0
                                              : 0.0
                                              : 0.58
                                              : 1.0];
    }
    if ([name isEqualToString: kCAMediaTimingFunctionLinear])
    {
        return [self functionWithControlPoints: 0.0
                                              : 0.0
                                              : 1.0
                                              : 1.0];
    }
    return nil;
}

+ (instancetype) functionWithControlPoints: (CGFloat)c1x
                                          : (CGFloat)c1y
                                          : (CGFloat)c2x
                                          : (CGFloat)c2y
{
    return [[GSQMediaTimingFunction alloc] initWithControlPoints: c1x
                                                               : c1y
                                                               : c2x
                                                               : c2y];
}

- (instancetype) initWithControlPoints: (CGFloat)c1x
                                      : (CGFloat)c1y
                                      : (CGFloat)c2x
                                      : (CGFloat)c2y
{
    self = [super init];
    if(!self)
        return nil;
    
    _c1x = c1x;
    _c1y = c1y;
    _c2x = c2x;
    _c2y = c2y;
    
    // calculate coefficients
    _coefficientsX = calloc(4, sizeof(CGFloat));
    _coefficientsX[0] = _c0x; // t^0
    _coefficientsX[1] = -3.0*_c0x + 3.0*_c1x; // t^1
    _coefficientsX[2] = 3.0*_c0x - 6.0*_c1x + 3.0*_c2x;  // t^2
    _coefficientsX[3] = -_c0x + 3.0*_c1x - 3.0*_c2x + _c3x; // t^3
    
    _coefficientsY = calloc(4, sizeof(CGFloat));
    _coefficientsY[0] = _c0y; // t^0
    _coefficientsY[1] = -3.0*_c0y + 3.0*_c1y; // t^1
    _coefficientsY[2] = 3.0*_c0y - 6.0*_c1y + 3.0*_c2y;  // t^2
    _coefficientsY[3] = -_c0y + 3.0*_c1y - 3.0*_c2y + _c3y; // t^3
    
    return self;
}

- (void)getControlPointAtIndex: (size_t)index values: (CGFloat*)ptr
{
    switch (index)
    {
        case 0:
            ptr[0] = _c0x;
            ptr[1] = _c0y;
            break;
        case 1:
            ptr[0] = _c1x;
            ptr[1] = _c1y;
            break;
        case 2:
            ptr[0] = _c2x;
            ptr[1] = _c2y;
            break;
        case 3:
            ptr[0] = _c3x;
            ptr[1] = _c3y;
            break;
    }
}

static inline CGFloat evaluateAtParameterWithCoefficients(CGFloat t, CGFloat coefficients[])
{
    return coefficients[0] + t*coefficients[1] + t*t*coefficients[2] + t*t*t*coefficients[3];
}

static inline CGFloat evaluateDerivationAtParameterWithCoefficients(CGFloat t, CGFloat coefficients[])
{
    return coefficients[1] + 2*t*coefficients[2] + 3*t*t*coefficients[3];
}

static inline CGFloat calcParameterViaNewtonRaphsonUsingXAndCoefficientsForX(CGFloat x, CGFloat coefficientsX[])
{
    // see http://en.wikipedia.org/wiki/Newton's_method
    
    // start with X being the correct value
    CGFloat t = x;
    
    // iterate several times
    for(int i = 0; i < 10; i++)
    {
        CGFloat x2 = evaluateAtParameterWithCoefficients(t, coefficientsX) - x;
        CGFloat d = evaluateDerivationAtParameterWithCoefficients(t, coefficientsX);
        
        CGFloat dt = x2/d;
        
        t = t - dt;
    }
    
    return t;
}

static inline CGFloat calcParameterUsingXAndCoefficientsForX (CGFloat x, CGFloat coefficientsX[])
{
    // for the time being, we'll guess Newton-Raphson always
    // returns the correct value.
    
    // if we find it doesn't find the solution often enough,
    // we can add additional calculation methods.
    
    CGFloat t = calcParameterViaNewtonRaphsonUsingXAndCoefficientsForX(x, coefficientsX);
    
    return t;
}

- (CGFloat) evaluateYAtX: (CGFloat)x
{
    if (x == 0 || x == 1) {
        return x;
    }
    
    CGFloat t = calcParameterUsingXAndCoefficientsForX(x, _coefficientsX);
    CGFloat y = evaluateAtParameterWithCoefficients(t, _coefficientsY);
    
    return y;
}

@end
